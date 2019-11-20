<%-- 
    Document   : order
    Created on : Mar 3, 2019, 5:20:18 PM
    Author     : mycomputer
--%>

<%@page import="java.util.Iterator"%>
<%@page import="org.json.JSONObject"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="../styles/main.css">
        <link rel="stylesheet" href="../styles/jquery-ui.min.css">
        <link rel="icon" href="../images/online-store.png"  type="image/x-icon">

        <title>Menu</title>
        
        <script type="text/javascript" src="../js/jquery-3.4.1.min.js"></script>
        <script type="text/javascript" src="../js/jquery-ui.min.js"></script>
        <script type="text/javascript" src="../js/jquery.validate.min.js"></script>
        <%
            String indexURL = "../";
            
            String startOrderURL  = response.encodeURL("../address");
            String retAddrStartOrderURL = response.encodeURL("../address/view");
            String addressDeliveryURL  = response.encodeURL("../address/view?target=DELIVERY");
            String addressCarryoutURL  = response.encodeURL("../address/view?target=CARRYOUT");
            String addressChangeURL  = response.encodeURL("../address/change");
            
            String menuURL = response.encodeURL("../menu");
            String retAddrMenuURL = response.encodeURL("../menu/view");

            String menuAddItemURL = response.encodeURL("../menu/add/item");
            
            String loginPageURL = response.encodeURL("../user");
            String headerLoginURL = response.encodeURL("../user/login");
            String retAddrLoginPageURL = response.encodeURL("../user/login/view");
            String retAddrCreateAccountPageURL = response.encodeURL("../user/create_account/view");
            String signoutURL = response.encodeURL("../user/signout");
            
            String cartAddr = response.encodeRedirectURL("../cart");
            String retCartAddr = response.encodeRedirectURL("../cart/view");
            
            String customization = response.encodeRedirectURL("../customization");
            String retCustomization = response.encodeRedirectURL("../customization/view");
            
            String userJSONstr = (String)session.getAttribute("user");

            String userInfo = "";
            String addressInfo = "";
            String storeInfo = "";
            String cartInfo = "";
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
                    if (key.equals("cart")) {
                        cartInfo = json.get(key).toString();
                    }
                    if (key.equals("total")) {
                        total = json.get(key).toString();
                    }
                    if (key.equals("count")) {
                        count = json.get(key).toString();
                    }
                }
            }

            String mapURL = (String)session.getAttribute("mapURL");
        %>
        <script type="text/javascript">
            var CSRF = '${CSRF_menu}';
            
            var indexURL = '<%=indexURL%>';
            var menuURL = '<%=menuURL%>';
            var retAddrMenuURL = '<%=retAddrMenuURL%>';
            var menuAddItemURL = '<%=menuAddItemURL%>';
            
            var startOrderURL = '<%=startOrderURL%>';
            var retAddrStartOrderURL = '<%=retAddrStartOrderURL%>';
            
            var addressDeliveryURL = '<%=addressDeliveryURL%>';
            var addressCarryoutURL = '<%=addressCarryoutURL%>';
            var addressChangeURL = '<%=addressChangeURL%>';
                        
            var headerLoginURL = '<%=headerLoginURL%>';
            var loginPageURL = '<%=loginPageURL%>';
            var retAddrLoginPageURL = '<%=retAddrLoginPageURL%>';
            var retAddrCreateAccountPageURL = '<%=retAddrCreateAccountPageURL%>';
            var signoutURL = '<%=signoutURL%>';
            var cartAddr = '<%=cartAddr%>';
            var retCartAddr = '<%=retCartAddr%>';
            var customization = '<%=customization%>';
            var retCustomization = '<%=retCustomization%>';
            
            var userInfo = '<%=userInfo%>';
            var addressInfo = '<%=addressInfo%>';
            var storeInfo = '<%=storeInfo%>';
            var cartInfo = '<%=cartInfo%>';
            var total = '<%=total%>';
            var count = '<%=count%>';
            
            var mapURL = '<%=mapURL%>';
            
            var types = ${types};
            var subTypes = ${subTypes};
            var items = ${items};
            var prices = ${prices};
            var subTypesMap = ${subTypesMap};     
            var ingredients = ${ingredients};
        </script>
        <script type="text/javascript" src="../js/app.js"></script>
        <script type="text/javascript">
            $(document).ready(function() {
                Header.init();
                Nav_Mobile.init();
                Menu.init({"types": types,
                           "subTypes": subTypes,
                           "items": items,
                           "prices": prices,
                           "subTypesMap": subTypesMap,
                           "ingredients": ingredients,
                           "total": total,
                           "count": count});
            });
        </script>
    </head>
    <body>
        <c:import url="../nav_mobile.html"/>   
        <div class="page-wrapper">
            <c:import url="../header.html"/>
            <main class="main main-content">
                <div class="container" id="tab">
                </div>       
            </main>
            <footer class="site-footer">
                <div>
                    <a class="site-footer-links">
                        <image src="../images/online-store.png" width="200" height="200">
                        About the Store
                    </a>
                </div>
            </footer>
        </div>
    </body>
</html>