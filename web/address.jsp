<%-- 
    Document   : address
    Created on : May 14, 2019, 10:33:34 AM
    Author     : mycomputer
--%>

<%@page import="java.net.URL"%>
<%@page import="java.util.Base64"%>
<%@page import="javax.crypto.Mac"%>
<%@page import="java.security.NoSuchAlgorithmException"%>
<%@page import="java.security.InvalidKeyException"%>
<%@page import="java.net.URISyntaxException"%>
<%@page import="java.net.URISyntaxException"%>
<%@page import="java.io.UnsupportedEncodingException"%>
<%@page import="javax.crypto.spec.SecretKeySpec"%>
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
        <title>Choose Your Order Type</title>
        
        <script type="text/javascript" src="../js/jquery-3.4.1.min.js"></script>
        <script type="text/javascript" src="../js/jquery-ui.min.js"></script>
        <script type="text/javascript" src="../js/jquery.validate.min.js"></script>
        <%
            String userJSONstr = (String)session.getAttribute("user");
            String addressInfo = "";
            String storeInfo = "";
            String userInfo = "";
                        
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
            String deliveryAddressParam = null;
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
                String resource = "https://maps.googleapis.com/maps/api/js" + '?' + "key=AIzaSyCdgSmJQrHXGR--amVe4rJ-oYYMxxBs1Js&libraries=places&callback=autoComplete";
                
                deliveryAddressParam = (String)session.getAttribute("deliveryAddressParam");
                if (deliveryAddressParam != null) {
                    resource = "https://maps.googleapis.com/maps/api/js" + '?' + "key=AIzaSyCdgSmJQrHXGR--amVe4rJ-oYYMxxBs1Js&libraries=places&callback=nearestDeliveryStore";
                }

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
            
            String deliveryFormURL  = response.encodeURL("./delivery");
            String carryoutFormURL = response.encodeURL("./carryout");

            String indexURL = "../";
            String startOrderURL  = response.encodeURL("../address");
            String retAddrStartOrderURL = response.encodeURL("../address/view");
            String addressDeliveryURL  = response.encodeURL("../address/view?target=DELIVERY");
            String addressCarryoutURL  = response.encodeURL("../address/view?target=CARRYOUT");
            String saveAddrURL  = response.encodeURL("../address/save");
            String addressChangeURL  = response.encodeURL("./change");
            
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
            
        %>
        <script type="text/javascript">
            var CSRF = '${CSRF_address}';
            
            var indexURL = '<%=indexURL%>';
            var menuURL = '<%=menuURL%>';
            var retAddrMenuURL = '<%=retAddrMenuURL%>';
            
            var startOrderURL = '<%=startOrderURL%>';
            var retAddrStartOrderURL = '<%=retAddrStartOrderURL%>';
            
            var saveAddrURL = '<%=saveAddrURL%>';
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
            var checkoutAddr = '<%=checkoutAddr%>';
            var retCheckoutAddr = '<%=retCheckoutAddr%>';
            
            var deliveryAddressParam = '<%=deliveryAddressParam%>';

            var userInfo = '<%=userInfo%>';
            var addressInfo = '<%=addressInfo%>';
            var storeInfo = '<%=storeInfo%>';

            var total = '<%=total%>';
            var count = '<%=count%>';
        </script>
        <script type="text/javascript" src="../js/app.js"></script>
        <script type="text/javascript"> 
            var zipcode = "";
        </script>

        <script type="text/javascript">
            $(document).ready(function() {
                
                Header.init();
                Nav_Mobile.init();
                
                $('#delivery-form-CSRF').val(CSRF);
                $('#carryout-form-CSRF').val(CSRF);
                
                var delivery = true,
                    carryout = false;
                $("#deliveryFormAccordion").css("border-bottom-left-radius", "0px");
                $("#deliveryFormAccordion").css("border-bottom-right-radius", "0px");    
                $(".enter-deliver-add-button .icon-expand").css("transform", "rotate(180deg)");
                
                var urlParams = new URLSearchParams(window.location.search);
                if (urlParams.has('target')) {
                    if (urlParams.get('target') === 'CARRYOUT') {
                        carryout = true;
                        delivery = false;
                        $("#carryout").removeAttr("style");
                        $("#carryoutFormAccordion").css("border-bottom-left-radius", "0px");
                        $("#carryoutFormAccordion").css("border-bottom-right-radius", "0px");    
                        $(".carryout-button .icon-expand").css("transform", "rotate(180deg)");
                        
                        $("#delivery").css("display", "none");
                        $("#deliveryFormAccordion").css("border-bottom-left-radius", "6px");
                        $("#deliveryFormAccordion").css("border-bottom-right-radius", "6px");    
                        $(".enter-deliver-add-button .icon-expand").css("transform", "");
                    } else if (urlParams.get('target') === 'DELIVERY') {
                        carryout = false;
                        delivery = true;
                        $("#delivery").removeAttr("style");
                        $("#deliveryFormAccordion").css("border-bottom-left-radius", "0px");
                        $("#deliveryFormAccordion").css("border-bottom-right-radius", "0px");    
                        $(".enter-deliver-add-button .icon-expand").css("transform", "rotate(180deg)");

                        $("#carryout").css("display", "none");
                        $("#carryoutFormAccordion").css("border-bottom-left-radius", "6px");
                        $("#carryoutFormAccordion").css("border-bottom-right-radius", "6px");    
                        $(".carryout-button .icon-expand").css("transform", "");
                    }
                }
                    
                $("#deliveryFormAccordion").on("click", function(event) {
                    event.preventDefault();
                    if (carryout) {
                        $("#carryout").css("display", "none");
                        $("#carryoutFormAccordion").css("border-bottom-left-radius", "6px");
                        $("#carryoutFormAccordion").css("border-bottom-right-radius", "6px");    
                        $(".carryout-button .icon-expand").css("transform", "");
                        carryout = false;
                    }
                    
                    if (delivery) {
                        $("#delivery").css("display", "none");
                        $("#deliveryFormAccordion").css("border-bottom-left-radius", "6px");
                        $("#deliveryFormAccordion").css("border-bottom-right-radius", "6px");    
                        $(".enter-deliver-add-button .icon-expand").css("transform", "");
                        delivery = false;
                    } else {
                        $("#delivery").removeAttr("style");
                        $("#deliveryFormAccordion").css("border-bottom-left-radius", "0px");
                        $("#deliveryFormAccordion").css("border-bottom-right-radius", "0px");    
                        $(".enter-deliver-add-button .icon-expand").css("transform", "rotate(180deg)");
                        delivery = true;
                    }
                });
                
                $("#carryoutFormAccordion").on("click", function(event){
                    event.preventDefault();
                    if (delivery) {
                        $("#delivery").css("display", "none");
                        $("#deliveryFormAccordion").css("border-bottom-left-radius", "6px");
                        $("#deliveryFormAccordion").css("border-bottom-right-radius", "6px");    
                        $(".enter-deliver-add-button .icon-expand").css("transform", "");
                        delivery = false;
                    }
        
                    if (carryout) {
                        $("#carryout").css("display", "none");
                        $("#carryoutFormAccordion").css("border-bottom-left-radius", "6px");
                        $("#carryoutFormAccordion").css("border-bottom-right-radius", "6px");    
                        $(".carryout-button .icon-expand").css("transform", "");
                        carryout = false;
                    } else {
                        $("#carryout").removeAttr("style");
                        $("#carryoutFormAccordion").css("border-bottom-left-radius", "0px");
                        $("#carryoutFormAccordion").css("border-bottom-right-radius", "0px");    
                        $(".carryout-button .icon-expand").css("transform", "rotate(180deg)");
                        carryout = true;
                    }
                });
                
                if ($('#locations-aptstefloor').val() === "NON") {
                    $('#locations-aptstefloornumber').prop('disabled', 'disabled');
                    $('#locations-aptstefloornumber').addClass('disabled');
                }
                
                $("#locations-aptstefloor").on('change', function() {
                    if ($(this).val() === "NON") {
                        $('#locations-aptstefloornumber').val("");
                        $('#locations-aptstefloornumber').prop('disabled', 'disabled');
                        $('#locations-aptstefloornumber').addClass('disabled');
                    }
                    else {
                        $('#locations-aptstefloornumber').removeClass('disabled');
                        $('#locations-aptstefloornumber').prop('disabled', '');
                    }
                });
                
                var delivery_form_validator = $('#delivery-address').validate({
                    rules: {
                        streetaddress: 'required',
                        zipCode: { 
                            required: true,
                            number: true,
                            minlength: 5
                        },
                        residential_roomnumber: 'required'
                    }
                });
                $('#delivery-address').on('submit', function(event) {
                    event.preventDefault();
                    if (delivery_form_validator.form()) {
                        var address = 
                            $('#locations-streetaddress').val() + ' ' + 
                            $('#locations-aptstefloor').val() + ' ' +
                            $('#locations-aptstefloornumber').val() + ', ' +
                            $('#locations-zipcode').val();

                        $('#spinner').show();
                        $.ajax({
                            method: 'POST',
                            url: '<%=deliveryFormURL%>',
                            beforeSend: function(xhrObj) {
                                xhrObj.setRequestHeader('X-CSRF-Token', $('#delivery-form-CSRF').val());
                            },
                            data: {'deliveryAddressParam' : address}
                        }).done(function() {
                            $.ajax({
                                method: 'GET',
                                url: startOrderURL,
                                beforeSend: function(xhrObj) {
                                    xhrObj.setRequestHeader("X-CSRF-Token", "Fetch");
                                }
                            }).done(function() {
                                window.location.href = retAddrStartOrderURL;
                            });
                        });
                    }
                });
                
                var carryout_form_validator = $('#carryout-address').validate({
                    rules: {
                        carryout_zipcode: { 
                            required: true,
                            number: true,
                            minlength: 5
                        }
                    }
                });
                $('#carryout-address').on('submit', function(event) {
                    event.preventDefault();
                        if (carryout_form_validator.form()) {
                        $.ajax({
                            method: 'POST',
                            url: '<%=carryoutFormURL%>',
                            beforeSend: function(xhrObj) {
                                xhrObj.setRequestHeader('X-CSRF-Token', $('#carryout-form-CSRF').val());
                            },
                            data: $(this).serialize()
                        }).done(function() {
                            window.location.href = '../storelist/view';
                        });
                    }
                });
                
                $('a[id^="enter-"]').on('click', function(event) {
                    event.preventDefault();
                    var id = event.target.id;
                    var str = id.split('-');
                    var newID = str[str.length-1];
                    $('#' + newID + '-input-group').show();
                    var hidingInputGrpID = ($('#' + newID + '-input-group').children('.input').children('.city-zip-switch').attr('id')).split('-')[1] + '-input-group';
                    $('#' + hidingInputGrpID).hide();
                });
                
                $('.close-link').on('click', function(event) {
                    event.preventDefault();
                    $('#modal-dialog').hide();
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
                
                $(".close-alert").on("click", function(event){
                    event.preventDefault();
                    $(".success-message-header").attr("style", "display:none;");
                });
            });
        </script>
        <script type="text/javascript" src="../js/gMap.js"></script>
        <script async defer src="${mapURL}"></script>
    </head>
    <body>
        <c:import url="../nav_mobile.html"/>   
        <div class="page-wrapper">
            <c:import url="../header.html"/>
            <div id="spinner">
                <img id="spinner-img" src="../images/AjaxLoader.gif">
            </div>
            <main class="location">
                <div id="modal-dialog" data-dsc-type="modal" data-dsc-target="clear-page-cart" data-dsc-state="shown" style="left: 649px; top: 80px; display: none;">
                    <a href="#" class="close-link" data-dsc-role="hide" data-dsc-trigger="clear-page-cart"><i class="icon-close icon">Close</i></a>
                    <h3>Sorry, we can't find any stores near you.</h3>
                    <p class="description-long">Your store may not be open at this time or the location you entered is not close enough for carryout or delivery.</p>
                    <form novalidate="novalidate" action="/order/cart/clear" method="get">
                        <button type="submit" class="button-extra-padding button">OK</button>
                        <a data-dsc-state="deselected" data-dsc-trigger="clear-page-cart" class="button--red">Cancel</a>
                    </form>
                </div>
                
                <div id="map" style="display: none;">
                </div>
                <div class="content-wrap clearfix">
                    <div class="h2-new" style="text-align: center;">Find Your Store</div>

                    <div class="page-alert location-alert-success spacing-bottom-sm">
                        <div class="success-message-header">
                            <a href="#" class="close-alert">
                                <i class="icon-close icon">Close</i>
                            </a>
                            <p>  Please enter as much address information below so we can find a local store to serve you.  </p>
                        </div>
                    </div>

                    <div class="location-forms" id="delivery-form">
                        <a href="#" class="accordion-button enter-deliver-add-button"  id="deliveryFormAccordion">
                            <span>Enter Delivery Address</span>
                            <i class="icon-expand icon"></i>
                        </a>

                        <div class="address-form" id="delivery" style="">
                            <form id="delivery-address" action="delivery" method="POST">
                                <input type="hidden" id="delivery-form-CSRF" name="CSRF" value="">
                                <div class="split-2 clearfix">
                                    <div class="input">
                                        <label for="locations-country">Country</label>
                                        <select name="country" id="locations-country">
                                            <option value="usa" selected="">USA</option>
                                            <option value="ca">CANADA</option>
                                        </select>
                                    </div>

                                    <div class="input">
                                        <label for="locations-addresstype">Address Type</label>
                                        <select name="locationType" id="locations-addresstype" class="address-type-change-util valid" aria-invalid="false">
                                            <option value="HOME">Residence</option>
                                            <option value="BUSINESS">Business</option>
                                            <option value="UNIVERSITY">University</option>
                                            <option value="MILITARY">Military</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="input" style="margin-bottom: 16px;">
                                    <label for="locations-streetaddress" class="field-labels">Street Address</label>
                                    <input maxlength="80" type="text" id="locations-streetaddress" name="streetaddress" placeholder="Example: 123 Main St." value="">
                                </div>

                                <label for="locations-aptstefloor" class="field-labels">Apt / Ste / Floor</label>
                                <div class="split-2 clearfix">                        
                                    <div class="input">
                                        <select name="aptstefloor" id="locations-aptstefloor" data-clearable="" data-toggle-input="trigger" class="input-inline">
                                            <option value="NON" data-toggle-input="disabled">None</option>
                                            <option value="APT">Apt</option>
                                            <option value="STE">Suite</option>
                                            <option value="FLR">Floor</option>
                                        </select>
                                    </div>
                                    <div class="input">
                                        <input maxlength="6" type="text" id="locations-aptstefloornumber" name="residential_roomnumber">
                                    </div>                                  
                                </div>
                                
                                <div class="split-2 clearfix" id="zipcode-input-group">
                                    <div class="input">
                                        <label for="locations-zipcode">Zip Code</label>
                                        <input type="text" id="locations-zipcode" name="zipCode" placeholder="Enter zip code">
                                    </div>
                                    <div class="input">
                                        <label style="visibility: hidden;">placeholder</label>
                                        <a class="city-zip-switch" id="enter-city" href="#">
                                            Don't know your Zip?
                                        </a>
                                    </div>
                                </div>
                                <div class="split-2 clearfix" id="city-input-group" style="display: none;">
                                    <div class="input">
                                        <label for="locations-city" class="field-labels">City</label>                  
                                        <input type="text" id="locations-city" name="city" placeholder="Enter city">
                                    </div>

                                    <div class="input">
                                        <label for="locations-state" class="field-labels">State</label>
                                        <select id="locations-state" name="residential-state">
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
                                    <div class="input">
                                        <a class="city-zip-switch" id="enter-zipcode" href="#">Enter Zip.
                                        </a>
                                    </div>
                                </div>

                                <div class="input">
                                    <button class="button" type="submit">Submit</button>
                                </div>
                            </form>
                        </div>
                    </div>

                    <div class="wrapper-box">
                        <div class="side-border"></div>
                        <div class="border-text">
                            <span class="text-or">OR</span>
                        </div>
                        <div class="side-border"></div>
                    </div>

                    <div class="location-forms" id="carryout-form">
                        <a href="#" class="accordion-button carryout-button" id="carryoutFormAccordion">
                            <span>Find Carryout Locations</span>
                            <i class="icon-expand icon"></i>
                        </a>

                        <div class="address-form clearfix" id="carryout" style="display: none;">
                            <div class="split-2">
                                <div class="input">
                                    <img width="130" height="130" src="../images/search-map.png">
                                </div>

                                <div class="input">
                                    <form id="carryout-address">
                                        <input type="hidden" id="carryout-form-CSRF" name="CSRF" value="">
                                        <label for="locations-zipPostalcode" class="field-labels" style="margin-bottom: 8px;">Enter Zip Code</label>
                                        <input maxlength="10" type="text" id="locations-zipPostalcode" name="carryout_zipcode" placeholder="Enter zip code" value="" style="width: 90%;">
                                        <div class="button-group">
                                            <button class="button" type="submit">Submit</button>
                                        </div>
                                    </form>
                                </div>

                            </div>
                        </div>
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