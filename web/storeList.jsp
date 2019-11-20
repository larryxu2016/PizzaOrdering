<%-- 
    Document   : storeList
    Created on : May 20, 2019, 7:33:47 PM
    Author     : LarryXu
--%>

<%@page import="java.util.Iterator"%>
<%@page import="org.json.JSONObject"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="../styles/main.css">
        <link rel="stylesheet" href="../styles/jquery-ui.min.css">
        <link rel="icon" href="../images/online-store.png"  type="image/x-icon">
        
        <title>Store Locations</title>
        
        <script type="text/javascript" src="../js/jquery-3.4.1.min.js"></script>
        <script type="text/javascript" src="../js/jquery-ui.min.js"></script>
        <script type="text/javascript" src="../js/jquery.validate.min.js"></script>
        <%
            String deliveryFormURL  = response.encodeURL("./delivery");
            String carryoutFormURL = response.encodeURL("./carryout");
            
            String indexURL = "../";

            String startOrderURL  = response.encodeURL("../address");
            String retAddrStartOrderURL = response.encodeURL("../address/view");
            String addressDeliveryURL  = response.encodeURL("../address/view?target=DELIVERY");
            String addressCarryoutURL  = response.encodeURL("../address/view?target=CARRYOUT");
            String saveAddrURL  = response.encodeURL("../address/save");
            String addressChangeURL  = response.encodeURL("../address/change");
            
            String menuURL = response.encodeURL("../menu");
            String retAddrMenuURL = response.encodeURL("../menu/view");
            
            String loginPageURL = response.encodeURL("../user");
            String headerLoginURL = response.encodeURL("../user/login");
            String retAddrLoginPageURL = response.encodeURL("../user/login/view");
            String retAddrCreateAccountPageURL = response.encodeURL("../user/create_account/view");
            String signoutURL = response.encodeURL("../user/signout");
            
            String cartAddr = response.encodeRedirectURL("../cart");
            String retCartAddr = response.encodeRedirectURL("../cart/view");
            
            String checkoutAddr = "../checkout";
            String retCheckoutAddr = "../checkout/view";
            
            String userJSONstr = (String)session.getAttribute("user");

            String userInfo = "";
            String addressInfo = "";
            String storeInfo = "";
            String total = "";
            String count = "";
            if (userJSONstr != null) {
                JSONObject userJSON = new JSONObject(userJSONstr);
                String userKey = (String)userJSON.keys().next();
                JSONObject json = userJSON.getJSONObject(userKey);
                Iterator<String> keysItr = json.keys();
                while (keysItr.hasNext()) {
                    String key = keysItr.next();
                    if (key.equals("user")) {
                        userInfo = json.get(key).toString();
                    }
                    if (key.equals("address")) {
                        addressInfo = json.get(key).toString();
                    }
                    if (key.equals("store")) {
                        storeInfo = json.get(key).toString();
                    }
                    if (key.equals("total")) {
                        total = json.get(key).toString();
                    }
                    if (key.equals("count")) {
                        count = json.get(key).toString();
                    }
                }
            }
        %>
        <script type="text/javascript">
            var CSRF = '${CSRF_address}';
            
            var indexURL = '<%=indexURL%>';
            var menuURL = '<%=menuURL%>';
            var retAddrMenuURL = '<%=retAddrMenuURL%>';
            
            var startOrderURL = '<%=startOrderURL%>';
            var retAddrStartOrderURL = '<%=retAddrStartOrderURL%>';
            
            var addressDeliveryURL = '<%=addressDeliveryURL%>';
            var addressCarryoutURL = '<%=addressCarryoutURL%>';
            var saveAddrURL = '<%=saveAddrURL%>';
            var addressChangeURL = '<%=addressChangeURL%>';
            
            var checkoutAddr = '<%=checkoutAddr%>';
            var retCheckoutAddr = '<%=retCheckoutAddr%>';
            
            var cartAddr = '<%=cartAddr%>';
            var retCartAddr = '<%=retCartAddr%>';
            
            var headerLoginURL = '<%=headerLoginURL%>';
            var loginPageURL = '<%=loginPageURL%>';
            var retAddrLoginPageURL = '<%=retAddrLoginPageURL%>';
            var retAddrCreateAccountPageURL = '<%=retAddrCreateAccountPageURL%>';
            var signoutURL = '<%=signoutURL%>';

            var userInfo = '<%=userInfo%>';
            var addressInfo = '<%=addressInfo%>';
            var storeInfo = '<%=storeInfo%>';
            
            var total = '<%=total%>';
            var count = '<%=count%>';
        </script>
        <script type="text/javascript" src="../js/app.js"></script>
        <script type="text/javascript">
            $(document).ready(function() {
                Header.init();
                Nav_Mobile.init();
                
                $('#loc-header-edit-delivery').on('click', function(event) {
                    event.preventDefault();
                    $.ajax({
                        method: 'POST',
                        url: addressChangeURL,
                        beforeSend: function(xhrObj) {
                            xhrObj.setRequestHeader("X-CSRF-Token", CSRF);
                        }
                    }).done(function() {
                        window.location.href = addressDeliveryURL;
                    });
                });

                $('#loc-header-edit-carryout').on('click', function(event) {
                    $.ajax({
                        method: 'POST',
                        url: addressChangeURL,
                        beforeSend: function(xhrObj) {
                            xhrObj.setRequestHeader("X-CSRF-Token", CSRF);
                        }
                    }).done(function() {
                        window.location.href = addressCarryoutURL;
                    });
                });
            });
        </script>
        <script type="text/javascript"> 
            var zipcode = '${zipcode}';
        </script>
        <script type="text/javascript" src="../js/gMap.js"></script>

    </head>
    
    <body>
        <c:import url="../nav_mobile.html"/>   
        <div class="page-wrapper">
            <c:import url="../header.html"/>
            <main class="store-list">
                <div class="content-wrap clearfix">
                    <div class="store-results-header">
                        <h1>Locations</h1>
                        <div class="search-location-details">
                            <span class="store-location-label">Nearest stores to
                                <i class="icon-location icon"></i> ${zipcode}
                            </span>
                            <a id="loc-header-edit-carryout" href="#" class="edit-location-link">Edit</a>
                        </div>
                        <span class="delivery-button"><a id="loc-header-edit-delivery" class="button" href="#">Change to Delivery</a></span>
                    </div>

                    <div class="store-locations-accord alpha-ordered-list">

                    </div>

                    <div class="map-wrapper">
                        <div id="map">
                        </div>
                        <script async defer src="${mapURL}">
                        </script>
                    </div>

                </div>
            </main>

            <footer class="site-footer">
                <div >
                    <a class="site-footer-links"><image src="../images/online-store.png" width="200" height="200">About the Store</a>
                </div>
            </footer>
        </div>
    </body>
</html>