/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pizza.business;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author LarryXu
 */
public class Cart {
    private JSONArray items;
    private JSONObject toppingListCache;
    private int itemCount;
    private float totalPrice;

    public Cart() {
        items = new JSONArray();
        itemCount = 0;
        totalPrice = 0.00f;
    }
    
    public Cart(String items, int itemCount, float totalPrice)
            throws JSONException {
        this.items = new JSONArray(items);
        this.totalPrice = totalPrice;
        this.itemCount = itemCount;
    }

    public void addItem(JSONObject lineItem)
            throws JSONException {
        int qty = lineItem.getInt("item_qty");
        float price = Float.parseFloat(lineItem.getString("item_price"));
        totalPrice +=  qty * price;
        itemCount += qty;
        items.put(lineItem);
    }
    
    public void changeItemCount(JSONObject lineItem, JSONObject params) 
            throws JSONException {
        int oldCount = lineItem.getInt("item_qty");
        int itemQty = Integer.parseInt(params.getString("item_qty"));

        this.itemCount = this.itemCount - oldCount + itemQty; 
        lineItem.put("item_qty", itemQty);

        float item_price = Float.parseFloat(lineItem.getString("item_price"));
        float oldSubTotal = oldCount * item_price;
        float newSubTotal = itemQty * item_price;
        totalPrice = totalPrice - oldSubTotal + newSubTotal;
    }
    
    public void removeItem(JSONObject lineItem, JSONObject params) 
        throws JSONException {
        
        float item_price = Float.parseFloat(lineItem.getString("item_price"));
        float subTotal = item_price * Integer.parseInt(params.getString("item_qty"));
        totalPrice -= subTotal;
        itemCount -= Integer.parseInt(params.getString("item_qty"));
        
        int line_num = Integer.parseInt(params.getString("line_num"));
        items.remove(line_num);
    }

    public int getItemCount() {
        return itemCount;
    }
    
    public JSONArray getItems() {
        return items;
    }

    public float getTotalPrice() {
        return totalPrice;
    }
}
