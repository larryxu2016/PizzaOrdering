/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pizza.controller.command.customization;

import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONException;
import org.json.JSONObject;
import pizza.business.Pizza;
import pizza.controller.command.Command;

/**
 *
 * @author LarryXu
 */
public class RemoveToppingCommand implements Command {

    private Pizza pizza;
    private HttpServletRequest request;
    private HttpServletResponse response;
    private JSONObject params;

    public RemoveToppingCommand(HttpServletRequest request,
            HttpServletResponse response) {
        this.request = request;
        this.response = response;
    }

    private void getParams(String user) 
            throws JSONException {
        JSONObject userJSON = new JSONObject(user);
        String userKey = (String)userJSON.keys().next();
        JSONObject json = userJSON.getJSONObject(userKey);
        JSONObject line_item = 
            json.getJSONArray("cart").getJSONObject(
                Integer.parseInt(request.getParameter("line_num")));
        String line_id = line_item.getString("line_id");
        JSONObject toppingListCache = 
            json.getJSONObject("toppingListCache")
                .getJSONObject(line_id);
        pizza = 
            new Pizza(toppingListCache.getJSONObject("addedToppings"),
                      toppingListCache.getJSONObject("extraToppings"),
                      new JSONObject(
                          (String)request.getSession().getAttribute("addedToppingList")),
                      line_item,
                      Integer.parseInt(
                          request.getParameter("added_topping_count")));

        params = new JSONObject();
        params.put("topping_name", request.getParameter("topping_name"));
    }

    private void saveResults(String user) 
            throws JSONException, IOException  {
                JSONObject userJSON = new JSONObject(user);
        String userKey = (String)userJSON.keys().next();
        JSONObject json = userJSON.getJSONObject(userKey);

        String line_id = pizza.getLine_item().getString("line_id");
        json.getJSONArray("cart").put(Integer.parseInt(request.getParameter("line_num")), pizza.getLine_item());
        JSONObject updatedTopping = new JSONObject();
        updatedTopping.put("addedToppings", pizza.getAddedToppings());
        updatedTopping.put("extraToppings", pizza.getExtraToppings());

        json.getJSONObject("toppingListCache").put(line_id, updatedTopping);
        json.put("total", String.format("%.2f", Float.parseFloat((String)json.get("total"))+pizza.getTopping_total_price()));
        userJSON.put(userKey, json);
        request.getSession().setAttribute("user", userJSON.toString());
        
        JSONObject results = new JSONObject();
        results.put("toppingUnit", pizza.getToppingUnit());
        results.put("item_price", String.format("%.2f", pizza.getItem_price()));
        results.put("new_total", String.format("%.2f", Float.parseFloat((String)json.get("total"))));
        response.getWriter().print(results.toString());
    }

    @Override
    public void execute() {
        try {
            String user = (String)request.getSession().getAttribute("user");
//            if (user != null) {
            getParams(user);
            pizza.removeTopping(params);
            saveResults(user);
//            } else { 
//                response.getWriter().print("INACTIVE");
//            }
        } catch (JSONException e) {
            System.out.println(e.getMessage());
        } catch (IOException ex) {
            Logger.getLogger(RemoveToppingCommand.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}