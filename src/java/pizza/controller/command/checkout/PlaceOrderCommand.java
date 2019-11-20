/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pizza.controller.command.checkout;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import pizza.business.Pizza;
import pizza.controller.command.Command;
import pizza.data.InvoiceDB;
import pizza.data.LineDB;
import pizza.data.OrderDB;
import pizza.data.UserDB;
import pizza.utility.PasswordUtil;

/**
 *
 * @author LarryXu
 */
public class PlaceOrderCommand implements Command {
    private HttpServletRequest request;
    private HttpServletResponse response;
    private JSONObject params;
    
    public PlaceOrderCommand(HttpServletRequest request,
            HttpServletResponse response) {
        this.request = request;
        this.response = response;
    }
    
    public void getParams(String user) throws JSONException {
//        JSONObject userJSON = new JSONObject(user);
//        String userKey = (String)userJSON.keys().next();
//        JSONObject json = userJSON.getJSONObject(userKey);
//        JSONArray line_items = json.getJSONArray("cart");
// 
//
//        params = new JSONObject();
//        params.put("topping_name", request.getParameter("topping_name"));
    }
    
    public boolean saveItems(int invoiceID) throws JSONException {
        String user = (String)request.getSession().getAttribute("user");
        if (user != null) {
            JSONObject userJSON = new JSONObject(user);
            String userKey = (String)userJSON.keys().next();
            JSONObject json = userJSON.getJSONObject(userKey);
            if (json.has("cart")) {
                JSONArray cart = json.getJSONArray("cart");
                LineDB lineDB = new LineDB();
                if(!lineDB.saveLines(invoiceID, cart)) {
                    return false;
                }
            } else {
                return false;
            }
        } else {
            return false;
        }
        return true;
    }
        
    public int saveInvoice(int userID) {
        InvoiceDB invDB = new InvoiceDB();
        
        return invDB.saveInvoice(userID);
    }
    
    public int saveUser() {
        //1. check if user exists
        UserDB userDB = new UserDB();
        int userID = 0;
        
        String password = request.getParameter("checkoutAccountPassword");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("phoneNum");
                    
        if (userDB.checkUser(email)) {

            userID = userDB.getUser().getUserID();
            if (userDB.getUser().getPassword() == null &&
                password != null) {
                //update the user(with password)
                if (userDB.updateUser(userID, firstName, lastName, password, email, phoneNumber)) {
                    return userID;
                } else {
                    return -1;
                }
            }
            
        } else {
            if (password != null) {
                //create user with password
                String salt = "";
                String hashedPwd = "";
                try {
                    salt = PasswordUtil.getSalt();
                    hashedPwd = PasswordUtil.hashPassword(password + salt);
                }
                catch(NoSuchAlgorithmException e) {
                    System.out.println(e.getMessage());
                }
                return userDB.createUser(firstName, lastName, hashedPwd, email, phoneNumber, salt);
            } else {
                //create user without password
                return userDB.createUserNoPwd(firstName, lastName, email, phoneNumber);
            }
        }
        return userID;
    }
    
    public int saveOrder(int invoiceID) throws JSONException {
        String user = (String)request.getSession().getAttribute("user");
        JSONObject userJSON = new JSONObject(user);
        String userKey = (String)userJSON.keys().next();
        JSONObject json = userJSON.getJSONObject(userKey);
        
        JSONObject address = json.getJSONObject("address");
        String orderType = (String)address.keys().next();
        String orderAddr = address.getString(orderType);
        OrderDB orderDB = new OrderDB();
        return orderDB.saveOrder(invoiceID, orderType, orderAddr);
    }
    
    public boolean processPayment(String paymentType) {
        return true;
    }
    
    public boolean processOrder() throws JSONException {
        String paymentType = request.getParameter("paymentType");
        if (!paymentType.equals("CASH")) {
            if (!processPayment(paymentType)) {
                return false;
            }
        }
        
        int userID = saveUser();
        if (userID == -1) {
            return false;
        }
        
        int invoiceID = saveInvoice(userID);
        if (invoiceID == -1) {
            return false;
        }
        
        if (!saveItems(invoiceID)) {
            return false;
        }
        
        int orderID = saveOrder(invoiceID);
        if (orderID == -1) {
            return false;
        }
        return true;
    }
    
    @Override
    public void execute() {
        try {
            String user = (String)request.getSession().getAttribute("user");
            if (user != null) {
//                getParams(user);
                boolean success = processOrder();
                if (success) {
                    response.getWriter().print("SUCCESS");
                } else {
                    response.getWriter().print("Error occurred while placing order");
                }
            } else { 
                response.getWriter().print("INACTIVE");
            }
        } catch (JSONException e) {
            System.out.println(e.getMessage());
        } catch (IOException ex) {
            Logger.getLogger(PlaceOrderCommand.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
}
