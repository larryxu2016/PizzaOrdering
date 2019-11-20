/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pizza.data;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author LarryXu
 */
public class CustomizationDB {
    private final ArrayList<String> itemIDs;

    private final JSONArray types;
    private final HashMap<String, String> subTypesMap;
    private final JSONObject subTypes;
    private final JSONObject items;
    private final JSONObject addedToppings;
    private final JSONObject addedToppingList;

    public CustomizationDB () {
        itemIDs = new ArrayList<>();

        types = new JSONArray();
        subTypes = new JSONObject();
        subTypesMap = new HashMap<>();
        items = new JSONObject();
        addedToppings = new JSONObject();
        addedToppingList = new JSONObject();
    }
    
    public void getTypes() {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        String query = "SELECT subtype_name FROM subtype where subtype_parent = ?";

        try {
            ps = connection.prepareStatement(query);
            ps.setString(1, "CUSTOMIZATION");
            rs = ps.executeQuery();
           
            while (rs.next()) {
                String type = rs.getString("subtype_name");
                types.put(type);
            }
        } catch (SQLException e) {
            String err = e.getMessage();
        } finally {
            DBUtil.closeResultSet(rs);
            DBUtil.closePreparedStatement(ps);
            pool.freeConnection(connection);
        }
    }
    
    public void getSubTypes() {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        String query = "SELECT subtype_name FROM subtype where subtype_parent = ? order by subtype_order";

        try {
            int len = types.length();
            for (int i = 0; i < len; i++) {
                ps = null;
                ps = connection.prepareStatement(query);
                
                String type = types.getString(i);
                ps.setString(1, type);
                rs = ps.executeQuery();
                
                JSONArray jsonSubTypes = new JSONArray();
                while (rs.next()) {
                    String subType = rs.getString("subtype_name");
                    items.put(subType, new JSONArray());
                    subTypesMap.put(subType, type);
                    jsonSubTypes.put(subType);
                }
                subTypes.put(type, jsonSubTypes);
            }
        } catch (SQLException e) {
            String err = e.getMessage();
        }  catch (JSONException ex) {
            Logger.getLogger(ItemDB.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            DBUtil.closeResultSet(rs);
            DBUtil.closePreparedStatement(ps);
            pool.freeConnection(connection);
        }
    }
    
    public void getToppings() {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        String query = "SELECT * FROM ingredient";
        
        getTypes();
        getSubTypes();
        
        try {
            ps = connection.prepareStatement(query);
            rs = ps.executeQuery();
            
            while (rs.next()) {
                String subType = rs.getString("ingred_type");               
                String type = subTypesMap.get(subType);
                String ingredID = rs.getString("ingred_id");
                String ingredName = rs.getString("ingred_name");
                
                JSONObject addedToppingsDetail = new JSONObject();
                
                if (type.equals("INSTRUCTIONS") || subType.equals("Cheese Amount")) {
                    items.getJSONArray(subType).put(ingredName);
                    if (ingredName.equals("ORIGINAL") ||
                        ingredName.equals("NORMAL") ||
                        ingredName.equals("LARGE") ) {
                        addedToppings.put(subType, addedToppingsDetail);
                        addedToppings.getJSONObject(subType).put("id", ingredID);
                        addedToppings.getJSONObject(subType).put("ingred_name", ingredName);
                        addedToppingList.put(subType, addedToppingsDetail);
                        addedToppingList.getJSONObject(subType).put("id", ingredID);
                        addedToppingList.getJSONObject(subType).put("ingred_name", ingredName);
                    }
                }
                else {
                    JSONObject itemDescriptions = new JSONObject();
                    itemDescriptions.put("ingred_id", ingredID);
                    itemDescriptions.put("ingred_name", ingredName);
                    items.getJSONArray(subType).put(itemDescriptions);
                    addedToppingList.put(ingredName, addedToppingsDetail);
                    addedToppingList.getJSONObject(ingredName).put("id", ingredID);
                    addedToppingList.getJSONObject(ingredName).put("qty", 0);
                    addedToppingList.getJSONObject(ingredName).put("pos", "both");
                    addedToppingList.getJSONObject(ingredName).put("price", String.format("%.2f", rs.getFloat("ingred_unit_price")));
                }

            }
            
        } catch (SQLException e) {
            String err = e.getMessage();
        } catch (JSONException ex) {
            Logger.getLogger(ItemDB.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            DBUtil.closeResultSet(rs);
            DBUtil.closePreparedStatement(ps);
            pool.freeConnection(connection);
        }
    }
    
    public void getIngredients(int id) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        String query = "SELECT r.ingred_id, i.ingred_name FROM recipe r inner join ingredient i on r.ingred_id = i.ingred_id inner join item it on r.item_id = it.item_id where r.item_id = ?";
        
        getToppings();
        
        try {
            ps = connection.prepareStatement(query);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            
            while (rs.next()) {
                String ingredID = rs.getString("ingred_id");
                String ingredName = rs.getString("ingred_name");
//                addedToppingList.getJSONObject(ingredName).put("qty", 1);
                addedToppings.put(ingredName, new JSONObject());
                addedToppings.getJSONObject(ingredName).put("id", ingredID);
                addedToppings.getJSONObject(ingredName).put("qty", 1);
                addedToppings.getJSONObject(ingredName).put("pos", "both");
            }
            
        } catch (SQLException e) {
            String err = e.getMessage();
            e.printStackTrace();
        } catch (JSONException ex) {
            Logger.getLogger(ItemDB.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            DBUtil.closeResultSet(rs);
            DBUtil.closePreparedStatement(ps);
            pool.freeConnection(connection);
        }
    }
//    public JSONObject getItemList() {
//        return itemList;
//    } 
    public JSONArray getTypeList() {
        return types;
    }

    public JSONObject getSubTypeList() {
        return subTypes;
    }

    public JSONObject getItemList() {
        return items;
    }
    
    public JSONObject getAddedToppings() {
        return addedToppings;
    }
    public JSONObject getAddedToppingList() {
        return addedToppingList;
    }

}
