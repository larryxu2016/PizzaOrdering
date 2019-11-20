<%-- 
    Document   : pizzaMaker
    Created on : Jul 28, 2019, 11:05:08 PM
    Author     : LarryXu
--%>

<%@page import="java.util.Iterator"%>
<%@page import="org.json.JSONObject"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="../styles/pizza-maker.css">
        <link rel="stylesheet" href="../styles/main.css">
        <link rel="icon" href="../images/online-store.png"  type="image/x-icon">
        
        <link rel="stylesheet" href="../styles/jquery-ui.min.css">

        <title>Build Your Own Pizza</title>
        
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
            
            String loginPageURL = response.encodeURL("../user");
            String headerLoginURL = response.encodeURL("../user/login");
            String retAddrLoginPageURL = response.encodeURL("../user/login/view");
            String retAddrCreateAccountPageURL = response.encodeURL("../user/create_account/view");
            String signoutURL = response.encodeURL("../user/signout");
            
            String cartAddr = response.encodeRedirectURL("../cart");
            String retCartAddr = response.encodeRedirectURL("../cart/view");
            
            String removeToppingURL = response.encodeRedirectURL("../customization/remove/topping");
            
            String userJSONstr = (String)session.getAttribute("user");

            String userInfo = "";
            String addressInfo = "";
            String storeInfo = "";
            String cartInfo = "";
            String total = "";
            String count = "";
            String toppingListCache = "";
            
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
                    if (key.equals("toppingListCache")) {
                        toppingListCache = json.get(key).toString();
                    }
                    
                }
            }

            String mapURL = (String)session.getAttribute("mapURL");
        %>
        <script type="text/javascript">
            var CSRF = '${CSRF_cust}';
            
            var indexURL = '<%=indexURL%>';
            var menuURL = '<%=menuURL%>';
            var retAddrMenuURL = '<%=retAddrMenuURL%>';
            
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
            
            var removeToppingURL = '<%=removeToppingURL%>';
            
            var userInfo = '<%=userInfo%>';
            var addressInfo = '<%=addressInfo%>';
            var storeInfo = '<%=storeInfo%>';
            var cartInfo = '<%=cartInfo%>';
            var total = '<%=total%>';
            var count = '<%=count%>';
            var toppingInfo = '<%=toppingListCache%>'; 
            
            var mapURL = '<%=mapURL%>';
            
        </script>
        <script type="text/javascript" src="../js/app.js"></script>
        <script type="text/javascript">
            $(document).ready(function() {
                Header.init();
                Nav_Mobile.init();
                
                var data = (cartInfo.length > 0) ? JSON.parse(cartInfo) : '';
                var pm = 
                    new PizzaMaker(
                        {'types' : ${ingred_types},
                         'subTypes' : ${ingred_subTypes},
                         'items' : ${ingred_items},
                         'data' : data,
                         'line_num' : parseInt("${line_num}"),
                         'item_price' : parseFloat(data[parseInt("${line_num}")]["item_price"]),
                         'item_toppings' : data[parseInt("${line_num}")]["item_toppings"],
                         'addedToppingList' : ${addedToppingList} });
                pm.init();
                
            });      
        </script>
    </head>
    <body>
        <c:import url="../nav_mobile.html"/>   
        <div class="page-wrapper">
            <c:import url="../header.html"/>
            <main class="main">
                <div id="modal-dialog" data-dsc-type="modal" data-dsc-target="clear-page-cart" data-dsc-state="shown" style="left: 649px; top: 80px; display: none;">
                    <a href="#" class="close-link" data-dsc-role="hide" data-dsc-trigger="clear-page-cart"><i class="icon-close icon">Close</i></a>
                    <h3>Sorry, the user is no longer active. You will be redirected to the home page!</h3>
                    <form novalidate="novalidate" action="/order/cart/clear" method="get">
                        <button type="submit" class="button-extra-padding button">OK</button>
                        <a data-dsc-state="deselected" data-dsc-trigger="clear-page-cart" class="button--red">Cancel</a>
                    </form>
                </div>
                
                <div class="main main-content">
                    <div class="pizza-builder clearfix">
                        <div class="pizza-builder-inner">
                            <header class="pizza-builder-header">
                                <div class="pizza-builder-header--wrapper">
                                    <div class="pizza-info">
                                        <h1 class="title">
                                            <span class="product-name">Create Your Own</span>
                                            <span class="calorie-count-sep">: </span>
                                            <span class="calorie-count" id="pizza-builder-slice-calorie-info">270 cal / slice, 8 slices</span>
                                            <span class="product-price" id="sub-total" style="float:right;"><span class="currency">&#36;</span>0.00</span>
                                        </h1>

                                        <p>
                                            <span class="topping-count" data-topping-count="">(0) Toppings</span><span>  |</span>
                                            <a href="#" class="start-over refreshPage" data-track-click="pizza builder|click start over">Start Over</a>
                                        </p>
                                    </div>
                                </div>
                            </header>

                            <div class="toppings-added">
                                <div class="toppings">

                                </div>
                            </div>

                            <div class="pizza-builder-preview">
                                <div class="builder-preview">
                                    <div class="builder-preview-inner">
                                        <div class="pizza-base fadeIn">
                                            <div class="cut">
                                            </div>
                                        </div>
                                        <div class="sauce">
                                        </div>
                                        <div class="baked">
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="steps">
                                <nav class="next-step">
                                    <div class="next-step--wrapper">
                                        <a href="#" class="prev" style="display: none;">Previous</a>
                                        <a href="#CHEESES" class="button button-large no-space">Next: CHEESES</a>
                                        <div class="quantity-selector" style="display: none;">
                                            <label for="quantity" aria-label="Quantity">QTY</label>
                                            <select id="quantity" name="quantity">
                                                    <option selected=""> 1</option>
                                                    <option> 2</option>
                                                    <option> 3</option>
                                                    <option> 4</option>
                                                    <option> 5</option>
                                                    <option> 6</option>
                                                    <option> 7</option>
                                                    <option> 8</option>
                                                    <option> 9</option>
                                                    <option> 10</option>
                                                    <option> 11</option>
                                                    <option> 12</option>
                                                    <option> 13</option>
                                                    <option> 14</option>
                                                    <option> 15</option>
                                                    <option> 16</option>
                                                    <option> 17</option>
                                                    <option> 18</option>
                                                    <option> 19</option>
                                                    <option> 20</option>
                                                    <option> 21</option>
                                                    <option> 22</option>
                                                    <option> 23</option>
                                                    <option> 24</option>
                                                    <option> 25</option>
                                                    <option> 26</option>
                                                    <option> 27</option>
                                                    <option> 28</option>
                                                    <option> 29</option>
                                                    <option> 30</option>
                                                    <option> 31</option>
                                                    <option> 32</option>
                                                    <option> 33</option>
                                                    <option> 34</option>
                                                    <option> 35</option>
                                                    <option> 36</option>
                                                    <option> 37</option>
                                                    <option> 38</option>
                                                    <option> 39</option>
                                                    <option> 40</option>
                                                    <option> 41</option>
                                                    <option> 42</option>
                                                    <option> 43</option>
                                                    <option> 44</option>
                                                    <option> 45</option>
                                                    <option> 46</option>
                                                    <option> 47</option>
                                                    <option> 48</option>
                                                    <option> 49</option>
                                                    <option> 50</option>
                                            </select>
                                        </div>

                                        <button id="addToCart" class="button-large button button-alt no-space" style="display: none;">Add to Cart</button>
                                    </div>
                                </nav>
                            </div>

                        </div>
                    </div>
                </div>
            </main>
        </div>
    </body>
</html>