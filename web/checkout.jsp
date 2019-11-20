<%-- 
    Document   : checkout
    Created on : Apr 30, 2019, 1:53:15 PM
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
        <title>Checkout</title>
        
        <script type="text/javascript" src="../js/jquery-3.4.1.min.js"></script>
        <script type="text/javascript" src="../js/jquery-ui.min.js"></script>
        <script type="text/javascript" src="../js/jquery.validate.min.js"></script>
        <script type="text/javascript" src="../js/additional-methods.min.js"></script>
        <script type="text/javascript" src="../js/jquery.maskedinput.js"></script>
        <script type="text/javascript" src="../js/mustache.min.js"></script>

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
            
            String placeOrderURL = response.encodeRedirectURL("../checkout/placeorder");
            
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
            var CSRF = '${CSRF_checkout}';
            
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
            
            var placeOrderURL = '<%=placeOrderURL%>';
            
            var userInfo = '<%=userInfo%>';
            var addressInfo = '<%=addressInfo%>';
            var storeInfo = '<%=storeInfo%>';
            var mapURL = '<%=mapURL%>';
            
            var cartInfo = '<%=cartInfo%>';
            var total = '<%=total%>';
            var count = '<%=count%>';
            
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
                Checkout.init(
                    {'cart':(cartInfo.length > 0) ? JSON.parse(cartInfo) : '',
                     'discountrate':0,
                     'taxrate':0});

                sessionStorage.setItem('readyToCheckOut', true);
               
            });
        </script>

    </head>
    <body>

        <c:import url="../nav_mobile.html"/>
        <div class="page-wrapper">

            <c:import url="../header.html"/>
        
            <main class="checkout">
                <form id="place-order" method="post" action="">
                    <div class="contact-payment">
                    <div class="layout-checkout spacing-top-sm">
                        <section class="width-container">
                            <div class="h2-new">Tell Us About Yourself</div>
                            <hr>
                            <!--contact form-->
                            <div class="contact-form clearfix">
                                <fieldset style="border:none;">
                                    <div class="contact-two-columns">
                                        <div class="input">
                                            <label for="checkoutFirstName">First Name</label>
                                            <input type="text" id="checkoutFirstName" name="firstName">
                                        </div>

                                        <div class="input">
                                            <label for="checkoutLastName">Last Name</label>
                                            <input type="text" id="checkoutLastName" name="lastName">
                                        </div>
                                    </div>

                                    <div class="contact-two-columns">
                                        <div class="input">
                                            <label for="checkoutEmail">Confirmation Email</label>
                                            <input type="text" id="checkoutEmail" name="email">
                                        </div>

                                        <div class="input">
                                            <label for="checkoutPhoneNum">Phone Number</label>
                                            <input type="text" id="checkoutPhoneNum" name="phoneNum">
                                        </div>
                                    </div>                                 
                                </fieldset>
                            </div>
                            
                            <div class="input">
                                <input type="checkbox" name="createAccount" id="create-account-from-checkout" value="on">
                                <label for="create-account-from-checkout">
                                    Create an account. I understand &amp; agree to the  
                                    <a class="inline" href="#" target="_blank">Terms and Conditions</a> 
                                    and that my information will be used as described on this page and in the 
                                    <a href="#" class="inline">Privacy Policy</a>.
                                </label>
                            
                                <div id="create-account-password-from-checkout" class="spacing-top-sm" style="display: none;">
                                    <label for="create-account-password">
                                        Create Password
                                        <a id="password-help" href="#help" class="icon-help-alt icon-help icon password-help">Help</a>
                                        <div class="tooltip fade top in" role="tooltip" id="tooltip175010" style="top: 390.094px; left: 130.2656px; display: none;">
                                            <div class="tooltip-arrow"></div>
                                            <div class="tooltip-inner">
                                            <strong>Your password must meet these requirements:</strong><br><br>
                                            <ul>
                                                <li>At least 1 upper case letter</li>
                                                <li>At least 1 lower case letter</li>
                                                <li>At least 1 number</li>
                                                <li>Be between 8 and 25 characters</li>
                                                <li>At least 1 special character (Recommended)</li>
                                                <li>Does not have 3 of the same character in a row (Recommended)</li>
                                            </ul>
                                            </div>
                                        </div>
                                    </label>
                                    <input class="create-account-password" id="create-account-password" name="checkoutAccountPassword" type="password">
                                    <a href="#" id="create-account-show-password" class="create-account-show-password">Show Password</a>
                                </div>
                            </div>
                            
                            <hr>
                            <!--address-->
                            <div class="checkout-order-location-form">
                            </div>

                            <hr>
                            <!--payment form-->
                            <div class="payment-form spacing-top-sm spacing-bottom-sm">
                                <div class="h5-new">Your Payment Information</div>

                                <div id="payment-type">
                                    <ul>
                                        <li><a href="#CREDIT_CARD">CREDIT CARD</a></li>
                                        <li><a href="#CASH">CASH</a></li>
                                    </ul>

                                    <div id="CREDIT_CARD">
                                        <input hidden="" name="cardTypeName" id="cardTypeName">
                                        <div class="payment-two-columns">
                                            <div class="payment-input">
                                                <label for="paymentCardNumber">Card Number</label>
                                                <input type="text" id="paymentCardNumber" name="cardNumber">
                                            </div>

                                            <div class="payment-input">
                                                <label for="paymentCardType">Card Type</label>
                                                <select id="paymentCardType" name="cardType">
                                                    <option value="">-select</option>
                                                    <option value="amex">American Express</option>
                                                    <option value="discover">Discover</option>
                                                    <option value="mastercard">MasterCard</option>
                                                    <option value="visa">Visa</option>
                                                </select>
                                            </div>
                                        </div>

                                        <div class="payment-input">
                                            <label for="paymentNameOnCard">Name on Card</label>
                                            <input type="text" id="paymentNameOnCard" name="nameOnCard">
                                        </div>

                                        <div class="payment-two-columns">
                                            <div class="payment-input">
                                                <label for="paymentExpMonth">Exp. Month</label>
                                                <select id="paymentExpMonth" name="expMonth">
                                                    <option value=""></option>
                                                    <option value="01 - January">01 - January</option>
                                                    <option value="02 - February">02 - February</option>
                                                    <option value="03 - March">03 - March</option>
                                                    <option value="04 - April">04 - April</option>
                                                    <option value="05 - May">05 - May</option>
                                                    <option value="06 - June">06 - June</option>
                                                    <option value="07 - July">07 - July</option>
                                                    <option value="08 - August">08 - August</option>
                                                    <option value="09 - September">09 - September</option>
                                                    <option value="10 - October">10 - October</option>
                                                    <option value="11 - November">11 - November</option>
                                                    <option value="12 - December">12 - December</option>
                                                </select>
                                            </div>

                                            <div class="payment-input">
                                                <label for="paymentExpYear">Exp. Year</label>
                                                <select id="paymentExpYear" name="expYear">
                                                    <option value=""></option>
                                                    <option value="2019">2019</option>
                                                    <option value="2020">2020</option>
                                                    <option value="2021">2021</option>
                                                    <option value="2022">2022</option>
                                                    <option value="2023">2023</option>
                                                    <option value="2024">2024</option>
                                                    <option value="2025">2025</option>
                                                    <option value="2026">2026</option>
                                                    <option value="2027">2027</option>
                                                    <option value="2028">2028</option>
                                                    <option value="2029">2029</option>
                                                    <option value="2030">2030</option>
                                                </select>
                                            </div>
                                        </div>

                                        <div class="payment-two-columns">
                                            <div class="payment-input">
                                                <label for="paymentZipCode">Zip Code</label>
                                                <input type="text" id="paymentZipCode" name="zipCode">
                                            </div>

                                            <div class="payment-input">
                                                <label for="paymentSecurityCode">Security Code</label>
                                                <input type="text" id="paymentSecurityCode" name="securityCode">
                                            </div>
                                        </div>
                                    </div>

                                    <div id="CASH">
                                        <img src="../images/cash.png" width="100">
                                    </div>
                                </div>

                                <p class="input-wrap">
                                    <input type="checkbox" name="termsAgreement" id="input">
                                    <label for="input">Yes, I am 13 years of age or older and accept the
                                        <a href="#" alt="Terms of Use" style="color: #008764;">Terms of Use</a>.
                                    </label>
                                </p>

                                <div class="spacing-top-sm">
                                    <ul class="button-set-stacked spacing-bottom-sm">
                                        <li>
                                            <button id="checkout-review-order">Review Your Order</button>
                                        </li>
                                    </ul>
                                </div>

                                <div class="checkout-edit-links">
                                    <a id="user-info-edit-cart" href="#">Edit Your Cart</a> |
                                    <a id="user-info-shopping" href="#">Continue Shopping</a>
                                </div>
                            </div>

                        </section>

                        <div class="checkout-cart-summary">
                            <section class="receipt">
                                <div class="subtotal-post-discount border-bottom spacing-bottom-sm">
                                    <table class="cart-summary-table">
                                        <tbody>
                                        <tr class="subtotal">
                                            <th>
                                            Total before discounts
                                            </th>
                                            <td class="subtotal-amount amount">
                                            $11.99
                                            </td>
                                        </tr>
                                        <tr class="tax">
                                            <th class="tax-title">
                                            Estimated Tax
                                            </th>
                                            <td class="tax-total amount">
                                            $0.00
                                            </td>
                                        </tr>
                                    </tbody></table>
                                </div>
                                <table>
                                    <tbody><tr class="total">
                                        <th>
                                            Estimated Total
                                        </th>
                                        <td class="estimated-total">
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </section>
                        </div>
                    </div>
                    </div>

                    <div class="review-order" style="display: none;">
                    <div class="layout-checkout spacing-top-sm">
                        <section class="width-container">
                            <h1 class="h2-new">You're Almost Done!</h1>
                            <p>Just make sure the information below is correct and place your order.</p>
                            <hr>

                            <div class="contact-payment-info spacing-top-sm spacing-bottom-sm">
                                <div class="h5-new">Contact &amp; Payment Information</div>
                                <address id="contact-information">Alex Chan<br>xxc@msn.com<br>(614) 477-5889</address>
                                <div class="review-payment-type"><strong>Payment Method:</strong>
                                    <p id="payment-type-name"></p>
                                    <input id="checkout-payment-type" type="hidden" name="paymentType">
                                </div>

                                <p class="links"><a href="#" class="contact-payment-button">Edit Contact &amp; Payment Information</a></p>
                                <hr>
                            </div>

                            <div class="address delivery-address spacing-top-sm spacing-bottom-sm">
                                <div class="schedule-order-form">
                                    <p class="input-wrap">
                                        <input id="schedule-order" name="schedule-pao-order" type="checkbox">
                                        <label for="schedule-order">Schedule your plan ahead order.</label>
                                    </p>
                                    <div class="schedule-order-form" id="schedule-order-pao" style="display: none;">
                                        <h3>Schedule Your Plan Ahead Order</h3>
                                        <p class="spacing-bottom-sm">Not hungry just yet? Schedule your order in advance - anywhere from 1 hour to 21 days in the future! (Larger orders may take longer than 1 hour.)</p>
                                        <div class="split-2">
                                            <div class="input">
                                                <label for="scheduled-date">Date</label>
                                                <input type="text" placeholder="Select Date" name="scheduled-date" id="scheduled-date">
                                                <small>MM/DD/YYYY</small>
                                            </div>
                                            <div class="input">
                                                <label for="scheduled-time">Time</label>
                                                <input type="text" placeholder="Select Time" name="scheduled-time" id="scheduled-time">
                                                <small>Example: 12:00 PM</small>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <hr>
                            </div>

                            <div class="review-order-cart-items spacing-top-sm spacing-bottom-sm">
                                <div class="checkout-title h5-new title spacing-bottom-xs">Your Cart</div>
                                <div class="checkout-edit-links">
                                    <a id="review-order-edit-cart" href="#">Edit Your Cart</a> or
                                    <a id="review-order-shopping" href="#">Continue Shopping</a>
                                </div>
                            </div>
                        </section>

                        <div class="place-order-panel">
                            <section class="receipt">
                                <div class="subtotal-post-discount border-bottom spacing-bottom-sm">
                                    <div class="button-container">
                                        <button type="submit" id="checkout-place-order" name="place-your-order">
                                        Place Your Order
                                        </button>
                                    </div>
                                    <hr>
                                    <table class="cart-summary-table">
                                        <tbody>
                                        <tr class="subtotal">
                                            <th>
                                            Total before discounts
                                            </th>
                                            <td class="subtotal-amount amount">
                                            $11.99
                                            </td>
                                        </tr>
                                        <tr class="tax">
                                            <th class="tax-title">
                                            Estimated Tax
                                            </th>
                                            <td class="tax-total amount">
                                            $0.00
                                            </td>
                                        </tr>
                                    </tbody></table>
                                </div>
                                <table>
                                    <tbody><tr class="total">
                                        <th>
                                            Estimated Total
                                        </th>
                                        <td class="estimated-total" id="estimated-total-summary-checkout-review" data-freight-target="estimated-total">
                                            $11.99
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </section>
                        </div>
                    </div>
                    </div>
                    
                    <div class="order-success" style="display: none;">
                    <div class="layout-checkout spacing-top-sm">
                        <h2 class="cart-title" id="checkout-status"></h2>
                    </div>
                    </div>
                </form>
            </main>

            <footer class="site-footer">
                <div >
                    <a class="site-footer-links"><image src="../images/online-store.png" width="200" height="200">About the Store</a>
                </div>
            </footer>
        </div>
    </body>
</html>