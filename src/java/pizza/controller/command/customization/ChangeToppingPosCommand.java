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
public class ChangeToppingPosCommand implements Command {

    private Pizza pizza;
    private HttpServletRequest request;
    private HttpServletResponse response;
    private JSONObject params;

    public ChangeToppingPosCommand(HttpServletRequest request,
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
        params.put("position", request.getParameter("position"));
    }

    private void saveResults(String user) 
            throws JSONException, IOException {
        JSONObject userJSON = new JSONObject(user);
        String userKey = (String)userJSON.keys().next();
        JSONObject json = userJSON.getJSONObject(userKey);

        String line_id = pizza.getLine_item().getString("line_id");
        json.getJSONArray("cart").put(Integer.parseInt(request.getParameter("line_num")), pizza.getLine_item());
        JSONObject updatedTopping = new JSONObject();
        updatedTopping.put("addedToppings", pizza.getAddedToppings());
        updatedTopping.put("extraToppings", pizza.getExtraToppings());

        json.getJSONObject("toppingListCache").put(line_id, updatedTopping);
        userJSON.put(userKey, json);
        request.getSession().setAttribute("user", userJSON.toString());
    }
    
    @Override
    public void execute() {
       try {
            String user = (String)request.getSession().getAttribute("user");
//            if (user != null) {
            getParams(user);
            pizza.changeToppingPosition(params);
            saveResults(user);
//            } else { 
//                response.getWriter().print("INACTIVE");
//            }
        } catch (JSONException e) {
            System.out.println(e.getMessage());
        } catch (IOException ex) {
            Logger.getLogger(ChangeToppingPosCommand.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
}
