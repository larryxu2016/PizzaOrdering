/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pizza.controller.command.user;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONObject;
import pizza.controller.command.Command;
import pizza.data.UserDB;
import pizza.utility.PasswordUtil;

/**
 *
 * @author LarryXu
 */
public class CreateAccountCommand implements Command {

    private HttpServletRequest request;
    private HttpServletResponse response;

    public CreateAccountCommand(HttpServletRequest request,
            HttpServletResponse response) {
        this.request = request;
        this.response = response;
    }
    
    @Override
    public void execute() {
        String password = request.getParameter("password");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("phoneNumber");
        String streetName = request.getParameter("streetAddress");
        String buildingType = request.getParameter("aptCode");
        String buildingNum = request.getParameter("aptSteFloorNumber");
        String city = request.getParameter("usCity");
        String state = request.getParameter("usResidentialTerritoryCode");
        String zipCode = request.getParameter("usPostalCode");
        String country = request.getParameter("createAccountCountry");
        String addrType = request.getParameter("locationType");
        
        String sqlResult; //store whether the query is a success or failure                         
        String url = ""; //specify the page you want to redirect

        String salt = "";
        String hashedPwd = "";
        try {
            salt = PasswordUtil.getSalt();
            hashedPwd = PasswordUtil.hashPassword(password + salt);
        }
        catch(NoSuchAlgorithmException e) {
            System.out.println(e.getMessage());
        }
                
        UserDB userDB = new UserDB();
        String results[] = userDB.createAccount(firstName, lastName, 
                hashedPwd, email, phoneNumber, streetName, buildingType, 
                buildingNum, city, state, zipCode, addrType, country, salt);

        url = results[0];
        sqlResult = results[1];

        try {
            response.getWriter().print(sqlResult);
        } catch (IOException ex) {
            Logger.getLogger(CreateAccountCommand.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
}
