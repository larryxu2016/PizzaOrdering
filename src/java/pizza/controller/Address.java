/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pizza.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URISyntaxException;
import java.net.URL;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.JSONException;
import org.json.JSONObject;
import pizza.controller.command.customization.AddToppingCommand;

/**
 *
 * @author LarryXu
 */
@WebServlet(name = "Address", urlPatterns = {"/address", "/address/delivery",
    "/address/carryout", "/address/save", "/address/change"})
public class Address extends HttpServlet {
    
    private static String keyString =
        "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";
  
    // The URL shown in these examples is a static URL which should already
    // be URL-encoded. In practice, you will likely have code
    // which assembles your URL from user or web service input
    // and plugs those values into its parameters.
    private static String urlString = "https://maps.googleapis.com/maps/api/" +
        "js?key=APIKey&libraries=places&callback=initMap";

    // This variable stores the binary key, which is computed from the string (Base64) key
    private static byte[] key;


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
        String path = request.getServletPath();
        if (path != null && path.equals("/address")) {
            String nonce = response.getHeader("X-CSRF-Token");
            request.getSession().setAttribute("CSRF_address", nonce);

            String ajaxHeader = request.getHeader("x-requested-with");
            if (ajaxHeader == null) {
                String url  = "/address/view";
                getServletContext()
                    .getRequestDispatcher(url)
                    .forward(request, response);
            }
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
        
        // Convert the key from 'web safe' base 64 to binary
        keyString = keyString.replace('-', '+');
        keyString = keyString.replace('_', '/');

        // Base64 is JDK 1.8 only - older versions may need to use Apache Commons or similar.
        this.key = Base64.getDecoder().decode(keyString);

        URL url = new URL(urlString);
        
        String path = request.getServletPath();
        if (path != null && path.equals("/address/delivery")) {

            request.getSession().setAttribute("deliveryAddressParam", request.getParameter("deliveryAddressParam"));
            
        } else if (path != null && path.equals("/address/change")) {
            
            request.getSession().removeAttribute("deliveryAddressParam");
            
        } else if (path != null && path.equals("/address/carryout")) {
            
            String requestStr = "";
            try {
                requestStr = signRequest(url.getPath(),url.getQuery());
            } catch (NoSuchAlgorithmException | InvalidKeyException | URISyntaxException e) {
                Logger.getLogger(Address.class.getName()).log(Level.SEVERE, null, e);
            }

            request.getSession().setAttribute("zipcode", request.getParameter("carryout_zipcode"));
            request.getSession().setAttribute("mapURL", url.getProtocol() + "://" + url.getHost() + requestStr);
            
        } else if (path != null && path.equals("/address/save")) {
            
            String user = (String)request.getSession().getAttribute("user");
            if (user != null) {
                try {
                    JSONObject userJSON = new JSONObject(user);
                    String userKey = (String)userJSON.keys().next();
                    JSONObject json = userJSON.getJSONObject(userKey);
                    
                    JSONObject addressJSON = new JSONObject();
                    addressJSON.put(request.getParameter("orderType"), request.getParameter("address"));
                    json.put("address", addressJSON);
                    
                    JSONObject storeJSON = new JSONObject();
                    String orderType = request.getParameter("orderType");
                    if (orderType.equals("DELIVERY")) {
                        storeJSON.put("address", request.getParameter("store_address"));
                    }
                    storeJSON.put("phone", request.getParameter("store_phone"));
                    storeJSON.put("opening_hours", request.getParameter("store_opening_hours"));
                    storeJSON.put("distance", request.getParameter("store_distance"));
                    String storeDirection = request.getParameter("store_direction") +
                                    "&origin=" + request.getParameter("origin") +
                                    "&destination=" + request.getParameter("destination") +
                                    "&travelmode=" + request.getParameter("travelmode");
                    storeJSON.put("direction", storeDirection);
                    json.put("store", storeJSON);
                    
                    JSONObject updatedUserJSON = new JSONObject();
                    updatedUserJSON.put(userKey, json);
                    request.getSession().setAttribute("user", updatedUserJSON.toString());
                    request.getSession().removeAttribute("deliveryAddressParam");
                } catch (JSONException e) {
                    Logger.getLogger(Address.class.getName()).log(Level.SEVERE, null, e);
                }
            } else if (user == null) {
                try {
                    String userKey = request.getSession().getId();
                    JSONObject json = new JSONObject();
                    
                    JSONObject addressJSON = new JSONObject();
                    String orderType = request.getParameter("orderType");
                    addressJSON.put(orderType, request.getParameter("address"));
                    json.put("address", addressJSON);
                    
                    JSONObject storeJSON = new JSONObject();
                    if (orderType.equals("DELIVERY")) {
                        storeJSON.put("address", request.getParameter("store_address"));
                    }
                    storeJSON.put("phone", request.getParameter("store_phone"));
                    storeJSON.put("opening_hours", request.getParameter("store_opening_hours"));
                    storeJSON.put("distance", request.getParameter("store_distance"));
                    
                    String storeDirection = request.getParameter("store_direction") +
                                    "&origin=" + request.getParameter("origin") +
                                    "&destination=" + request.getParameter("destination") +
                                    "&travelmode=" + request.getParameter("travelmode");
                    storeJSON.put("direction", storeDirection);
                    json.put("store", storeJSON);
                    
                    JSONObject updatedUserJSON = new JSONObject();
                    updatedUserJSON.put(userKey, json);
                    request.getSession().setAttribute("user", updatedUserJSON.toString());
                    request.getSession().removeAttribute("deliveryAddressParam");
                } catch (JSONException e) {
                    Logger.getLogger(Address.class.getName()).log(Level.SEVERE, null, e);
                }
            }
            
        }
    }
    
    public String signRequest(String path, String query) throws NoSuchAlgorithmException,
        InvalidKeyException, UnsupportedEncodingException, URISyntaxException {

        // Retrieve the proper URL components to sign
        String resource = path + '?' + query;

        // Get an HMAC-SHA1 signing key from the raw key bytes
        SecretKeySpec sha1Key = new SecretKeySpec(key, "HmacSHA1");

        // Get an HMAC-SHA1 Mac instance and initialize it with the HMAC-SHA1 key
        Mac mac = Mac.getInstance("HmacSHA1");
        mac.init(sha1Key);

        // compute the binary signature for the request
        byte[] sigBytes = mac.doFinal(resource.getBytes());

        // base 64 encode the binary signature
        // Base64 is JDK 1.8 only - older versions may need to use Apache Commons or similar.
        String signature = Base64.getEncoder().encodeToString(sigBytes);

        // convert the signature to 'web safe' base 64
        signature = signature.replace('+', '-');
        signature = signature.replace('/', '_');

        return resource + "&signature=" + signature;
    }

}
