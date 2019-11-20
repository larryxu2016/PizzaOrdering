/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pizza.controller.command.cart;

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
public class ChangeItemCountCommand implements Command {

    private Cart cart;
    private HttpServletRequest request;
    private HttpServletResponse response;
    private JSONObject params;

    public ChangeItemCountCommand(HttpServletRequest request,
            HttpServletResponse response) {
        this.request = request;
        this.response = response;
    }
    
    private void getParams(String user) 
            throws JSONException {
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
        }
        else if (user == null) {
            cart = new Cart();
        }

        params = new JSONObject();
        params.put("item_qty", request.getParameter("item_qty"));
    }

    private void saveResults(String user) 
            throws JSONException, IOException {
        JSONObject userJSON = null;
        JSONObject json;
        if (user != null) {
            userJSON = new JSONObject(user);
            String userKey = (String)userJSON.keys().next();
            json = userJSON.getJSONObject(userKey);

            json.put("cart", cart.getItems());
            json.put("total", String.format("%.2f", cart.getTotalPrice()));
            json.put("count", cart.getItemCount());

            userJSON.put(userKey, json);
        } else if (user == null) {
            json = new JSONObject();
            json.put("cart", cart.getItems());

            String userKey = (String)request.getSession().getId();
            userJSON = new JSONObject();
            userJSON.put(userKey, json);
        }
        request.getSession().setAttribute("user", (userJSON != null) ? userJSON.toString() : "");
        request.getSession().setAttribute("line_num", cart.getItems().length()-1);

        JSONObject result = new JSONObject();
        result.put("item_qty", cart.getItemCount());
        result.put("new_total", String.format("%.2f", cart.getTotalPrice()));
        response.getWriter().print(result.toString());
    }
    
    @Override
    public void execute() {
        try {
            String user = (String)request.getSession().getAttribute("user");
            if (user != null) {
                getParams(user);
                cart.changeItemCount(cart.getItems().getJSONObject(Integer.parseInt(request.getParameter("line_num"))), params);
                saveResults(user);
            } else { 
                response.getWriter().print("INACTIVE");
            }
        } catch (JSONException e) {
            System.out.println(e.getMessage());
        } catch (IOException ex) {
            Logger.getLogger(ChangeItemCountCommand.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
}
