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
 * @author mycomputer
 */
public class ItemDB {
//    private final JSONObject itemList;
//    private final ArrayList<String> types;
    private final JSONObject subTypesMap;
    
    private final ArrayList<String> itemIDs;
    
    private final JSONArray types;
    private final JSONObject subTypes;
    private final JSONObject items;
    private final JSONObject ingredients;
    private final JSONObject prices;

    public ItemDB() {
//        itemList = new JSONObject();
//        types = new ArrayList<>();
        subTypesMap = new JSONObject();
        itemIDs = new ArrayList<>();

        types = new JSONArray();
        subTypes = new JSONObject();
        items = new JSONObject();
        prices = new JSONObject();
        ingredients = new JSONObject();
    }
    
    public void getTypes() {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        String query = "SELECT * FROM type";

        try {
            ps = connection.prepareStatement(query);
            rs = ps.executeQuery();
           
            while (rs.next()) {
                String type = rs.getString("type_name"); 
//                itemList.put(type, new JSONObject());
//                types.add(type);
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
                    subTypesMap.put(subType, type);
                    items.put(subType, new JSONArray());
//                    itemList.getJSONObject(type).put(subtype, new JSONArray());
                    
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
    
    public void getItems() {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        String query = "SELECT * FROM item order by item_order";
        
        getTypes();
        getSubTypes();
        
        try {
            ps = connection.prepareStatement(query);
            rs = ps.executeQuery();
            
            while (rs.next()) {

                String subType = rs.getString("item_type");
//                String type = subTypes.get(subType);
//                JSONObject jsonType = itemList.getJSONObject(type);
//                JSONArray jsonSubTypes = jsonType.getJSONArray(subType);
                
                JSONObject itemDescriptions = new JSONObject();
                String itemID = rs.getString("item_id");
                String itemName = rs.getString("item_name");
                
                if (subTypesMap.get(subType).equals("PIZZAS")) {
                    CustomizationDB custDB = new CustomizationDB();
                    custDB.getIngredients(Integer.parseInt(itemID));
                    ingredients.put(itemName, custDB.getAddedToppings());
                }

                itemIDs.add(itemID);
                itemDescriptions.put("item_id", itemID);
                itemDescriptions.put("item_name", itemName);
//                    itemDescriptions.put("item_desc", rs.getString("item_description"));
//                    JSONObject item = new JSONObject();
//                    item.put(itemName, itemDescriptions);
                
                items.getJSONArray(subType).put(itemDescriptions);
            }
            
            getPrices();
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
    
    public void getPrices() {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        String query = "SELECT * FROM price where item_id = ?";
        try {
            for (String itemID : itemIDs) {
                ps = null;
                ps = connection.prepareStatement(query);
                
                ps.setString(1, itemID);
                rs = ps.executeQuery();
                prices.put(itemID, new JSONObject());
                while (rs.next()) {
                    JSONObject priceDetails;
                    priceDetails = prices.getJSONObject(itemID);
                    priceDetails.put(rs.getString("price_desc"), String.format("%.2f", rs.getFloat("price")));
                }
            }
        }
        catch (SQLException e) {
            String err = e.getMessage();
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
    
    public JSONObject getSubTypeMap() {
        return subTypesMap;
    }

    public JSONObject getItemList() {
        return items;
    }
        
    public JSONObject getPriceList() {
        return prices;
    }
    
    public JSONObject getIngredientList() {
        return ingredients;
    }
}
