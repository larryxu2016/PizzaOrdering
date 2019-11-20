<%-- 
    Document   : index
    Created on : Sep 12, 2019, 6:22:36 PM
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
        <link rel="stylesheet" href="styles/main.css">
        <link rel="stylesheet" href="styles/jquery-ui.min.css">
        <link rel="icon" href="images/online-store.png"  type="image/x-icon">

        <title>Home</title>
        
        <script type="text/javascript" src="js/jquery-3.4.1.min.js"></script>
        <script type="text/javascript" src="js/jquery-ui.min.js"></script>
        <script type="text/javascript" src="js/jquery.validate.min.js"></script>
        <%
            String indexURL  = response.encodeURL("");
            String indexServletURL = response.encodeURL("index");
            
            String menuURL = response.encodeURL("menu");
            String retAddrMenuURL = response.encodeURL("menu/view");
            
            String startOrderURL  = response.encodeURL("address");
            String retAddrStartOrderURL = response.encodeURL("address/view");
            String addressDeliveryURL  = response.encodeURL("address/view?target=DELIVERY");
            String addressCarryoutURL  = response.encodeURL("address/view?target=CARRYOUT");
            String deliveryFormURL  = response.encodeURL("address/delivery");
            String addressChangeURL  = response.encodeURL("address/change");
            
            String headerLoginURL = response.encodeURL("user/login");
            String loginPageURL = response.encodeURL("user");
            String retAddrLoginPageURL = response.encodeURL("user/login/view");
            String retAddrCreateAccountPageURL = response.encodeURL("user/create_account/view");
            String signoutURL = response.encodeURL("user/signout");
            
            String userJSONstr = (String)session.getAttribute("user");
            
            String cartAddr = response.encodeRedirectURL("cart");
            String retCartAddr = response.encodeRedirectURL("cart/view");
            String total = "";
            String count = "";

            String userInfo = "";
            String addressInfo = "";
            String storeInfo = "";
            
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
            var CSRF = '${CSRF_index}';
            
            var indexURL = '<%=indexURL%>';
            var indexServletURL = '<%=indexServletURL%>';
            
            var menuURL = '<%=menuURL%>';
            var retAddrMenuURL = '<%=retAddrMenuURL%>';
            
            var startOrderURL = '<%=startOrderURL%>';
            var retAddrStartOrderURL = '<%=retAddrStartOrderURL%>';
            
            var deliveryFormURL = '<%=deliveryFormURL%>';
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
            
            var userInfo = '<%=userInfo%>';
            var addressInfo = '<%=addressInfo%>';
            var storeInfo = '<%=storeInfo%>';
            var total = '<%=total%>';
            var count = '<%=count%>';
        </script>
        <script type="text/javascript" src="js/app.js"></script>
        <script type="text/javascript">
            $(document).ready(function() {  
                
                if (CSRF.length === 0) {
                    $.ajax({
                        method: 'GET',
                        url: '<%=indexServletURL%>',
                        beforeSend: function(xhrObj) {
                            xhrObj.setRequestHeader("X-CSRF-Token", "Fetch");
                        }
                    }).done(function() {
                        window.location.href = "";
                    });
                }
        
                sessionStorage.setItem('readyToCheckOut', false);
                
                Header.init();
                Nav_Mobile.init();
                
                $('.slider-cover').height($('.slider-cover .slider-overflow ul').height() + 64);
                
                $('.slider-button').on('click', function(event) {
                    event.preventDefault();
                    var id = this.id;
                    var str = id.split("-");
                    var $currentBtn = str[str.length-2] === "right" ? $(this) : $(this).next();
                    var dir;
                    var $container = $currentBtn.next(".slider-cover").children(".slider-overflow");
                    $currentBtn = $(this);
                    
                    if (str[str.length-2] === "right") {
                        var $leftBtn = $(this).prev();
                        
                        if ($leftBtn.is(":disabled")) {
                            $leftBtn.removeAttr("disabled");
                        }
                        
                        dir = '+=';
                    } else {
                        var $rightBtn = $(this).next();
                        
                        if ($rightBtn.is(":disabled")) {
                            $rightBtn.removeAttr("disabled");
                        }
                        
                        dir = '-=';
                    }
                    
                    var oWidth = $container.children("ul").children("li").css("margin-left");
                    var width = $container.children("ul").children("li").width();
                    $container.stop().animate({scrollLeft: dir + (width + parseFloat(oWidth).toFixed(2)*2) }, 200, function() {
                        var scrollPos = $container[0].scrollLeft + $container[0].offsetWidth;
                        if ($container[0].scrollWidth === scrollPos ||
                            $container[0].clientLeft === $container[0].scrollLeft) {
                                $currentBtn.attr("disabled", "true");
                        }
                    });
                });
            });
        </script>
    </head>
    <body>
        <c:import url="nav_mobile.html"/>
        <div class="page-wrapper">
            <c:import url="header.html"/>
            <main class="main">
                <section>
                    <div class="hero-unit">
                        <div class="hero-image hero-image--mobile"><div class="hero-image-bg" style="background-image: url('images/p9-10-2019-works-meats-compressed.jpg');"></div></div>
                        <div class="hero-image hero-image--desktop"><div class="hero-image-bg" style="background-image: url('images/p9-10-2019-works-meats-compressed.jpg');"></div></div>
                        <div class="container">
                            <div class="hero-text">

                                <div class="skew-text">
                                    <span class="large-text">LARGE WORKS</span>
                                    <span class="large-text">OR MEATS PIZZA</span>
                                    <span class="large-text">FOR $12</span>
                                </div>

                                <a href="" class="button button--large" target="_self">ADD &amp; CUSTOMIZE</a>
                            </div>
                        </div>
                    </div>
                    <div class="slider slider--hero">
                        <button id="slider-button-leftt-0" class="slider-button slider-button-left" aria-label="Scroll Slider Left" disabled="disabled" style=""><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" data-id="geomicon-chevronLeft" viewBox="0 0 32 32"><path d="M20 1 L24 5 L14 16 L24 27 L20 31 L6 16 z"></path></svg></button>
                        <button id="slider-button-right-0" class="slider-button slider-button-right" aria-label="Scroll Slider Right" style=""><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" data-id="geomicon-chevronRight" viewBox="0 0 32 32"><path d="M12 1 L26 16 L12 31 L8 27 L18 16 L8 5 z"></path></svg></button>
                        <div class="slider-cover">
                        <div class="slider-overflow">
                            <ul>
                                <li class="slide" data-hide="cold hot">
                                    <div class="hero-card">
                                        <div class="card-image">
                                            <img alt="" src="https://www.papajohns.com/static-assets/a/images/ab-test/specialty-pizzas.jpg">
                                        </div>
                                        <div class="card-details">
                                            <div class="card-header">
                                                <h2 class="title h3">Our Handcrafted Specialties</h2>
                                            </div>

                                            <p class="description">Try one of our delicious specialty pizzas and find your new favorite.</p>
                                            <a class="button" aria-label="Wow, show me more" href="https://www.papajohns.com/order/menu">Order Now</a>
                                        </div>
                                    </div>
                                </li>

                                <li class="slide" data-hide="warm hot">
                                    <div class="hero-card">
                                        <div class="card-image">
                                            <img alt="" src="images/788782_money_512x512.png">
                                        </div>
                                        <div class="card-details">
                                            <div class="card-header">
                                                <h2 class="title h3">The Best Experience</h2>
                                            </div>

                                            <p class="description">Join or sign in to earn points and see your local specials.</p>
                                            <a class="button" aria-label="Sign-In" href="https://www.papajohns.com/order/sign-in">Sign Up</a>
                                        </div>
                                    </div>
                                </li>

                                <li class="slide" data-hide="warm hot">
                                    <div class="hero-card">
                                        <div class="card-image">
                                            <img alt="" src="https://www.papajohns.com/static-assets/a/images/ab-test/create-your-own.jpg">
                                        </div>
                                        <div class="card-details">
                                            <div class="card-header">
                                                <h2 class="title h3"> Create Your Own</h2>
                                            </div>

                                            <p class="description">Customize any size pizza with your favorite toppings, cheese and sauce.</p>
                                            <a class="button" aria-label="Create Your Own" href="https://www.papajohns.com/order/builder/productBuilderInfo?productGroupId=cyo&amp;quantity=1&amp;productSKU.sku=1-1-4-83">Customize</a>
                                        </div>
                                    </div>
                                    </li>

                                              <li class="slide" data-hide="warm hot">
                                    <div class="hero-card">
                                        <div class="card-image">
                                            <img alt="" src="https://www.papajohns.com/static-assets/a/images/web/marketing-item/generic-party-catering.jpg">
                                        </div>
                                        <div class="card-details">
                                            <div class="card-header">
                                                <h2 class="title h3">Invite Us To Your Next Party</h2>
                                            </div>

                                            <p class="description">Planning a party, meeting or get-together? Plan on Papa John's</p>
                                            <a class="button" aria-label="Learn More" href="https://www.papajohns.com/order/menu?special=Parties">Learn More</a>
                                        </div>
                                    </div>
                                                    </li>
                            </ul>
                        </div>
                        </div>
                    </div>
                    <div class="slider slider--hero">
                        <button id="slider-button-left-1" class="slider-button slider-button-left" aria-label="Scroll Slider Left" disabled="disabled"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" data-id="geomicon-chevronLeft" viewBox="0 0 32 32"><path d="M20 1 L24 5 L14 16 L24 27 L20 31 L6 16 z"></path></svg></button>
                        <button id="slider-button-right-1" class="slider-button slider-button-right" aria-label="Scroll Slider Right" style=""><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" data-id="geomicon-chevronRight" viewBox="0 0 32 32"><path d="M12 1 L26 16 L12 31 L8 27 L18 16 L8 5 z"></path></svg></button>
                        <div class="slider-cover">
                        <div class="slider-overflow">
                            <ul>
                                <li class="slide" data-hide="warm hot">
                                    <div class="hero-card">
                                        <div class="card-image">
                                            <img alt="" src="https://www.papajohns.com/static-assets/a/images/web/marketing-item/generic-party-catering.jpg">
                                        </div>
                                        <div class="card-details">
                                            <div class="card-header">
                                                <h2 class="title h3">Invite Us To Your Next Party</h2>
                                            </div>

                                            <p class="description">Planning a party, meeting or get-together? Plan on Papa John's</p>
                                            <a class="button" aria-label="Learn More" href="https://www.papajohns.com/order/menu?special=Parties">Learn More</a>
                                        </div>
                                    </div>
                                </li>
                                <li class="slide" data-hide="cold hot">
                                    <div class="hero-card">
                                        <div class="card-image">
                                            <img alt="" src="https://www.papajohns.com/static-assets/a/images/ab-test/specialty-pizzas.jpg">
                                        </div>
                                        <div class="card-details">
                                            <div class="card-header">
                                                <h2 class="title h3">Our Handcrafted Specialties</h2>
                                            </div>

                                            <p class="description">Try one of our delicious specialty pizzas and find your new favorite.</p>
                                            <a class="button" aria-label="Wow, show me more" href="https://www.papajohns.com/order/menu">Order Now</a>
                                        </div>
                                    </div>

                                </li>
                                <li class="slide" data-hide="warm hot">
                                    <div class="hero-card">
                                        <div class="card-image">
                                            <img alt="" src="images/788782_money_512x512.png">
                                        </div>
                                        <div class="card-details">
                                            <div class="card-header">
                                                <h2 class="title h3">The Best Experience</h2>
                                            </div>

                                            <p class="description">Join or sign in to earn points and see your local specials.</p>
                                            <a class="button" aria-label="Sign-In" href="https://www.papajohns.com/order/sign-in">Sign Up</a>
                                        </div>
                                    </div>
                                </li>

                                <li class="slide" data-hide="warm hot">
                                    <div class="hero-card">
                                        <div class="card-image">
                                            <img alt="" src="https://www.papajohns.com/static-assets/a/images/ab-test/create-your-own.jpg">
                                        </div>
                                        <div class="card-details">
                                            <div class="card-header">
                                                <h2 class="title h3"> Create Your Own</h2>
                                            </div>

                                            <p class="description">Customize any size pizza with your favorite toppings, cheese and sauce.</p>
                                            <a class="button" aria-label="Create Your Own" href="https://www.papajohns.com/order/builder/productBuilderInfo?productGroupId=cyo&amp;quantity=1&amp;productSKU.sku=1-1-4-83">Customize</a>
                                        </div>
                                    </div>
                                </li>

                            </ul>
                        </div>
                        </div>
                    </div>
                </section>
            </main>

            <footer class="site-footer">
                <div>
                    <a class="site-footer-links">
                        <image src="images/online-store.png" width="200" height="200">
                        About the Store
                    </a>
                </div>
            </footer>
        </div>
    </body>
</html>