<%-- 
    Document   : createAccount
    Created on : Mar 7, 2019, 6:26:21 PM
    Author     : mycomputer
--%>

<%@page import="javax.crypto.spec.SecretKeySpec"%>
<%@page import="javax.crypto.Mac"%>
<%@page import="java.util.Base64"%>
<%@page import="java.security.InvalidKeyException"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.json.JSONObject"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="icon" href="../../images/online-store.png"  type="image/x-icon">
        
        <title>Create an Account</title>
        <link rel="stylesheet" href="../../styles/main.css">
        
        <script type="text/javascript" src="../../js/jquery-3.4.1.min.js"></script>
        <script type="text/javascript" src="../../js/jquery.validate.min.js"></script>
        <script type="text/javascript" src="../../js/additional-methods.min.js"></script>
        <script type="text/javascript" src="../../js/jquery.maskedinput.js"></script>
        <%
            try {
                String keyString =
                "7umwUrRKxahMjz+y5oPJJRNk587g85dlgCsxSp1lqSK+X+36x1CVtASZBHGv+B+u" +
                "XEGGG0q6+59iq60tSym0ixzRJbLN23K8sMof0GVwf0/d6fIC1IwVMg8Oe4JMuKrV" +
                "sn57NrySo/zHdAsgbHD7Ex/rwlAVu4rUUZ+eLtpPAmr9qPewZUaTBngZTuPckErG" +
                "kds7YWTSaYd1I+as6bW82aQGMNaqU3bJTzRYyg6mtO8hyva90UJveL7rBWEZe9ZM" +
                "1+/0fVgNGlz39UwOg+5wAXLDA7biRhvEYr1oyoPXhuOsQBmiXjqI7hf80jsx9qnn" +
                "CMRv6WSACF/S5b9qU1rZCTl0k2lo/Mlq18DEWAhyNT4dI8x2+GMSc8RF5NxoGDhA" +
                "tqCDBji9CTh3mu+kWgvObbaFJ39AIJaQUWZU4xexJbpKcYz3Cxwe/L21oV7IaNk2" +
                "VIn/AMY5Bqjm1cO5J8mU7pVuFkK3lMtDZKPje2hx5IH/WUcU2Yz/WE3+sjSSS6Fs" +
                "qSe1qfEDNnlv4oduvxMkW6PPXBxvVrLB4pnSIncGKrJRf7ozgPB0gMuUCJ7eMJFJ" +
                "9TbAiqHDPk49imW946J2tuz3Gn4w8gY8ORHQ7RZqa5DlQy14vbO+iW1VHIg21CtQ" +
                "hiReZlgMFTAnjwdjHxkT+CpqRz0Y6EPyhvzNTlQV5s9cRScZ6RlvTbMGqfOya5ca" +
                "UN8XUTGWswl7Xq3wHqN+6YYpnhbYQLcqr2xCP0BmLYQDnwfD9QICStl0Hsp1jp+c" +
                "c8zGs8boBD+m84MBJFZb70wAeBd8m0Pq/iGan5GZAnkMk5ARpDkemuC1IFlRGMbg" +
                "bq3+8QXi6Ekvu5UUcYLcunrVb0zFM+e9U/DWVnxRH7CNnCA2eOMRUZ20ZCX2hNf0" +
                "WV+zQQdrVgInR2MUhs2MXnyN65sA44am72Ih0/QJwxjZOpmLZywnD/zJe3/PqtBv" +
                "0LLZ/jmjB7waRQCZ5zH/O279ZT8TyEmSPQYNmrDg7tpWo7hju+dQwNO895X427M1" +
                "H127AbmXSRDJqF8lpP8oym+Oez09d0AnN3gZ4YoIsbBC7H09TUQG3o9Nx7iabVyZ" +
                "GuNCKgv3Bgh9vX6ZbiZZAknEi4AjGjrovKIjNLdT5k9jJo3rXuCtdjX1hdEM1UAO" +
                "gCknHVUEYQM+9PKfK4wHswiH7aqc3emGMsh5M9F2DARklwbuAiUr7usJD0U+vOwh" +
                "9nDG4i4kz5ZY4ZfAT+xSUbh9Vr4RClIRktHMjxeP9YqpRdqDazWhU2g2re8Nv9Pa" +
                "aa+zI5f1N+7N6AjqaBUaRwLJpSoBWoQTenhwHw5ou/FnU1L0UX3yUE7PAK5DtzUZ" +
                "CWu8ek36aVmSmIMHIQjsqugA5KqNDQlkIAJ4mZjzH46OUkm1VIrfp7Au3WREwcr8" +
                "BCZLSrT83t8Jks/lFTNsO7lnLwvLLQNr79OzEXnEeTgANVCmyFlPE4NqG3FZvKFU" +
                "SCMubz3Ogmsc+uOnp/9kez5sDPNGIlrWw3L9uiKA8B4muhsz8o87WdRxVJIuNysy" +
                "MAhUdVi5m15cKYsf9TydAIKgSHXtkY2k7+XK/kNFDZPN7rsfpfV9fzFctiJfQu2v" +
                "NUob/F5V6ANEFaRb9Bdoa2jjmM/EqpzDXdriUMtp5heS03DKuvhXoeHVFZ4hLy3r" +
                "y4w7EtClUgSJkhWby1yvf+5OH3CKZkrv8OFE76NImbEjMrdotmGpc5HH+6oKhep8" +
                "RUS3xx7K4W4zLH0Wh+UHFiBwDggBgZUGTPkdqFhtadG6ZdhetXacCnpi/z5CxVuu" +
                "ysVczRgeHSrUHaM0OQxIdvN/ktl5JKbOa6nC2yIR+KKAlpvp+vyDWuVnOcCnxxb1" +
                "9i7nLUr3symSEefDiRtuDni3bI9Bc/Aytp5LchZSig1AafgsF04xQaf8NzyYBwo1" +
                "/hOclixUPlvTQA+/6jXa+TcvCDxJyrfqOrZFYGIOE1F/6Sm945R5TkAQHXbL1kga" +
                "+M7KSNE7+p1jQZwU4mvTsbQ+fsq6GktKbr++joN/cikfMtdVKSlXVZbLXfllaZWr" +
                "+qIVjUORnd2Xds5sgWXlSoFGvQxfeN4AvXoPzrqczzTa2t9Z8+/40tcuod9JuBDX" +
                "gH2NSzgud6pxdslPVu3fuwVw4Bo9lXFg4kfnvMMGFV5ekpnRjkHIhOznGqGFmEfy" +
                "600k/jpc5tAmuZ++rqmVcJmczxqyqQ2EaNcVSXBO9bnvP/tLvgBynWxFx52RqLb8" +
                "7d6QFlRk+Q7HSD6pRwInKKyojSbcx73PFD2FcaPaOHhNVojHyLoC53N6pRWm0uLO" +
                "PCnl1Sy8xfU5oshQwUpp0iUa9SlAdHzmOgAgIZSoFgR04R5iBhNbY9kKZ4ClMr6v" +
                "T6iTxl9sh2i/JsCKvymvqBAQj+wEujSAofkTju0JizsfkUOTyh9u/rEBR02hFuq5" +
                "3Ze7w27q1w/34l/BfN9v4D91FQGbqtrkoW9qJBS0eZNVP3gM0FR6Nhjkqls9FjzE" +
                "/CWOQGd98TukVUdSOOQxS/kH33++kAq4L+0YdvB9hayj26JmVBdPrgerGWU8Y5ls" +
                "siogkNTTbxsxNkyBP64iK91swSPFHZ9PVDAwjY626QRvPURwAL5jRn0jG7EbZ9Ja" +
                "2qCRaUwox8d0dDA8Mw5+mdD9s7YjgSjTVMNt+vUv4QQt0dcDPcCQswBo6fu0WYEQ" +
                "HEavBZDbgWB7z0WIheyVI5jWjkGtCu14CadhSSPRFzFW7O2RkRpAe3yvz9wXrdYf" +
                "UY1UJwaGdiSmysWQ7HODdJt1dqtPxGUMXd6fLIsVH+Z/L83PTZ+GF7hQM/eYW1/+" +
                "cABmAojmoeC965sPigfiTeWPCI6g9X5MS4YNbCS8/85MVTZkAVCp6kYSPOcHtIWJ" +
                "6m5ZIa3W135EDcmLPZbCYzBNfgnveiUIsuVsYdg+8PcplJgb0JLG0NcTAtBVSVm6" +
                "wO46m/lwHh5iJ7+H1QcQnz9LwyJGiecdgsnvX5WUipBKofIyxYHzOjo9BtE0z014" +
                "sfYwlN2ISHhocbuyr5Z96BFPxW6Ijb8M7Mvn4fV0evUcWHpcqmQhbRe5tSlVqrAb" +
                "9Bx0VgomKX6C2RkFvewjPFhodPTSjbY1jD57aHrrr2Mw99nunG7wiZRTHNxBCaum";
                byte[] key;
                
                key = Base64.getDecoder().decode(keyString);

                // Retrieve the proper URL components to sign
                String resource = "https://maps.googleapis.com/maps/api/js" + '?' + "key=AIzaSyCdgSmJQrHXGR--amVe4rJ-oYYMxxBs1Js&libraries=places&callback=autoCompleteCreateAcctForm";

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

                session.setAttribute("mapURL", resource + "&signature=" + signature);
            }
            catch (InvalidKeyException ex) {
                ex.printStackTrace();
            }
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
            String createAccountFormURL = response.encodeURL("../../user/create_account");
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
            var createAccountFormURL = '<%=createAccountFormURL%>';
            var signoutURL = '<%=signoutURL%>';
            
            var userInfo = '<%=userInfo%>';
            var addressInfo = '<%=addressInfo%>';
            var storeInfo = '<%=storeInfo%>';
            var cartAddr = '<%=cartAddr%>';
            var retCartAddr = '<%=retCartAddr%>';
            
            var total = '';
            var count = '';
        </script>
        <script type="text/javascript" src="../../js/app.js"></script>
        <script type="text/javascript"> 
            var zipcode = "";
        </script>
        
        <script type="text/javascript">
            $(document).ready(function() {            
                Header.init();
                Nav_Mobile.init();

                jQuery.validator.addMethod("escapecode", function(value, element){
                    if (/^<script\b[^>]*>(.*?)<\/script>/.test(value)) {
                        return false;  // FAIL validation when REGEX matches
                    } else {
                        return true;   // PASS validation otherwise
                    };
                }, "Invalid Input!");
                
                $("input#create-account-phone-number").mask("(999) 999-9999");
                
                if ($('#createAccountForm-aptstefloor').val() === "NON") {
                    $('#createAccountForm-aptstefloornumber').prop('disabled', 'disabled');
                    $('#createAccountForm-aptstefloornumber').addClass('disabled');
                }
                
                $("#createAccountForm-aptstefloor").on('change', function() {
                    if ($(this).val() === "NON") {
                        $('#createAccountForm-aptstefloornumber').val("");
                        $('#createAccountForm-aptstefloornumber').prop('disabled', 'disabled');
                        $('#createAccountForm-aptstefloornumber').addClass('disabled');
                    }
                    else {
                        $('#createAccountForm-aptstefloornumber').removeClass('disabled');
                        $('#createAccountForm-aptstefloornumber').prop('disabled', '');
                    }
                });
                
                var createAccountFormValidator = $("#pizzaOrderingCreateAccount").validate({
                    rules: {
                        firstName: {
                            required : true,
                            escapecode : true
                        },
                        lastName: {
                            required : true,
                            escapecode : true
                        },
                        email: {
                            required: true,
                            email: true
                        },
                        phoneNumber: {
                            required: true,
                            phoneUS: true
                        },
                        password: { 
                            minlength: 8
                        },
                        confirmPassword: {
                            minlength: 8,
                            equalTo: "#create-account-password"
                        },
                        streetAddress: "required",
                        aptSteFloorNumber: "required",
                        usCity: "required",
                        usResidentialTerritoryCode: "required",
                        usPostalCode: "required",
                        ageConsentTermsOfUse: "required"
                    },
                    messages: {
                        firstName: {
                            required: "Please enter your first name!"
                        },
                        lastName: {
                            required: "Please enter your last name!"
                        },
                        email: {
                            required: 'Please enter an email address!',
                            email: 'Please enter a valid email address!'
                        },
                        password: { 
                            minlength: "Please enter at least 8 characters!"
                        },
                        confirmPassword: {
                            minlength: "Please enter at least 8 characters!",
                            equalTo: "Please confirm the password!"
                        }
                    }
                });
                
                $('#pizzaOrderingCreateAccount').on('submit', function(event) {
                    event.preventDefault();
                    $('#createAccountCSRF').val(CSRF);
                    if (createAccountFormValidator.form()) {
                        $.ajax({
                            method: 'POST',
                            url: createAccountFormURL,
                            beforeSend: function(xhrObj) {
                                xhrObj.setRequestHeader("X-CSRF-Token", $('#createAccountCSRF').val());
                            },
                            data: $(this).serialize()
                        }).done(function(data) {
                            if (data.search(/^Success/) === -1) {
                                $('#pizzaOrderingCreateAccount #header-recaptcha_error_msg').append(data);
                            }
                            else {
                                $.ajax({
                                    method: 'GET',
                                    url: loginPageURL,
                                    beforeSend: function(xhrObj) {
                                        xhrObj.setRequestHeader("X-CSRF-Token", "Fetch");
                                    }
                                }).done(function() {
                                    window.location.href = retAddrLoginPageURL;
                                });
//                                window.location.href = retAddrLoginPageURL;
                            }
                        });
                    }
                });
            });
        </script>
        <script type="text/javascript" src="../../js/gMap.js"></script>
        <script async defer src="${mapURL}"></script>
    </head>
    <body>
        <c:import url="../../nav_mobile.html"/>
        <div class="page-wrapper">
            <c:import url="../../header.html"/>

            <section class="banner banner--dark banner--grey banner--two-column banner--rewards paragraph-text">
                <div class="container spacing-top-med spacing-bottom-med ">
                    <div class="banner-image">

                    </div>
                    <div class="banner-details">
                        <h1 class="h2-new title">Want Free Food, Faster and Easier?</h1>
                        <p class="description">The road to free pizza starts here. Let’s get you signed up quick. Then you’ll start earning points.</p>
                    </div>
                </div>
            </section>
            <div id="map" style="display: none;">
            </div>
            <div class="account" data-freight-target="create-account-content location">
                <p id="create-account" class="form-error"></p>

                <div class="container container--narrow spacing-top-sm spacing-bottom-med create-account-section">
                    <section class="spacing-bottom-med spacing-top-sm">
                        <h1 class="h5-new spacing-bottom-xs">Create Your Account</h1>

                        <form id="pizzaOrderingCreateAccount" class="spacing-bottom-sm" style="max-width: 40em;overflow: visible;">
                            <input type="hidden" id="createAccountCSRF" name="CSRF">
                            <div class="form-layout-two-columns">
                                <div class="input input-wrap">
                                    <label for="create-account-firstname">First Name</label>
                                    <input type="text" id="create-account-firstname" name="firstName" required="" maxlength="50" aria-required="true">
                                </div>
                                <div class="input input-wrap">
                                    <label for="create-account-lastname">Last Name</label>
                                    <input type="text" id="create-account-lastname" name="lastName" required="" maxlength="50" aria-required="true">
                                </div>
                                <div class="input input-wrap">
                                    <label for="create-account-email">Email Address</label>
                                    <input type="email" id="create-account-email" name="email" required="" aria-required="true">
                                    <input type="password" name="password_autofill_off" id="password_autofill_off" value="" style="display:none;" placeholder="Create Password">
                                </div>
                                <div class="input input-wrap">
                                    <label for="create-account-phone-number">Phone Number</label>
                                    <input type="tel" id="create-account-phone-number" name="phoneNumber">
                                </div>
                                <div class="input input-wrap">
                                    <label for="create-account-password">Create Password
                                        <p class="inline button--unstyled badge tooltip-new p-link" aria-controls="tooltip-password" aria-label="Toggle Password Requirements">?</p>
                                        <p id="create-account-show-password" class="p-link float-right" aria-label="Show Password" data-togglepass-trigger="create-account-password">Show</p>
                                    </label>
                                    <input id="create-account-password" name="password" type="password" aria-describedby="tooltip-password" data-togglepass-target="create-account-password" required="" aria-required="true">

                                    <div id="tooltip-password" class="popup popup--anchor-left visually-hidden" role="tooltip-new">
                                        <p>
                                            <strong>Your password must meet these requirements:</strong>
                                        </p>
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
                                <div class="input input-wrap">
                                    <label for="createAccountConfirmPwd">Confirm Password</label>
                                    <input type="password" id="createAccountConfirmPwd" name="confirmPassword">
                                </div>
                            </div>

                            <fieldset id="rewards-info-section" class="pacing-top-xs spacing-bottom-sm">
                                <label class="optional">Get even more points by entering your birthday. <em>Optional</em></label>
                                <div class="form-layout-two-columns">
                                    <div class="input custom-select input-wrap">
                                        <select id="birthMonth" name="birthMonth" aria-label="Birth Month (Optional)" data-date-month="birth">
                                            <option value="">Month</option>
                                            <option value="1">January</option>
                                            <option value="2">February</option>
                                            <option value="3">March</option>
                                            <option value="4">April</option>
                                            <option value="5">May</option>
                                            <option value="6">June</option>
                                            <option value="7">July</option>
                                            <option value="8">August</option>
                                            <option value="9">September</option>
                                            <option value="10">October</option>
                                            <option value="11">November</option>
                                            <option value="12">December</option>
                                        </select>
                                    </div>
                                    <div class="input custom-select input-wrap">
                                        <div class="custom-select">
                                            <select id="birthDayOfMonth" name="birthDayOfMonth" aria-label="Birth Day (Optional)" data-date-day="birth">
                                                <option value="">Day</option>
                                                <option value="1">1</option>
                                                <option value="2">2</option>
                                                <option value="3">3</option>
                                                <option value="4">4</option>
                                                <option value="5">5</option>
                                                <option value="6">6</option>
                                                <option value="7">7</option>
                                                <option value="8">8</option>
                                                <option value="9">9</option>
                                                <option value="10">10</option>
                                                <option value="11">11</option>
                                                <option value="12">12</option>
                                                <option value="13">13</option>
                                                <option value="14">14</option>
                                                <option value="15">15</option>
                                                <option value="16">16</option>
                                                <option value="17">17</option>
                                                <option value="18">18</option>
                                                <option value="19">19</option>
                                                <option value="20">20</option>
                                                <option value="21">21</option>
                                                <option value="22">22</option>
                                                <option value="23">23</option>
                                                <option value="24">24</option>
                                                <option value="25">25</option>
                                                <option value="26">26</option>
                                                <option value="27">27</option>
                                                <option value="28">28</option>
                                                <option value="29">29</option>
                                                <option value="30">30</option>
                                                <option value="31">31</option>
                                            </select>
                                        </div>
                                    </div>
                            </div></fieldset>

                            <input id="create-account-rewards" name="RewardsRedeemPoints" type="hidden" value="true">

                            <fieldset class="spacing-bottom-sm checkout-create-account" data-hide="hot">
                                <h5 class="h5-new spacing-bottom-xs">Get Our Latest Rewards Offers</h5>
                                <div class="input input-wrap">

                                    <p class="footnotes spacing-bottom-xs justified-text">Yes! I agree to receive auto-dialed text messages from and on behalf of XXX at the mobile phone number I entered above that contain offers. Consent is not required and is not a condition for purchase. By checking this box I am providing my digital signature. See below for additional mobile terms.*</p>
                                    <input type="checkbox" name="textOffers" id="create-account-textoffers">
                                    <label id="opt-in-text-label" for="create-account-textoffers">SMS/Text</label>
                                    <br>

                                    <p class="footnotes spacing-bottom-xs spacing-top-sm justified-text"> Your email address will never be sold by XXX's. To read our privacy policy
                                        <a href="#" target="_blank" aria-label="Privacy Policy">click here </a>.
                                    To ensure future delivery of emails, please add specials@specials.com to your safe sender list or address book.</p>
                                    <input type="checkbox" name="emailOffers" id="create-account-emailoffers" checked="">
                                    <label id="opt-in-email-label" for="create-account-emailoffers">Email</label>

                                </div>
                            </fieldset>

                            <h5 class="h5-new spacing-bottom-xs">Location</h5>

                <fieldset>


                <div class="form-layout-two-columns">
                    <div class="input input-wrap">
                        <label for="createAccountForm-country">Country</label>
                        <div class="custom-select">
                            <select name="createAccountCountry" id="createAccountForm-country" data-toggle-input="disable" required="" aria-required="true">
                                <option value="usa">USA</option>
                                <option value="ca">CANADA</option>
                            </select>
                        </div>
                    </div>
                    <div class="input input-wrap">
                        <label for="createAccountForm-addresstype">Address Type</label>
                        <div class="custom-select">
                            <select name="locationType" id="createAccountForm-addresstype">
                                <option value="HOME" selected="">Residence</option>
                                <option value="BUSINESS">Business</option>
                                <option value="UNIVERSITY">University</option>
                                <option value="MILITARY">Military</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div data-field-type="createAccountForm-addresstype-UNIVERSITY-fields" class="nodisplay">
                    <div class="form-layout-two-columns">
                        <div data-createaccountform-country="usa" class="input input-wrap">
                            <label for="createAccountForm-university-state">State</label>
                            <div class="custom-select">
                                <select id="createAccountForm-university-state" name="usCampusTerritoryCode" class="input-inline territory-change-util" data-freight-trigger="create-acct-univ-base-territory" data-freight-href="/order/UNIVERSITY.json" data-freight-method="get" data-clearable="" required="" data-input-hidden="" aria-required="true">
                                    <option value="" selected="">Select</option>
                                    <option value="AL">Alabama</option>
                                    <option value="AK">Alaska</option>
                                    <option value="AZ">Arizona</option>
                                    <option value="AR">Arkansas</option>
                                    <option value="CA">California</option>
                                    <option value="CO">Colorado</option>
                                    <option value="CT">Connecticut</option>
                                    <option value="DE">Delaware</option>
                                    <option value="DC">District of Columbia</option>
                                    <option value="FL">Florida</option>
                                    <option value="GA">Georgia</option>
                                    <option value="HI">Hawaii</option>
                                    <option value="ID">Idaho</option>
                                    <option value="IL">Illinois</option>
                                    <option value="IN">Indiana</option>
                                    <option value="IA">Iowa</option>
                                    <option value="KS">Kansas</option>
                                    <option value="KY">Kentucky</option>
                                    <option value="LA">Louisiana</option>
                                    <option value="ME">Maine</option>
                                    <option value="MD">Maryland</option>
                                    <option value="MA">Massachusetts</option>
                                    <option value="MI">Michigan</option>
                                    <option value="MN">Minnesota</option>
                                    <option value="MS">Mississippi</option>
                                    <option value="MO">Missouri</option>
                                    <option value="MT">Montana</option>
                                    <option value="NE">Nebraska</option>
                                    <option value="NV">Nevada</option>
                                    <option value="NH">New Hampshire</option>
                                    <option value="NJ">New Jersey</option>
                                    <option value="NM">New Mexico</option>
                                    <option value="NY">New York</option>
                                    <option value="NC">North Carolina</option>
                                    <option value="ND">North Dakota</option>
                                    <option value="OH">Ohio</option>
                                    <option value="OK">Oklahoma</option>
                                    <option value="OR">Oregon</option>
                                    <option value="PA">Pennsylvania</option>
                                    <option value="RI">Rhode Island</option>
                                    <option value="SC">South Carolina</option>
                                    <option value="SD">South Dakota</option>
                                    <option value="TN">Tennessee</option>
                                    <option value="TX">Texas</option>
                                    <option value="UT">Utah</option>
                                    <option value="VT">Vermont</option>
                                    <option value="VA">Virginia</option>
                                    <option value="WA">Washington</option>
                                    <option value="WV">West Virginia</option>
                                    <option value="WI">Wisconsin</option>
                                    <option value="WY">Wyoming</option>
                                </select>
                            </div>
                        </div>
                        <div data-createaccountform-country="usa" class="input">
                            <label for="createAccountForm-campus-usa">
                                Campus
                                <a class="anchor-new" href="#" target="_blank" aria-label="Campus Learn More">
                                    Learn More
                                </a>
                            </label>
                            <div class="custom-select">
                                <select name="usCampus" id="createAccountForm-campus-usa" class="base-campus-change-util" data-freight-trigger="create-acct-univ-base-campus" data-freight-href="/order/UNIVERSITY/campusBuildings.json" data-freight-method="get" data-clearable="" required="" data-input-hidden="" aria-required="true">
                                    <option value="">Select</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="form-layout-two-columns">
                        <div data-createaccountform-country="canada" class="nodisplay input">
                            <label for="createAccountForm-university-province">Province</label>
                            <div class="custom-select">
                                <select id="createAccountForm-university-province" name="caCampusTerritoryCode" class="input-inline territory-change-util" data-freight-trigger="create-acct-univ-base-territory" data-freight-href="/order/UNIVERSITY.json" data-freight-method="get" data-clearable="" required="" data-input-hidden="" aria-required="true">
                                    <option value="">Select</option>
                                    <option value="AB">Alberta</option>
                                    <option value="BC">British Columbia</option>
                                    <option value="MB">Manitoba</option>
                                    <option value="NB">New Brunswick</option>
                                    <option value="NL">Newfoundland and Labrador</option>
                                    <option value="NT">Northwest Territories</option>
                                    <option value="NS">Nova Scotia</option>
                                    <option value="NU">Nunavut</option>
                                    <option value="ON">Ontario</option>
                                    <option value="PE">Prince Edward Island</option>
                                    <option value="QC">Quebec</option>
                                    <option value="SK">Saskatchewan</option>
                                    <option value="YT">Yukon</option>
                                </select>
                            </div>
                        </div>
                        <div data-createaccountform-country="canada" class="nodisplay">
                            <label for="createAccountForm-campus-canada">
                                Campus
                                <a class="anchor-new" href="#" target="_blank" aria-label="Campus Learn More">
                                    Learn More
                                </a>
                            </label>
                            <div class="custom-select">
                                <select name="caCampus" id="createAccountForm-campus-canada" class="base-campus-change-util" data-freight-trigger="create-acct-univ-base-campus" data-freight-href="/order/UNIVERSITY/campusBuildings.json" data-freight-method="get" data-clearable="" required="" data-input-hidden="" aria-required="true">
                                    <option value="">Select</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="form-layout-two-columns" data-toggle-input-root="">
                        <div class="input  input-wrap">
                            <label for="createAccountForm-university-dormbuilding">Dorm/Building</label>
                            <div class="custom-select">
                                <select name="campusBuildingId" id="createAccountForm-university-dormbuilding" data-clearable="" required="" data-input-hidden="" data-toggle-input="trigger" aria-required="true">
                                    <option value="" data-toggle-input="disabled">Select</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-layout-two-columns">
                            <div class="building-number-field-util nodisplay input input-wrap">
                                <label for="createAccountForm-campus-building-number">Building Number</label>
                                <input value="" maxlength="15" type="text" id="createAccountForm-campus-building-number" name="campusBuildingNumber" class="building-number-input-util disabled" disabled="disabled" data-clearable="" required="" data-input-hidden="" data-toggle-input="target" aria-required="true">
                            </div>
                            <div class="input input-wrap">
                                <label for="createAccountForm-campus-roomnumber">Room Number</label>
                                <input value="" maxlength="30" type="text" id="createAccountForm-campus-roomnumber" name="campusRoomNumber" data-clearable="" data-input-hidden="">
                            </div>
                        </div>
                    </div>
                </div>
                <div data-field-type="createAccountForm-addresstype-MILITARY-fields" class="nodisplay">
                    <div class="form-layout-two-columns">
                        <div data-createaccountform-country="usa" class="input">
                            <label for="createAccountForm-military-state">State</label>
                            <div class="custom-select">
                                <select id="createAccountForm-military-state" name="usBaseTerritoryCode" data-freight-trigger="create-acct-univ-base-territory" class="input-inline territory-change-util" data-freight-href="/order/MILITARY.json" data-freight-method="get" data-clearable="" required="" data-input-hidden="" aria-required="true">
                                    <option value="">Select</option>
                                        <option value="AL">Alabama</option>
                                        <option value="AK">Alaska</option>
                                        <option value="AZ">Arizona</option>
                                        <option value="AR">Arkansas</option>
                                        <option value="CA">California</option>
                                        <option value="CO">Colorado</option>
                                        <option value="CT">Connecticut</option>
                                        <option value="DE">Delaware</option>
                                        <option value="DC">District of Columbia</option>
                                        <option value="FL">Florida</option>
                                        <option value="GA">Georgia</option>
                                        <option value="HI">Hawaii</option>
                                        <option value="ID">Idaho</option>
                                        <option value="IL">Illinois</option>
                                        <option value="IN">Indiana</option>
                                        <option value="IA">Iowa</option>
                                        <option value="KS">Kansas</option>
                                        <option value="KY">Kentucky</option>
                                        <option value="LA">Louisiana</option>
                                        <option value="ME">Maine</option>
                                        <option value="MD">Maryland</option>
                                        <option value="MA">Massachusetts</option>
                                        <option value="MI">Michigan</option>
                                        <option value="MN">Minnesota</option>
                                        <option value="MS">Mississippi</option>
                                        <option value="MO">Missouri</option>
                                        <option value="MT">Montana</option>
                                        <option value="NE">Nebraska</option>
                                        <option value="NV">Nevada</option>
                                        <option value="NH">New Hampshire</option>
                                        <option value="NJ">New Jersey</option>
                                        <option value="NM">New Mexico</option>
                                        <option value="NY">New York</option>
                                        <option value="NC">North Carolina</option>
                                        <option value="ND">North Dakota</option>
                                        <option value="OH" selected="">Ohio</option>
                                        <option value="OK">Oklahoma</option>
                                        <option value="OR">Oregon</option>
                                        <option value="PA">Pennsylvania</option>
                                        <option value="RI">Rhode Island</option>
                                        <option value="SC">South Carolina</option>
                                        <option value="SD">South Dakota</option>
                                        <option value="TN">Tennessee</option>
                                        <option value="TX">Texas</option>
                                        <option value="UT">Utah</option>
                                        <option value="VT">Vermont</option>
                                        <option value="VA">Virginia</option>
                                        <option value="WA">Washington</option>
                                        <option value="WV">West Virginia</option>
                                        <option value="WI">Wisconsin</option>
                                        <option value="WY">Wyoming</option>
                                </select>
                            </div>
                        </div>
                        <div data-createaccountform-country="usa" class="input">
                            <label for="createAccountForm-base">
                                Base
                                <a class="anchor-new" href="#" target="_blank" aria-label="Base Learn More">
                                    Learn More
                                </a>
                            </label>
                            <div class="custom-select">
                                <select name="usBase" id="createAccountForm-base-usa" class="base-campus-change-util" data-freight-trigger="create-acct-univ-base-campus" data-freight-href="/order/MILITARY/campusBuildings.json" data-freight-method="get" data-clearable="" required="" data-input-hidden="" aria-required="true">
                                    <option value="">Select</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="form-layout-two-columns">
                        <div data-createaccountform-country="canada" class="nodisplay input">
                            <label for="createAccountForm-military-province">Province</label>
                            <div class="custom-select">
                                <select id="createAccountForm-military-province" name="caBaseTerritoryCode" data-freight-trigger="create-acct-univ-base-territory" class="input-inline territory-change-util" data-freight-href="/order/MILITARY.json" data-freight-method="get" data-clearable="" required="" data-input-hidden="" aria-required="true">
                                    <option value="">Select</option>
                                    <option value="AB">Alberta</option>
                                    <option value="BC">British Columbia</option>
                                    <option value="MB">Manitoba</option>
                                    <option value="NB">New Brunswick</option>
                                    <option value="NL">Newfoundland and Labrador</option>
                                    <option value="NT">Northwest Territories</option>
                                    <option value="NS">Nova Scotia</option>
                                    <option value="NU">Nunavut</option>
                                    <option value="ON">Ontario</option>
                                    <option value="PE">Prince Edward Island</option>
                                    <option value="QC">Quebec</option>
                                    <option value="SK">Saskatchewan</option>
                                    <option value="YT">Yukon</option>
                                </select>
                            </div>
                        </div>
                        <div data-createaccountform-country="canada" class="nodisplay input">
                            <label for="createAccountForm-base">
                                Base
                                <a class="anchor-new" href="#" target="_blank" aria-label="Base Learn More">
                                    Learn More
                                </a>
                            </label>
                            <div class="custom-select">
                                <select name="caBase" id="createAccountForm-base-canada" class="base-campus-change-util" data-freight-trigger="create-acct-univ-base-campus" data-freight-href="/order/MILITARY/campusBuildings.json" data-freight-method="get" data-clearable="" required="" data-input-hidden="" aria-required="true">
                                    <option value="">Select</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="form-layout-two-columns" data-toggle-input-root="">
                        <div class="input">
                            <label for="createAccountForm-building" data-freight-href="/order/MILITARY/buildingRequired.json">Building</label>
                            <div class="custom-select">
                                <select name="baseBuildingId" id="createAccountForm-building" data-clearable="" required="" data-input-hidden="" aria-required="true">
                                    <option value="">Select</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-layout-two-columns">
                            <div class="building-number-field-util nodisplay input">
                                <label for="createAccountForm-military-building-number">Building Number</label>
                                <input value="" maxlength="15" type="text" id="createAccountForm-military-building-number" name="baseBuildingNumber" class="building-number-input-util" disabled="" data-clearable="" required="" data-input-hidden="" aria-required="true">
                            </div>
                            <div class="input">
                                <label for="createAccountForm-roomnumber">Room Number</label>
                                <input value="" maxlength="30" type="text" id="createAccountForm-roomnumber" name="baseRoomNumber" data-clearable="" data-input-hidden="">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="column--full-width " data-field-type="createAccountForm-addresstype-street-address-fields">
                    <div class="form-layout-two-columns">
                        <div class="input input-wrap">
                            <label for="createAccountForm-streetaddress">Street Address</label>
                            <input maxlength="80" type="text" id="createAccountForm-streetaddress" name="streetAddress" placeholder="Example: 123 Main St." value="" data-clearable="">
                            <input type="hidden" name="latitude" id="latitude">
                            <input type="hidden" name="longitude" id="longitude">
                        </div>
                        <div class="form-layout-two-columns" data-toggle-input-root="">
                            <div class="input input-wrap">
                                <label for="createAccountForm-aptstefloor">Apt / Ste / Floor</label>
                                <div class="custom-select">
                                    <select name="aptCode" id="createAccountForm-aptstefloor" class="input-inline input-small" data-clearable="" data-toggle-input="trigger">
                                        <option value="NON" selected="">None</option>
                                        <option value="APT">Apt</option>
                                        <option value="STE">Suite</option>
                                        <option value="FLR">Floor</option>
                                    </select>
                                </div>
                            </div>
                            <div class="input">
                                <label for="createAccountForm-aptstefloornumber">Number:</label>
                                <input maxlength="6" type="text" id="createAccountForm-aptstefloornumber" name="aptSteFloorNumber" placeholder="" class="input-small input-inline" value="">
                            </div>
                        </div>
                    </div>
                </div>
                <div data-createaccountform-country="usa" data-dsc-state="shown" class=" column--full-width">
                    <div class="form-layout-two-columns" data-dsc-target="createAccountForm-zipcode-city-state-us" data-dsc-state="shown">
                        <div class="input input-wrap">
                            <label for="createAccountForm-usa-city">City</label>
                            <input type="text" id="createAccountForm-usa-city" name="usCity" class="input-inline" placeholder="Enter city" value="">
                        </div>
                        <div class="form-layout-two-columns">
                            <div class="input input-wrap">
                                <label for="createAccountForm-state">State</label>
                                <div class="custom-select">
                                    <select id="createAccountForm-state" name="usResidentialTerritoryCode" class="input-inline input-small" data-clearable="" required="" aria-required="true">
                                        <option value="" selected="">Select</option>
                                        <option value="AL">AL</option>
                                        <option value="AK">AK</option>
                                        <option value="AZ">AZ</option>
                                        <option value="AR">AR</option>
                                        <option value="CA">CA</option>
                                        <option value="CO">CO</option>
                                        <option value="CT">CT</option>
                                        <option value="DE">DE</option>
                                        <option value="DC">DC</option>
                                        <option value="FL">FL</option>
                                        <option value="GA">GA</option>
                                        <option value="HI">HI</option>
                                        <option value="ID">ID</option>
                                        <option value="IL">IL</option>
                                        <option value="IN">IN</option>
                                        <option value="IA">IA</option>
                                        <option value="KS">KS</option>
                                        <option value="KY">KY</option>
                                        <option value="LA">LA</option>
                                        <option value="ME">ME</option>
                                        <option value="MD">MD</option>
                                        <option value="MA">MA</option>
                                        <option value="MI">MI</option>
                                        <option value="MN">MN</option>
                                        <option value="MS">MS</option>
                                        <option value="MO">MO</option>
                                        <option value="MT">MT</option>
                                        <option value="NE">NE</option>
                                        <option value="NV">NV</option>
                                        <option value="NH">NH</option>
                                        <option value="NJ">NJ</option>
                                        <option value="NM">NM</option>
                                        <option value="NY">NY</option>
                                        <option value="NC">NC</option>
                                        <option value="ND">ND</option>
                                        <option value="OH">OH</option>
                                        <option value="OK">OK</option>
                                        <option value="OR">OR</option>
                                        <option value="PA">PA</option>
                                        <option value="RI">RI</option>
                                        <option value="SC">SC</option>
                                        <option value="SD">SD</option>
                                        <option value="TN">TN</option>
                                        <option value="TX">TX</option>
                                        <option value="UT">UT</option>
                                        <option value="VT">VT</option>
                                        <option value="VA">VA</option>
                                        <option value="WA">WA</option>
                                        <option value="WV">WV</option>
                                        <option value="WI">WI</option>
                                        <option value="WY">WY</option>
                                    </select>
                                </div>
                            </div>
                            <div class="input input-wrap" data-dsc-target="createAccountForm-zipcode-city-state-us" data-dsc-state="shown">
                                <label for="createAccountForm-usa-zipcode">Zip Code</label>
                                <input maxlength="10" type="text" id="createAccountForm-usa-zipcode" name="usPostalCode" placeholder="Enter zip code" value="">
                            </div>
                        </div>
                    </div>
                </div>
                <div data-createaccountform-country="canada" class="nodisplay column--full-width">
                    <div class="form-layout-two-columns" data-dsc-target="createAccountForm-zipcode-city-state-canada" data-dsc-state="shown">
                        <div class="input input-wrap">
                            <label for="createAccountForm-canada-city">City</label>
                            <input type="text" id="createAccountForm-canada-city" name="caCity" class="input-inline" placeholder="Enter city" value="" data-clearable="" required="" data-input-hidden="" aria-required="true">
                        </div>
                        <div class="form-layout-two-columns">
                            <div class="input input-wrap">
                                <label for="createAccountForm-province">Province</label>
                                <div class="custom-select">
                                    <select id="createAccountForm-province" name="caResidentialTerritoryCode" class="input-inline input-small" data-clearable="" required="" data-input-hidden="" aria-required="true">
                                        <option value="">Select</option>
                                            <option value="AB">AB</option>
                                            <option value="BC">BC</option>
                                            <option value="MB">MB</option>
                                            <option value="NB">NB</option>
                                            <option value="NL">NL</option>
                                            <option value="NT">NT</option>
                                            <option value="NS">NS</option>
                                            <option value="NU">NU</option>
                                            <option value="ON">ON</option>
                                            <option value="PE">PE</option>
                                            <option value="QC">QC</option>
                                            <option value="SK">SK</option>
                                            <option value="YT">YT</option>
                                    </select>
                                </div>
                            </div>
                            <div class="input input-wrap" data-dsc-target="createAccountForm-zipcode-city-state-canada" data-dsc-state="shown">
                                <label for="createAccountForm-postalcode">Postal Code</label>
                                <input type="text" id="createAccountForm-postalcode" name="caPostalCode" placeholder="Enter postal code">
                            </div>
                        </div>
                    </div>
                </div>
                </fieldset>
                            <!--  NICKNAME FIELD -->
                            <div class="input column--full-width  spacing-bottom-sm">
                                <label for="create-account-addressnickname" class="optional">Nickname<em>Optional</em></label>
                                <input type="text" id="create-account-addressnickname" name="locationName" placeholder="Example: Home, Office, etc">
                            </div>

                            <h5 class="h5-new spacing-top-sm spacing-bottom-xs">Terms of Use</h5>
                            <div class="input input-wrap">
                                <input id="create-account-terms" name="ageConsentTermsOfUse" type="checkbox" required="" aria-required="true">
                                <label for="create-account-terms">I understand &amp; agree to the  <a class="inline" href="#" target="_blank">Terms and Conditions</a> and that my information will be used as described on this page and in the <a href="/privacy-policy.html" class="inline">Privacy Policy</a>.
                                </label>
                            </div>
                            <input type="hidden" name="tcVersion" value="05302018">
                            <div id="header-recaptcha_error_msg" class="recaptcha_error_msg error input" style="margin-top: 16px;color: red; text-align: justify;text-justify: inter-word;">
                                
                            </div>
                            <button type="submit" class="spacing-top-sm button button--green button--medium spacing-bottom-sm" value="Submit">Create Your Account</button>

                        </form>

                    </section>
                </div>
            </div>

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
