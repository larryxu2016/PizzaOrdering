/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pizza.controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.JSONException;
import org.json.JSONObject;
import pizza.controller.command.Dispatcher;
import pizza.controller.command.user.AuthenticationCommand;
import pizza.controller.command.user.CreateAccountCommand;
import pizza.data.UserDB;

/**
 *
 * @author LarryXu
 */
@WebServlet(name = "User", urlPatterns = {"/user", "/user/login", "/user/create_account", "/user/signout"})
public class User extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();
        
        if (path != null && path.equals("/user")) {
            String nonce = response.getHeader("X-CSRF-Token");
            request.getSession().setAttribute("CSRF_user", nonce);
        } else if (path != null && path.equals("/user/login")) {
            AuthenticationCommand createAcctComm = 
                new AuthenticationCommand(request, response);
            Dispatcher d = new Dispatcher();
            d.register(path, createAcctComm);
            d.execute(path);
        } else if (path != null && path.equals("/user/signout")) {
            request.getSession().removeAttribute("user");
        } else if (path != null && path.equals("/user/create_account")) {
            CreateAccountCommand createAcctComm = 
                new CreateAccountCommand(request, response);
            Dispatcher d = new Dispatcher();
            d.register(path, createAcctComm);
            d.execute(path);
        }
    }
    
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods.
    // Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

}
