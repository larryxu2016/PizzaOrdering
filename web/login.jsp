<%-- 
    Document   : login
    Created on : Mar 2, 2019, 10:14:51 AM
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
        <link rel="stylesheet" href="../../styles/main.css">
        <link rel="icon" href="../../images/online-store.png"  type="image/x-icon">

        <title>Sign-in</title>
        
        <script type="text/javascript" src="../../js/jquery-3.4.1.min.js"></script>
        <script type="text/javascript" src="../../js/jquery.validate.min.js"></script>
        <script type="text/javascript" src="../../js/login.validation.js"></script>
        <%
            String indexURL = "../../";
            String menuURL = response.encodeURL("../../menu");
            String retAddrMenuURL = response.encodeURL("../../menu/view");
            
            String startOrderURL  = response.encodeURL("../../address");
            String retAddrStartOrderURL = response.encodeURL("../../address/view");
            
            String addressDeliveryURL  = response.encodeURL("../../address/view?target=DELIVERY");
            String addressCarryoutURL  = response.encodeURL("../../address/view?target=CARRYOUT");
            String addressChangeURL  = response.encodeURL("../../address/change");
                        
            String headerLoginURL = response.encodeURL("../../user/login");
            String loginPageURL = response.encodeURL("../../user");
            String retAddrLoginPageURL = response.encodeURL("../../user/login/view");
            String retAddrCreateAccountPageURL = response.encodeURL("../../user/create_account/view");
            String signoutURL = response.encodeURL("../../user/signout");
            
            String userJSONstr = (String)session.getAttribute("user");
            
            String cartAddr = response.encodeRedirectURL("../../cart");
            String retCartAddr = response.encodeRedirectURL("../../cart/view");

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
                }
            }
        %>
        <script type="text/javascript">
            var CSRF = '${CSRF_user}';
            
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
            
            var userInfo = '<%=userInfo%>';
            var addressInfo = '<%=addressInfo%>';
            var storeInfo = '<%=storeInfo%>';
            var total = '';
            var count = '';
        </script>
        <script type="text/javascript" src="../../js/app.js"></script>
        <script type="text/javascript">
            $(document).ready(function() {
                Header.init();
                Nav_Mobile.init();
                
                var validator = $("#pizzaOrderingLogin").validate({
                    rules: {
                        userEmail: {
                            required: true,
                            email: true
                        },
                        userPwd: 'required'
                    },
                    messages: {
                        userEmail: {
                            required: 'Please enter an email address!',
                            email: 'Please enter a valid email address!'
                        },
                        userPwd: 'Please enter a password!'
                    }
                });
                
                $('#pizzaOrderingLogin').on('submit', function(event) {
                    event.preventDefault();
                    if (validator.form()) {
                        $.ajax({
                            url: headerLoginURL,
                            method: 'POST',
                            beforeSend: function(xhrObj) {
                                xhrObj.setRequestHeader("X-CSRF-Token", CSRF);
                            },
                            data: $(this).serialize()
                        }).done(function(results) {
                            if (results.search(/^Success/) === -1) {
                                $('#signIn-recaptcha_error_msg').append(results);
                            } else {
                                $.ajax({
                                    method: 'GET',
                                    url: menuURL,
                                    beforeSend: function(xhrObj) {
                                        xhrObj.setRequestHeader("X-CSRF-Token", "Fetch");
                                    }
                                }).done(function() {
                                    window.location.href = retAddrMenuURL;
                                });
                            }
                        });
                    }
                });
                
                $('#create-account').on('click', function(event) {
                    event.preventDefault();
                    $.ajax({
                        method: 'GET',
                        url: loginPageURL,
                        beforeSend: function(xhrObj) {
                            xhrObj.setRequestHeader("X-CSRF-Token", "Fetch");
                        }
                    }).done(function() {
                        window.location.href = retAddrCreateAccountPageURL;
                    });
                });
            });
        </script>
    </head>
    <body>
        <c:import url="../../nav_mobile.html"/>   
        <div class="page-wrapper">
            <c:import url="../../header.html"/>   
            <main class="main main-content">
                <div class="wrap in">
                    <section class="create-account">
                        <h3 class="h3-alt">Create an Account</h3>
                        <p class="description-long">With a account, you can save your 
                            favorite orders, delivery addresses, and payment information. 
                            You'll speed through checkout and will be eating pizza before 
                            you know it! Plus, it's the only way to enroll in Papa Rewards 
                            to earn Free Pizza!</p>
                        <a id="create-account" class="button-alt button-extra-padding button" href="#">Create an Account</a>
                    </section>

                    <section class="sign-in">
                        <h3 class="h3-alt">Already have an account? Sign In</h3>
                        <form id="pizzaOrderingLogin" class="form-account-sign-in" action="../login" method="post">
                            <div class="input-wrap" style="width: 60%;">
                                <label for="signIn-account-sign-in-email">Email Address</label>
                                <input type="email" id="signIn-account-sign-in-email" name="userEmail">
                                </div>
                            <div class="input-wrap" style="width: 60%;">
                                <label for="signIn-account-sign-in-password">Password
                                </label>
                                <input type="password" id="signIn-account-sign-in-password" name="userPwd">
                            </div>
                            <p class="input-wrap"><a href="#" id="signIn-account-sign-in-show-password">Show password</a>
                            </p>

                            <div class="input-wrap">
                                <input id="remember-me" type="checkbox" name="remember_me" value="true">
                                <label for="remember-me">Keep me signed in</label>
                            </div>

                            <div id="signIn-re-captcha">
                            </div>
                            <div class="input-wrap" style="width: 60%;">
                            <span id="signIn-recaptcha_error_msg" class="recaptcha_error_msg error"  style="margin-top: 16px;color: red; text-align: justify;text-justify: inter-word;">
                            </span>
                            </div>

                            <p class="button-set">
                                <button type="submit" class="button-extra-padding button recaptcha-button">Sign In</button>
                                <a href="#" class="button-secondary forgot-password-link">Forgot your password</a>
                            </p>
                        </form>
                    </section>
                </div>
            </main>

            <footer class="site-footer">
                <div>
                    <a class="site-footer-links">
                        <image src="../../images/online-store.png" width="200" height="200">
                        About the Store
                    </a>
                </div>
            </footer>
        </div>
    </body>
</html>