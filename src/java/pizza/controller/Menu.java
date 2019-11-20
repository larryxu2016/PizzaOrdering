/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pizza.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Random;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.JSONException;
import org.json.JSONObject;
import pizza.data.ItemDB;
import pizza.business.Cart;
import pizza.controller.command.Dispatcher;
import pizza.controller.command.menu.AddItemCommand;
/**
 *
 * @author LarryXu
 */
@WebServlet(name = "Menu", urlPatterns = {"/menu", "/menu/add/item"})
public class Menu extends HttpServlet {

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
        if (path != null && path.equals("/menu")) {
            ItemDB itemDB = new ItemDB();
            itemDB.getItems();

            HttpSession session = request.getSession();
            String nonce = response.getHeader("X-CSRF-Token");
            session.setAttribute("CSRF_menu", nonce);
            
            session.setAttribute("types", itemDB.getTypeList().toString());
            session.setAttribute("subTypes", itemDB.getSubTypeList().toString());
            session.setAttribute("items", itemDB.getItemList().toString());
            session.setAttribute("prices", itemDB.getPriceList().toString());
            session.setAttribute("subTypesMap", itemDB.getSubTypeMap().toString());
            session.setAttribute("ingredients", itemDB.getIngredientList().toString());
        } else if (path != null && path.equals("/menu/add/item")) {

            Dispatcher d = new Dispatcher();
            AddItemCommand addItemComm = new AddItemCommand(request, response);
            d.register(path, addItemComm);
            d.execute(path);
            
        }
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

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods.Click on the + sign on the left to edit the code.">
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
}
