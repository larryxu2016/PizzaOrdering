/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pizza.controller.command.menu;

import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONException;
import org.json.JSONObject;
import pizza.business.Cart;
import pizza.controller.command.Command;

/**
 *
 * @author LarryXu
 */
public class AddItemCommand implements Command {
    
    private Cart cart;
    private HttpServletRequest request;
    private HttpServletResponse response;
    private JSONObject lineItems;
    private JSONObject toppingListCache = null;

    public AddItemCommand(HttpServletRequest request,
            HttpServletResponse response) {
        this.request = request;
        this.response = response;
        toppingListCache = null;
    }

    private void getParams()
            throws JSONException {
        int min = 300;
        int max = 1000;
        String random;
        random = Double.toString(Math.random() * ((max - min) + 1) + min);
        //Preare parameters
        JSONObject toppingData = null;

        String itemType = (String)request.getParameter("item_type");
        if ("PIZZAS".equals(itemType)) {
            toppingData = new JSONObject(request.getParameter("toppings"));

            String size = ((String)request.getParameter("item_price")).split(" ")[0].trim();

            if ("Gluten-Free".equals(size)) {
                toppingData.getJSONObject("Crust Style").put("ingred_name", size.toUpperCase());
                toppingData.getJSONObject("Size").put("ingred_name", "SMALL");
            }
            else if ("Thin-Crust".equals(size)) {
                toppingData.getJSONObject("Crust Style").put("ingred_name", "THIN");
                toppingData.getJSONObject("Size").put("ingred_name", "LARGE");
            }
            else if ("Extra".equals(size)) {
                toppingData.getJSONObject("Size").put("ingred_name", "EXTRA LARGE");
            }
            else {
                toppingData.getJSONObject("Size").put("ingred_name", size.toUpperCase());
            }     
        }
        String[] priceSize = ((String)request.getParameter("item_price")).split(" "); 
        String price = priceSize[priceSize.length-1].trim();
        lineItems = new JSONObject();
        lineItems.put("line_id", random);
        lineItems.put("item_id", request.getParameter("item_id"));
        lineItems.put("item_name", request.getParameter("item_name"));
        lineItems.put("item_type", itemType);
        lineItems.put("item_toppings", toppingData);
        lineItems.put("item_qty", request.getParameter("item_qty"));
        lineItems.put("item_prices", new JSONObject(request.getParameter("item_size_price")));
        lineItems.put("item_price", price);

        String user = (String)request.getSession().getAttribute("user");
        if (user != null) {
            JSONObject userJSON = new JSONObject(user);
            String userKey = (String)userJSON.keys().next();
            JSONObject json = userJSON.getJSONObject(userKey);
            if (json.has("cart")) {
                cart = new Cart(json.getJSONArray("cart").toString(), json.getInt("count"), Float.parseFloat((String)json.get("total")));
            }
            else {
                cart = new Cart();
            }
            if (json.has("toppingListCache")) {
                toppingListCache = json.getJSONObject("toppingListCache");
            }
            else {
                toppingListCache = new JSONObject();
            }
        }
        else if (user == null) {
            cart = new Cart();
            toppingListCache = new JSONObject();
        }

        JSONObject toppings = new JSONObject();
        toppings.put("addedToppings", toppingData);
        toppings.put("extraToppings", new JSONObject());

        toppingListCache.put(random, toppings);
    }

    private void saveResults() 
            throws JSONException, IOException {
        
        String user = (String)request.getSession().getAttribute("user");
        JSONObject userJSON = null;
        JSONObject json;
        if (user != null) {
            userJSON = new JSONObject(user);
            String userKey = (String)userJSON.keys().next();
            json = userJSON.getJSONObject(userKey);

            json.put("cart", cart.getItems());
            json.put("toppingListCache", toppingListCache);
            json.put("total", String.format("%.2f", cart.getTotalPrice()));
            json.put("count", cart.getItemCount());

            userJSON.put(userKey, json);
        } else if (user == null) {
            json = new JSONObject();
            json.put("cart", cart.getItems());
            json.put("toppingListCache", toppingListCache);

            String userKey = (String)request.getSession().getId();
            userJSON = new JSONObject();
            userJSON.put(userKey, json);
        }
        request.getSession().setAttribute("user", (userJSON != null) ? userJSON.toString() : "");
        request.getSession().setAttribute("line_num", cart.getItems().length()-1);

        JSONObject result = new JSONObject();
        result.put("item_count", cart.getItemCount());
        result.put("total_price", String.format("%.2f", cart.getTotalPrice()));
        response.getWriter().print(result.toString());
    }
    
    @Override
    public void execute() {
        try {
            getParams();
            cart.addItem(lineItems);
            saveResults();
        } catch (JSONException ex) {
            Logger.getLogger(AddItemCommand.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(AddItemCommand.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
