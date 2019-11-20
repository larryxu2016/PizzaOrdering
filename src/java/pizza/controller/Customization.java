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
import pizza.business.Pizza;
import pizza.controller.command.Dispatcher;
import pizza.controller.command.customization.AddToppingCommand;
import pizza.controller.command.customization.ChangeOptionCommand;
import pizza.controller.command.customization.ChangeToppingPosCommand;
import pizza.controller.command.customization.CheckToppingCommand;
import pizza.controller.command.customization.RemoveToppingCommand;
import pizza.data.CustomizationDB;

/**
 *
 * @author LarryXu
 */
@WebServlet(name = "Customization", urlPatterns = {"/customization",
    "/customization/check/topping", "/customization/add/topping",
    "/customization/remove/topping", "/customization/change/option",
    "/customization/change/toppingPos"})
public class Customization extends HttpServlet {

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
        String referer = request.getHeader("referer");
        String path = request.getServletPath();
        
        if (path != null && path.equals("/customization")) {
            
            HttpSession session = request.getSession();
            String nonce = response.getHeader("X-CSRF-Token");
            session.setAttribute("CSRF_cust", nonce);
            
            CustomizationDB customizationDB = new CustomizationDB();
            customizationDB.getToppings();

            session.setAttribute("ingred_types", customizationDB.getTypeList().toString());
            session.setAttribute("ingred_subTypes", customizationDB.getSubTypeList().toString());
            session.setAttribute("ingred_items", customizationDB.getItemList().toString());

            session.setAttribute("line_num", request.getSession().getAttribute("line_num"));

            session.setAttribute("item_name", request.getParameter("item_name"));
            session.setAttribute("item_type", request.getParameter("item_type"));
            session.setAttribute("item_size_price", request.getParameter("item_size_price"));
            session.setAttribute("item_price", request.getParameter("item_price"));
            session.setAttribute("addedToppings", request.getParameter("toppings"));
            session.setAttribute("addedToppingList", customizationDB.getAddedToppingList().toString());
            
        } else if (path != null && path.equals("/customization/check/topping")) {
            
            CheckToppingCommand checkToppingComm =
                    new CheckToppingCommand(request, response);
            Dispatcher d = new Dispatcher();
            d.register(path, checkToppingComm);
            d.execute(path);
            
        } else if (path != null && path.equals("/customization/add/topping")) {
                    
            AddToppingCommand addToppingComm = 
                    new AddToppingCommand(request, response);
            Dispatcher d = new Dispatcher();
            d.register(path, addToppingComm);
            d.execute(path);

        } else if (path != null && path.equals("/customization/remove/topping")) {
                    
            RemoveToppingCommand removeToppingComm = 
                    new RemoveToppingCommand(request, response);
            Dispatcher d = new Dispatcher();
            d.register(path, removeToppingComm);
            d.execute(path);

        } else if (path != null && path.equals("/customization/change/option")) {
                    
            ChangeOptionCommand changeOptComm = 
                    new ChangeOptionCommand(request, response);
            Dispatcher d = new Dispatcher();
            d.register(path, changeOptComm);
            d.execute(path);
                    
        } else if (path != null && path.equals("/customization/change/toppingPos")) {
            
            ChangeToppingPosCommand changeToppingPosComm = 
                    new ChangeToppingPosCommand(request, response);
            Dispatcher d = new Dispatcher();
            d.register(path, changeToppingPosComm);
            d.execute(path);

        }
        
    }
    
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
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