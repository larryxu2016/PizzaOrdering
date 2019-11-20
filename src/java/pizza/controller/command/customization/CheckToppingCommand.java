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
public class CheckToppingCommand implements Command {

    private Pizza pizza;
    private HttpServletRequest request;
    private HttpServletResponse response;
    private JSONObject params;

    public CheckToppingCommand(HttpServletRequest request,
            HttpServletResponse response) {
        this.request = request;
        this.response = response;
    }
    
    public void getParams(String user) throws JSONException {
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
            new Pizza(
                toppingListCache.getJSONObject("addedToppings"),
                toppingListCache.getJSONObject("extraToppings"),
                new JSONObject(
                    (String)request.getSession().getAttribute("addedToppingList")),
                line_item,
                Integer.parseInt(
                    request.getParameter("added_topping_count")));
        
        params = new JSONObject();
        params.put("topping_name", request.getParameter("topping_name"));
    }
    
    public void saveResults() 
            throws JSONException, IOException {
        JSONObject results = new JSONObject();
        results.put("toppingUnit", pizza.getToppingUnit());
        response.getWriter().print(results.toString());
    }
    
    @Override
    public void execute() {
        try {
            String user = (String)request.getSession().getAttribute("user");
//            if (user != null) {
            getParams(user);
            pizza.checkTopping(params);
            saveResults();
//            } else { 
//                response.getWriter().print("INACTIVE");
//            }
        } catch (JSONException e) {
            System.out.println(e.getMessage());
        } catch (IOException ex) {
            Logger.getLogger(CheckToppingCommand.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
}
