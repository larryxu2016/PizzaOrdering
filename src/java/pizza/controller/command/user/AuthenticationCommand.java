/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pizza.controller.command.user;

import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONException;
import org.json.JSONObject;
import pizza.controller.command.Command;
import pizza.data.UserDB;

/**
 *
 * @author LarryXu
 */
public class AuthenticationCommand implements Command {

    private HttpServletRequest request;
    private HttpServletResponse response;
    
    public AuthenticationCommand(HttpServletRequest request,
            HttpServletResponse response) {
        this.request = request;
        this.response = response;
    }
    
    public void saveResults(JSONObject userDetails) throws JSONException {
        String user = (String)request.getSession().getAttribute("user");

        if (user != null) {
            JSONObject userJSON = new JSONObject(user);
            String userKey = (String)userJSON.keys().next();
            JSONObject json = userJSON.getJSONObject(userKey);
            json.put("user", userDetails);
            
            JSONObject updatedUserJSON = new JSONObject();
            updatedUserJSON.put(userKey, json);
            request.getSession().setAttribute("user", updatedUserJSON.toString());
        } else if (user == null) {
            JSONObject json = new JSONObject();
            json.put("user", userDetails);
            
            String userKey = request.getSession().getId();
            JSONObject updatedUserJSON = new JSONObject();
            updatedUserJSON.put(userKey, json);
            request.getSession().setAttribute("user", updatedUserJSON.toString());
        }
    } 
    
    @Override
    public void execute() {
        String userEmail = request.getParameter("userEmail");
        String userPwd = request.getParameter("userPwd");
        
        UserDB userDB = new UserDB();
        String results[] = userDB.authenticate(userEmail, userPwd);
        
        try {
            saveResults(userDB.getUserJSON());
            response.getWriter().write(results[1]);
            if ("Success".equals(results[1])) {
                response.getWriter().write(userDB.getUserJSON().toString());
            }
        } catch (IOException | JSONException e) {
            Logger.getLogger(AuthenticationCommand.class.getName()).log(Level.SEVERE, null, e);
        }
    }
    
}
