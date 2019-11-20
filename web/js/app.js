/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

var Header = (function() {
    var menuItems = {};
    
    var $menu;
    var menuTitle = '';
    var menuItem = '';
    
    var address = ((addressInfo.length === 0)?null:JSON.parse(addressInfo));//JSON.parse(sessionStorage.getItem('address'));
    var addressForm = '';
    var $addressFormNavElem;
    
    var user = userInfo;
    var $userInfoNavElem;

    var mapMarker =                     
        '<svg class="icon icon-mapmarker" width="15" height="15">' +
            '<use xlink:href="#mapmarker">' +
                '<symbol id="mapmarker" viewBox="0 0 15 15" ' +
                    'class="icon"><path fill="currentColor" d=' +
                    '"M7.5 0C4.4 0 1.8 2.5 1.8 5.7c0 3.1 4.5 9' +
                    '.3 5.7 9.3.9 0 5.7-6.2 5.7-9.3 0-3.2-2.6-' +
                    '5.7-5.7-5.7zm0 8.5c-1.6 0-2.9-1.3-2.9-2.9' +
                    's1.3-2.9 2.9-2.9 2.9 1.3 2.9 2.9-1.3 2.9-' +
                    '2.9 2.9z"></path></symbol>' +
                '<title>Map pin</title>' +
            '</use>' +
        '</svg>';

    var dropDownIcon = 
        '<svg class="icon">' +
            '<use xlink:href="#chevron-down">' +
                '<svg id="chevron-down" viewBox="0 0 20 20">' +
                    '<path fill="currentColor" d="M4.516 7.54'+
                        '8c.436-.446 1.043-.48 1.576 0L10 11' +
                        '.295l3.908-3.747c.533-.48 1.14-.446' +
                        ' 1.574 0 .436.445.408 1.197 0 1.615' +
                        '-.406.418-4.695 4.502-4.695 4.502-.' +
                        '217.223-.502.335-.787.335s-.57-.112' +
                        '-.79-.335c0 0-4.286-4.084-4.694-4.5' +
                        '02s-.436-1.17 0-1.615z">' +
                    '</path>' +
                '</svg>' +
            '</use>' +
        '</svg>';

    var userProfile = 
        '<div id="popup-user" class="popup popup--anchor-right" style="display: none;">' +
            '<div class="spacing-bottom-sm micro-dashboard title">' +
                '<div>' +
                    '<p>Points</p>' +
                    '<strong>0/75</strong>' +
                '</div>' +
                '<div>' +
                    '<p>My Papa Dough</p>' +
                    '<strong>$0.00</strong>' +
                '</div>' +
            '</div>' +
            '<ul>' +
                '<li class="spacing-top-xs">' +
                    '<a href="#">My Rewards</a>' +
                '</li>' +
                '<li>' +
                    '<a href="#">My Favorites</a>' +
                '</li>' +
                '<li>' +
                    '<a href="#">Profile</a>' +
                '</li>' +
                '<li>' +
                    '<a href="#" id="signoutbutton">Sign Out</a>' +
                '</li>' +
            '</ul>' +
        '</div>';

    var userLoginForm = 
        '<div id="popup-login" class="popup popup--anchor-right" style="display:none;">' +
            '<h3 class="h4 title">Log In</h3>' +
            '<form id="header-account-sign-in-form">' +
                '<input type="hidden" id="header-login-CSRF" name="CSRF" value="">' +
                '<div class="input">' +
                    '<label for="header-account-sign-in-email">Email Address</label>' +
                    '<input type="email" id="header-account-sign-in-email" name="userEmail">' +
                '</div>' +
                '<div class="input">' +
                    '<label for="header-account-sign-in-password">Password' +
                        '<a href="#" class="button-secondary forgot-password-link float-right">Forgot your password</a>' +
                    '</label>' +
                    '<input type="password" id="header-account-sign-in-password" name="userPwd">' +
                '</div>' +
                '<div class="input">' +
                    '<input id="remember-me" type="checkbox" name="remember_me" value="true">' +
                    '<label for="remember-me">Keep me signed in</label>' +
                '</div>' +
                '<div id="header-recaptcha_error_msg" class="recaptcha_error_msg error input"' +
                    ' style="margin-top: 16px;color: red; text-align: justify;text-justify: inter-word;"></div>' +
                '<div class="input">' +
                    '<input type="submit" class="button button-extra-padding" value="Sign In">' +
                '</div>' +

                '<div class="popup-footer">' +
                    '<p>Don&#146t have an account? ' +
                        '<a href="#" id="header-login-signup">Sign Up</a></p>' +
                '</div>' +
            '</form>' +
        '</div>';
    
    var _renderAddressForm = function() {
        if (!address) {
            addressForm = '<a href="#" id="start" class="popup-trigger">START YOUR ORDER</a>';
        }
        else {
            let order_type = Object.keys(address)[0];
            let address_str = address[order_type];

            let address_component = address_str.split(',');
            let address_formatted_str = address_component[0] + '<br>';
            let len = address_component.length;
            for (let i = 1; i < len; i++) {
                address_formatted_str += address_component[i].trim();
                if (i < len - 1)
                    address_formatted_str += ', ';
            }
            let store = ((storeInfo.length === 0)?null:JSON.parse(storeInfo));//JSON.parse(sessionStorage.getItem('store'));

            if (order_type === 'CARRYOUT') {
                addressForm =
                '<a class="popup-trigger" href="#popup-delivery" id="popup-trigger-delivery">' +
                    mapMarker +
                    '<span class="show-desktop">' +
                        'Carryout From ' +
                        '<span class="address">' + address_component[0] + '</span>' +
                        dropDownIcon +
                    '</span>' +
                '</a>' +
                '<!-- address dropdown -->' +
                '<div id="popup-delivery" class="popup popup--delivery" style="display:none;">' +
                    '<h3 class="h4 title">Carryout From</h3>' +
                    '<div class="popup-grid popup-block">' +
                        '<p class="block-paragraph">' +
                            address_formatted_str +
                        '</p>' +
                        '<p class="info block-paragraph">' +
                            '<strong>Opening Hours</strong>' +
                            store['opening_hours'] +
                        '</p>' +
                    '</div>' +
                    '<div class="popup-grid popup-block popup-grid-top-spacing">' +
                        '<p class="block-paragraph">' +
                            '<strong>' + store['distance'] + ' Miles Away</strong>' +
                            '<a href="' + store['direction'] + '" target="_blank" class="edit">Get Directions</a>' +
                        '</p>' +
                        '<p class="info block-paragraph">' +
                            '<strong>Phone Number</strong>' +
                            '<a href="tel:' + store['phone'] + '">' + store['phone'] + '</a>' +
                        '</p>' +
                    '</div>' +
                    '<div class="popup-delivery-carryout">' +
                        '<form class="inline-form" action="/order/switch/CARRYOUT/menu">' +
                            '<input type="hidden" name="zipcode" value="43229">' +
                            '<input type="hidden" name="residential-us-city" value="WESTERVILLE">' +
                            '<input type="hidden" name="searchType" value="CARRYOUT">' +
                            '<input type="hidden" name="country" value="USA">' +
                            '<input type="hidden" name="residential-state" value="OH">' +
                            '<a id="edit-carryout" href="#">Change Carry-out Store</a>' +
                            ' | ' +
                            '<a id="edit-delivery" href="#">Change to Delivery</a>' +
                        '</form>' +
                    '</div>' +
                '</div>';
            }
            else if (order_type === 'DELIVERY') {
                let store_address_component;
                let store_address;
                let len;
                if (store !== null) {
                    store_address_component = store['address'].split(',');
                    store_address = store_address_component[0] + '<br>';
                    len = store_address_component.length;
                    for (let i = 1; i < len; i++) {
                        store_address += store_address_component[i].trim();
                        if (i < len - 1)
                            store_address += ', ';
                    }
                }
                addressForm =
                '<a class="popup-trigger" href="#popup-delivery" id="popup-trigger-delivery">' +
                    mapMarker +
                    '<span class="show-desktop">' +
                        'Deliver To ' +
                        '<span class="address">' + address_component[0] + '</span>' +
                        dropDownIcon +
                    '</span>' +
                '</a>' +
                '<!-- address dropdown -->' +
                '<div id="popup-delivery" class="popup popup--delivery" style="display:none;">' +
                    '<h3 class="h4">Deliver To:</h3>' +
                    '<div class="popup-grid popup-block">' +
                        '<p class="block-paragraph">' +
                            address_formatted_str +
                        '</p>' +
                    '</div>' +
                    ( (store === null) ? '' :
                    '<h3 class="h4 title"></h3>' +
                    '<h3 class="h4">Delivery Store:</h3>' +
                    '<div class="popup-grid popup-block popup-grid-top-spacing">' +
                        '<p class="block-paragraph">' +
                            store_address +
                        '</p>' +
                        '<p class="info block-paragraph">' +
                            '<strong>Opening Hours</strong>' +
                            store['opening_hours'] +
                        '</p>' +
                    '</div>' +
                    '<div class="popup-grid popup-block">' +
                        '<p class="block-paragraph">' +
                            '<strong>' + store['distance'] + ' Miles Away </strong>' +
                            '<a href="' + store['direction'] + '" target="_blank" class="edit">Get Directions</a>' +
                        '</p>' +
                        '<p class="info block-paragraph">' +
                            '<strong>Phone Number</strong>' +
                            '<a href="tel:' + store['phone'] + '">' + store['phone'] + '</a>' +
                        '</p>' +
                    '</div>' ) +
                    '<div class="popup-delivery-carryout">' +
                        '<form class="inline-form">' +
                            '<input type="hidden" name="zipcode" value="43229">' +
                            '<input type="hidden" name="residential-us-city" value="WESTERVILLE">' +
                            '<input type="hidden" name="searchType" value="CARRYOUT">' +
                            '<input type="hidden" name="country" value="USA">' +
                            '<input type="hidden" name="residential-state" value="OH">' +
                            '<a id="edit-delivery" href="#">Edit Delivery Address</a>' +
                            ' | ' +
                            '<a id="edit-carryout" href="#">Change to Carry-out</a>' +
                        '</form>' +
                    '</div>' +
                '</div>';
            }
        }
        if (menuItems.addressFormNavElem[0].childElementCount > 0) {
            if (menuItems.addressFormNavElem.children('.popup-trigger').length !== 0) {
                menuItems.addressFormNavElem.children('.popup-trigger').remove();
            }
            if (menuItems.addressFormNavElem.children('.popup').length !== 0) {
                menuItems.addressFormNavElem.children('.popup').remove();
            }
        }
        menuItems.addressFormNavElem.append(addressForm);
    };
    
    var _renderMenuTitle = function(title) {
        menuTitle = 
            '<a href="#popup-user" class="popup-trigger" id="popup-trigger-user">' +
                title +
                dropDownIcon +
            '</a>';
    };
    var _renderLoginProfile = function() {
        user = (user.length > 0 ? JSON.parse(user) : null);
        let name;
        if (user)
            name = user['name'];
        if (name !== undefined) {
            _renderMenuTitle('Hi, ' + name);
            menuItem = 
                menuTitle +
                userProfile;

            menuItems.userInfoNavElem.next().remove();
        } else if (name === undefined) {
            _renderMenuTitle('Log In');
            menuItem = 
                menuTitle +
                userLoginForm;
            $('<li class="nav-util-item show-desktop"><a href="#">SIGN UP</a></li>').insertAfter(menuItems.userInfoNavElem);
        }
        
        if (menuItems.userInfoNavElem[0].childElementCount > 0) {
            menuItems.userInfoNavElem.children('.popup-trigger').remove();
            menuItems.userInfoNavElem.children('.popup').remove();
        }
        menuItems.userInfoNavElem.append(menuItem);
        
        if (name === undefined) {
            _initLoginForm();
        }
    };
    
    var _initLoginForm = function() {
        
        $('#header-login-signup').on('click', function(event) {
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
        
        var validator = $('#header-account-sign-in-form').validate({
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

        $('#header-account-sign-in-form').on('submit', function(event) {
            event.preventDefault();
            $('#header-login-CSRF').val(CSRF);
            if (validator.form()) {
                $.ajax({
                    url: headerLoginURL,
                    method: 'POST',
                    beforeSend: function(xhrObj) {
                        xhrObj.setRequestHeader("X-CSRF-Token", CSRF);
                    },
                    data: $(this).serialize()
                }).done(function(data) {
                    if (data.search(/^Success/) === -1) {
                        $('#header-account-sign-in-form #header-recaptcha_error_msg').append(data);
                    }
                    else {
                        user = data.split("Success")[1];
                        if (user.length > 0) {
                            _renderLoginProfile();
                            user = JSON.stringify(user);
                            //_renderAddressForm();
                            _initMenuItem();
                            let path = window.location.pathname;
                            if (path === "/checkout/view") {
                                user = JSON.parse(user);
                                $('#checkoutFirstName').val(user.name);
                                $('#checkoutLastName').val(user.lastName);
                                $('#checkoutEmail').val(user.email);
                                $('#checkoutPhoneNum').val(user.phone);
                            }
                        }
                    }
                });
            }
        });
    };
    
    var _renderUserInfoCheckOut = function() {

    };
    
    var _renderElements = function() {
        $('.nav-util .nav-container .logo').attr('href', indexURL);
        _renderAddressForm();
        _renderLoginProfile();
    };
    
    var _initMenuItem = function() {
        $.each(menuItems, function(k, menuTrigger) {
            if (menuTrigger[0].childElementCount === 1) {
                menuTrigger.children('.popup-trigger').on('click', function(event) {
                    event.preventDefault();
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
            } else if (menuTrigger[0].childElementCount === 2) {
                menuTrigger.children('.popup-trigger').on('click', function(event) {
                    event.preventDefault();
                    event.stopPropagation();
                    $menu.find('.popup:visible').hide();
                    $(this).next('.popup').show();
                });

                menuTrigger.children('.popup').on('click', function(event) {
                    event.stopPropagation();
                });
            }
        });
        
        $('#edit-delivery').on('click', function(event) {
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
        
        $('#edit-carryout').on('click', function(event) {
            event.preventDefault();
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
        
        $('#signoutbutton').on('click', function(event) {
            event.preventDefault();
            $.ajax({
                method: 'POST',
                url: signoutURL,
                beforeSend: function(xhrObj) {
                    xhrObj.setRequestHeader("X-CSRF-Token", CSRF);
                }
            }).done(function() {
                window.location.href = "";
            });
        });
        
        $(window).on('click', function() {
            $menu.find('.popup:visible').hide();
        });
    };
    
    var _initCart = function() {
        let item_count = 0;
        let total_price = 0.00;

        total_price = (total.length === 0) ? 0 : parseFloat(total);
        item_count = (count.length === 0) ? 0 : parseInt(count);

        let cart = 
        '<a id="cart-link" href="#">' +
            '<svg xmlns="http://www.w3.org/2000/svg" width="15" height="15"' +
                ' viewBox="0 0 15 15" class="shop-cart-icon">' +
                '<title>Shopping cart</title>' +
                '<path fill="currentColor" d="M12 12c.8 0 1.5.7 1.5 1.5S1' +
                    '2.8 15 12 15s-1.5-.7-1.5-1.5.7-1.5 1.5-1.5zM0 0h2.5l' +
                    '.7 1.5h11.1c.5 0 .8.4.8.8 0 .1 0 .2-.1.4l-2.7 4.9c-.' +
                    '3.4-.8.6-1.4.6H5.3l-.6 1.2v.1c0 .1.1.1.2.1h8.7v1.5h-' +
                    '9c-.9.1-1.6-.6-1.6-1.4 0-.2.1-.5.1-.7l1-1.9-2.6-5.6H' +
                    '0V0zm4.5 12c.8 0 1.5.7 1.5 1.5S5.3 15 4.5 15 3 14.3 ' +
                    '3 13.5 3.7 12 4.5 12z"></path>' +
            '</svg>' +
            ((item_count > 0) ? 
                '<span class="items-in-cart">' + item_count + '</span>' : 
                '<span class="items-in-cart" style="visibility:hidden;">0</span>') +
            '<span class="items-total-price"><span class="currency">&#36;</span>' +
                ((item_count > 0) ? total_price : '0.00') +
            '</span>' +
        '</a>';
        $('#cart').append(cart);
        
        $('#cart-link').on('click', function(event) {
            event.preventDefault();
            $.ajax({
                method: 'GET',
                url: cartAddr,
                beforeSend: function(xhrObj) {
                    xhrObj.setRequestHeader("X-CSRF-Token", "Fetch");
                }
            }).done(function() {
                window.location.href = retCartAddr;
            });
        });
    };
    
    var updateCart = function(item_count, total_price) {
        $(".items-in-cart").html(item_count);
        if (item_count > 0)
            $(".items-in-cart").css("visibility", "visible");
        else
            $(".items-in-cart").css("visibility", "hidden");
        
        if (total_price === 0)
            $(".items-total-price").html('<span class="currency">&#36;</span>'+'0.00');
        else
            $(".items-total-price").html('<span class="currency">&#36;</span>'+total_price);
    };
    
    var _initElements = function() {
        _initMenuItem();
        _initCart();
        
        let path = window.location.pathname;
        if (path === "/menu/view") {
            $('#MENU').addClass('active');
        }
        if (path === "/checkout/view") {
            let checkoutNav = 
                '<nav role="navigation" class="nav-container">' +
                    '<ul class="nav-main-menu-list" id="checkout">' +
                        '<li class="nav-main-menu-item" id="payment"><a class="nav-main-link active" >PAYMENT & CONTACT</a></li>' +
                        '<li class="nav-main-menu-item" id="review"><a class="nav-main-link">REVIEW YOUR ORDER</a></li>' +
                        '<li class="nav-main-menu-item" id="success"><a class="nav-main-link">SUCCESS!</a></li>' +         
                    '</ul>' +
                '</nav>';
            $('.nav-main-menu').children().remove();
            $('.nav-main-menu').append(checkoutNav);
        }
        
        $('a:contains("MENU")').on('click', function(event) {
            event.preventDefault();
            $.ajax({
                method: 'GET',
                url: menuURL,
                beforeSend: function(xhrObj) {
                    xhrObj.setRequestHeader("X-CSRF-Token", "Fetch");
                }
            }).done(function(){
                window.location.href = retAddrMenuURL;
            });
        });
    };
    
    var init = function() {
        menuItems.addressFormNavElem = $('ul[class="nav-util-list"] li:first-child');
        $addressFormNavElem = menuItems.addressFormNavElem;
        menuItems.userInfoNavElem = $addressFormNavElem.next();
        $userInfoNavElem = menuItems.userInfoNavElem;
        $menu = $('ul[class="nav-util-list"]');
        _renderElements();
        _initElements();
    };
    
    return {init: init,
            updateCart: updateCart};
})();

var Nav_Mobile = (function() {
    var isOpen = false;
    
    var _initElements = function() {
        
        $('#top-nav-sign-up').on('click', function(event) {
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
        
        $('#top-nav-log-In').on('click', function(event) {
            event.preventDefault();
            $.ajax({
                method: 'GET',
                url: loginPageURL,
                beforeSend: function(xhrObj) {
                    xhrObj.setRequestHeader("X-CSRF-Token", "Fetch");
                }
            }).done(function() {
                window.location.href = retAddrLoginPageURL;
            });
        });
        
        $('.nav-trigger').on('click', function() {
            if (isOpen === false) {
                $('#navigation-mobile').show();
                $('body').addClass('mobile-nav-open');
                isOpen = true;
            }
            else {
                $('#navigation-mobile').hide();
                $('body').removeClass('mobile-nav-open');
                isOpen = false;
            }
        });

        $(window).on('resize', function() {
            if ($(this).width() > 832 && $('#navigation-mobile').is(':visible')) {
                $('#navigation-mobile').hide();
                $('body').removeClass('mobile-nav-open');
                isOpen = false;
            }
        });
    };
    
    var init = function() {
        _initElements();
    };
    
    return {init:init};
})();

var Menu = (function() {
    var types;
    var subTypes;
    var items;
    var prices;
    var subTypesMap;     
    var ingredients;
            
    var dialog;
    var item_count = 0,
        total_price = 0.00;
    var index = 0;
    var data = [];
    var numOfProd;
    var prodCount = 0;
    var toppingListCache = JSON.parse(sessionStorage.getItem('toppingListCache'));
    
    $.loadImage = function(url, id) {
        // Define a "worker" function that should eventually resolve or reject the deferred object.
        var loadImage = function(deferred) {
            var image = $("<img>"); //$("<img>")

            // Set up event handlers to know when the image has loaded
            // or fails to load due to an error or abort.
            image.on("load", loaded);
    //                        image.onerror = errored; // URL returns 404, etc
    //                        image.onabort = errored; // IE may call this if user clicks "Stop"

            // Setting the src property begins loading the image.
            image.attr("src", url);
            image.attr("id", id);
            image.attr("alt", url.split("/")[2]);
            //image.src = url;
            //image.id = id;
            //image.alt = url.split("/")[2];

            function loaded() {
                unbindEvents();

                deferred.resolve(image);
            }
            function errored() {
                unbindEvents();
                // Calling reject means we failed to load the image (e.g. 404, server offline, etc).
                deferred.reject(image);
            }
            function unbindEvents() {
                // Ensures the event callbacks only get called once.
                image.onload = null;
                image.onerror = null;
                image.onabort = null;
            }
        };

        // Create the deferred object that will contain the loaded image.
        // We don't want callers to have access to the resolve() and reject() methods, 
        // so convert to "read-only" by calling `promise()`.
        return $.Deferred(loadImage).promise();
    };
    
    var _renderTabs = function() {
        var len = types.length;
        var $navLinkList = $("<ul>").addClass("subnavigation--horizontal").addClass("container");
        var $tabs = $("#tab").append($navLinkList);

        for (var i = 0; i < len; i++) {
            var $navLinkListChild = $("<li>");
            var $navLink = $("<a>").attr("href", "#" + types[i]).append(types[i]).appendTo($navLinkListChild);
            if (i === 0) {
                $navLink.addClass("active");
            }
            $navLinkListChild.appendTo($navLinkList);
            var $tab = $("<div>").attr("id", types[i]).addClass("tab-item");

            $tabs.append($tab);
        }
    };
    
    var _renderSection = function () {
        for (type in subTypes) {
            var $tab = $("#" + type);
            var len = subTypes[type].length;

            for (var i = 0; i < len; i++) {
                var $section = $("<section>").addClass("spacing-bottom-med");

                var $h2 = $("<div>").addClass("h2").append(subTypes[type][i]);
                $("<header>").addClass(".spacing-bottom-sm")
                    .append($h2)
                    .appendTo($section);

                var $slider = $("<div>").addClass("slider")
                    .addClass("slider-menu")
                    .addClass("margin-bottom-lg")
                    .attr("id", "slider-" + index++);

                var $leftBtn = $("<button>").addClass("slider-button")
                    .attr("id", "slider-button-left-" + (index - 1))
                    .attr("disabled", "true")
                    .append('<svg xmlns="http://www.w3.org/2000/svg"' +
                            ' width="16" height="16" fill="currentColor"' +
                            ' data-id="geomicon-chevronLeft" viewBox="0 0 32 32">' +
                                '<path d="M20 1 L24 5 L14 16 L24 27 L20 31 L6 16 z"></path>' +
                            '</svg>');
                var $rightBtn = $("<button>").addClass("slider-button")
                    .attr("id", "slider-button-right-" + (index - 1))
                    .attr("disabled", "true")
                    .append('<svg xmlns="http://www.w3.org/2000/svg"' +
                            ' width="16" height="16" fill="currentColor"' +
                            ' data-id="geomicon-chevronRight" viewBox="0 0 32 32">' +
                                '<path d="M12 1 L26 16 L12 31 L8 27 L18 16 L8 5 z"></path>' +
                            '</svg>');
                var prodLen = items[subTypes[type][i]].length;
                if (prodLen > 4) {
                    $rightBtn.removeAttr("disabled");
                }
                $slider.append($leftBtn)
                    .append($rightBtn);

                var $containterCover = $("<div>").addClass("slider-cover");
                var $itemListCont = $("<div>").addClass("slider-overflow");
                var $itemList = $("<ul>").attr("id", "list-" + (index - 1));

                $itemListCont.append($itemList)
                    .appendTo($containterCover);
                $slider.append($containterCover);
                $section.append($slider);
                $tab.append($section);
            } 
        }
    };
    
    var _renderCard = function() {
        for (subType in items) {
            var len = items[subType].length;
            var $itemList = $('div:contains("' + subType + '")')
                    .parent("header").next(".slider.slider-menu")
                    .children(".slider-cover").children().children();
            var isPizza = (subTypesMap[subType] === "PIZZAS") ? true : false;

            var id = $itemList.attr("id").split("-")[1];
            $itemList.attr("id", "list-" + id + "-" + len);

            for (var i = 0; i < len; i++) {
                var itemID = items[subType][i]["item_id"];
                var customizeBtn = '';
                if (isPizza) {
                    customizeBtn =
                        '<button id="item-customize-button-0-' + itemID + '" type="submit"' +
                            ' class="button button-large button-alt">Customize</button>';
                }
                var form = 
                    '<div class="item-details" id="item-details-0-'+ itemID +'">' +
                        '<div class="item-image" id="item-image-' + id + "-" + itemID + '">' +
                        '<img id="'+ id + itemID +'" src="../images/items/' + 
                            items[subType][i]["item_name"] +'.jpg"></div>' +
                        '<div class="item-description">' +
                            '<h3 class="spacing-bottom-sm">' +
                                items[subType][i]["item_name"] + '</h3>' +
                            '<p class="item-description-short"></p>' +
                        '</div>' +
                        '<form class="item-order-form"' +
                            ' id="item-order-form-0-'+ itemID + '">' +
                            '<input name="line_num" id="line-num-0-' + itemID + '"' +
                                ' type="hidden" value="'+ item_count +'">' +
                            '<input name="item_id" id="item-id-0-' + itemID +'"' +
                                ' type="hidden" value="'+ itemID +'">' +
                            '<input id="item-name-0-' + itemID +'"' +
                                ' type="hidden" name="item_name" value="'+ items[subType][i]["item_name"] +'">' +
                            '<input id="item-type-0-' + itemID +'"' +
                                ' type="hidden" name="item_type" value="'+ subTypesMap[subType] +'">' +  
                            "<input id='item-toppings-0-" + itemID + "'" +
                                " type='hidden' name='toppings' value='"+ JSON.stringify(ingredients[items[subType][i]["item_name"]]) +"'>" +  
                            '<input id="item-prices-0-' + itemID +'"' +
                                'name="item_size_price" type="hidden" value="">' +
                            '<div class="item-size-selection" id="item-size-' + itemID + '">' +
                                '<select name="item_price" id="item-size-selection-0-' +
                                    itemID + '" class="input">' +
                                '</select>' +
                            '</div>' +
                            '<div class="item-qty-selection">' +
                                '<input name="item_qty" id="item-quantity-spinner-0-' +
                                    itemID + '" type="number" value="1" min=1>' +
                            '</div>' + 
                            '<div class="button-group">' +
                                '<button id="add-to-cart-button-0-' + itemID + '" type="button"' +
                                    ' class="button button-large button-extra-padding">Add to cart</button>' +
                                customizeBtn +
                            '</div>' +
                        '</form>' +
                    '</div>';
                var button = '<button class="item-order-button"' +
                                    'id="item-order-button-0-' + itemID +
                                    '">Order Now</button>';
                if (items[subType][i]["item_name"] === "Create Your Own") {
                    button =  '<button class="item-order-button" id="customization-button-' + itemID +'">' +
                                    'Customize</button>';
                    form = 
                        '<div class="item-details" id="item-details-0-'+ itemID +'">' +
                            '<div class="item-description">' +
                                '<h3 class="spacing-bottom-sm">' +
                                    items[subType][i]["item_name"] + '</h3>' +
                                '<p class="item-description-short"></p>' +
                            '</div>' +
                            '<form id="customization-form">' +
                                '<input name="line_num" id="line-num-0-' + itemID +'"' +
                                    ' type="hidden" value="'+ item_count +'">' +
                                '<input name="item_id" id="item-id-0-' + itemID +'"' +
                                    ' type="hidden"value="'+ itemID +'">' +
                                '<input id="item-name-0-' + itemID +'"' +
                                    'name="item_name" type="hidden" value="'+ items[subType][i]["item_name"] +'">' +
                                '<input id="item-type-0-' + itemID +'"' +
                                    'name="item_type" type="hidden" value="'+ subTypesMap[subType] +'">' +  
                                "<input id='item-toppings-0-" + itemID + "'" +
                                    " type='hidden' name='toppings' value='"+ JSON.stringify(ingredients[items[subType][i]["item_name"]]) +"'>" + 
                                '<input id="item-prices-0-' + itemID +'"' +
                                    'name="item_size_price" type="hidden" value="">' +
                                '<div class="item-size-selection" id="item-size-' + itemID + '">' +
                                    '<select name="item_price" id="item-size-selection-0-' +
                                        itemID + '" class="input">' +
                                    '</select>' +
                                '</div>' +
                                '<div class="item-qty-selection">' +
                                    '<input name="item_qty" id="item-quantity-spinner-0-' +
                                        itemID + '" type="number" value="1" min=1>' +
                                '</div>' + 
                            '</form>' +
                        '</div>';
                }
                var card = 
                    '<li class="slider" id="list-child-' + itemID + '">' +
                        '<div class="menu-card">' +
                            '<div class="card-image" id="card-image-' + id + "-" + itemID  + '">' +
                                '<img id="'+ id + "-" + itemID +'" src="../images/items/'+ items[subType][i]["item_name"] +'.jpg">' +
                            '</div>' +
                            '<div class="card-details">' +
                                '<div class="card-header">' +
                                    '<span class="title h3-new">' + 
                                        items[subType][i]["item_name"] + '</span>' +
                                '</div>' +
                                '<div class="card-actions">' +
                                    button +
                                '</div>' +
                                form +
                            '</div>' +
                        '</div>' +
                   '</li>';

                $itemList.append(card);

                $.loadImage("../images/items/" + items[subType][i]["item_name"] + ".jpg", (id + "-" + itemID ))
                    .done(function(image) {
                        var str = image.attr("id").split("-");
                        var listIdx = str[0];
                        var $list = $("ul[id^='list-" + listIdx + "-']");
                        if (image[0].complete) {
                            var $nextChild =  $list.children("li[id='list-child-" + str[1] + "']").next().length;
                            var last = ( (!$nextChild.length) ? true : false);

                            if (last) {
                                $list.parent(".slider-overflow").parent(".slider-cover").height($list.height());
                            }
                        }
                        prodCount++;
                        if (prodCount === numOfProd) {
                            $("#tab .tab-item").each(function() {
                                if (this.id !== "PIZZAS")
                                    $(this)[0].style.display = "none";
                            });
                        }
                    });
            }
        }
    };
    
    var _renderPriceList = function() {               
        for (itemID in prices) {
            var $priceOptionSelect = $("select[id='item-size-selection-0-" + itemID + "'");
            var priceList = {};
            for (priceDesc in prices[itemID]) {
                var price = prices[itemID][priceDesc];
                var $option = $("<option value='" + priceDesc + " " + price + "' " +
                    ((priceDesc.search(/^Large/) !== -1) ? "selected" : "") + ">" + 
                    priceDesc + " $" + price + "</option>");
                $priceOptionSelect.append($option);

                var priceStr = ( (priceDesc.search("Original") !== -1) ? 
                                    priceDesc.substring(0, priceDesc.search("Original")-1) : 
                                    (priceDesc.search("Thin-Crust") !== -1 ? 
                                        priceDesc.split("-")[0] : priceDesc) );
                priceList[priceStr.toUpperCase()] = price;
            }
            $('#item-prices-0-' + itemID).val(JSON.stringify(priceList));
        }
    };
    
    var _renderElements = function() {
        _renderTabs();
        _renderSection();
        _renderCard();
        _renderPriceList();
    };
    
    var _initElements = function() {
        $(".slider-button").on("click", function(event) {
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

        $(window).on('resize', function(){
            $(".slider-overflow").each(function() {                    
                var $rightBtn = $(this).parent(".slider-cover").prev();
                var $leftBtn = $rightBtn.prev();
                var $list = $(this).children("ul");
                $(this).parent().height($list.height());
                if ($rightBtn.is(":disabled")) {
                    //var $list = $(this).children("ul");
                    //$(this).parent().height($list.height());
                    var listChildCount = $list[0].childElementCount;
                    var listChildWidth = $list.children("li")[0].clientWidth;
                    //var listWidth = $(this).children("ul")[0].offsetWidth;
                    var divWidth = $(this)[0].offsetWidth;
                    if (listChildCount > 1 && ((listChildCount - 0.5) * listChildWidth) > divWidth) {
                        $rightBtn.removeAttr("disabled");
                    }
                } else {
                    //var $list = $(this).children("ul");
                    //$(this).parent().height($list.height());
                    var listChildCount = $list[0].childElementCount;
                    var listChildWidth = $list.children("li")[0].clientWidth;
                    //var listWidth = $(this).children("ul")[0].offsetWidth;
                    var divWidth = $(this)[0].offsetWidth;
                    if ((listChildCount * listChildWidth) < divWidth) {
//                                if ($rightBtn.not(":disabled")) {
                        $rightBtn.attr("disabled", "true");
//                                }
//                                if ($leftBtn.not(":disabled")) {
                        $leftBtn.attr("disabled", "true");
//                                }
                    }
                }                     
            });
        });

        $("button[id^='item-order-button-0-']").on("click", function(event){
            
            var id = event.target.id;
            var str = id.split("-");
            var newID = str[str.length-1];

            dialog = $("#item-details-0-" + newID).dialog({
                modal: true
            });
            $("#item-details-0-" + newID + ", .ui-dialog-titlebar").css({
                "background-color" : "transparent",
                "border" : "none"
            });

        });

        //---------------menu/add--------------------
        $("button[id^='add-to-cart-button-0-']").on('click', function(event) {

            var id = event.target.id;
            var str = id.split("-");
            var newID = str[str.length-1];

            $('#line-num-0-' + newID).val(item_count);
            $.ajax({
                method: 'POST',
                url: menuAddItemURL,
                beforeSend: function(xhrObj) {
                    xhrObj.setRequestHeader("X-CSRF-Token", CSRF);
                },
                data: $('#item-order-form-0-' + newID).serialize()
            }).done(function(results) {
                let result = JSON.parse(results);
                Header.updateCart(result['item_count'], result['total_price']);
                dialog.dialog("close");
            });
            
        });

        //---------------/create ('customize pizza')--------------------
        $("form[id^='item-order-form-0-']").on("submit", function(event) {
            
            event.preventDefault();
            var id = event.target.id;
            var str = id.split("-");
            var newID = str[str.length-1];

            $('#line-num-0-' + newID).val(item_count);
            $.ajax({
                method: 'POST',
                url: '../menu/add/item',
                beforeSend: function(xhrObj) {
                    xhrObj.setRequestHeader("X-CSRF-Token", CSRF);
                },
                data: $('#item-order-form-0-' + newID).serialize()
            }).done(function() {
                $.ajax({
                    method: 'GET',
                    url: customization,
                    beforeSend: function(xhrObj) {
                        xhrObj.setRequestHeader("X-CSRF-Token", 'Fetch');
                    }
                }).done(function() {
                    window.location.href = retCustomization;
                });
            });
            
        });

        $("button[id^='customization-button'").on('click', function(event) {
            
            var id = event.target.id;
            var str = id.split("-");
            var newID = str[str.length-1];

            $('#line-num-0-' + newID).val(item_count);
            $.ajax({
                method: 'POST',
                url: '../menu/add/item',
                beforeSend: function(xhrObj) {
                    xhrObj.setRequestHeader("X-CSRF-Token", CSRF);
                },
                data: $('#customization-form').serialize()
            }).done(function() {
                $.ajax({
                    method: 'GET',
                    url: customization,
                    beforeSend: function(xhrObj) {
                        xhrObj.setRequestHeader("X-CSRF-Token", 'Fetch');
                    }
                }).done(function() {
                    window.location.href = retCustomization;
                });
            });
            
        });

        $(".subnavigation--horizontal li").on("click", "a", function(event) {
            event.preventDefault();
            var clickedTabID = new String($(this).attr("href")).split("#")[1];

            if ( $(clickedTabID).not(":visible") ) {
                var $activeLink = $("a[class='active'");
                var activeTabID = new String($activeLink.attr("href")).split("#")[1];
                $("#" + activeTabID).css("display", "none");
                $("a[href='#"+activeTabID+"']").removeClass("active");
                $("a[href='#"+clickedTabID+"']").addClass("active");
                $("#" + clickedTabID).css("display", "block");
            }
        });
    };
    
    var init = function(params) {
        types = params["types"];
        subTypes = params["subTypes"];
        items = params["items"];
        prices = params["prices"];
        subTypesMap = params["subTypesMap"];     
        ingredients = params["ingredients"];
        
        numOfProd = Object.keys(prices).length;
        
        item_count = (params["count"].length === 0) ? 0 : parseInt(params["count"]);

        let readyToOrder = addressInfo;
        if (readyToOrder === '') {
            $.ajax({
                method: 'GET',
                url: startOrderURL,
                beforeSend: function(xhrObj) {
                    xhrObj.setRequestHeader("X-CSRF-Token", "Fetch");
                }
            }).done(function() {
                window.location.href = retAddrStartOrderURL;
            });
        }

        if (toppingListCache === null)
            toppingListCache = {}; 
        
        _renderElements();
        _initElements();
    };
    
    return {init:init};
})();


var PizzaMaker = (function() {
    
    var index;        

    var types;
    var subTypes;
    var items;

    var data;
    var line_num;
    var item_price;
    var item_toppings;
    var addedToppingList;
    
    var PizzaMaker = function(params) {
        index = 0;
        types = params.types;
        subTypes = params.subTypes;
        items = params.items;
        
        data = params.data;
        line_num = params.line_num;
        item_price = params.item_price;
        item_toppings = params.item_toppings;
        addedToppingList = params.addedToppingList;
        
        $('#quantity option:eq(' + (parseInt(data[parseInt(line_num)]["item_qty"]) - 1) + ')').prop('selected', true);
    };
    
    var renderTab = function() {
        var len = types.length;
        //var $nav = $("<nav role='navigation'>").addClass("secondary-nav");
        var $navLinkList = $("<ul>").addClass("step-navigation");
        var $tabs = $(".steps").append($navLinkList);

        for (var i = 0; i < len; i++) {
            var $navLinkListChild = $("<li>");
            var $navLink = $("<a>").attr("href", "#" + types[i]).addClass("step-link").append(types[i]).appendTo($navLinkListChild);
            if (i === 0) {
                $navLink.addClass("active");
                $(".builder-preview .cut img").attr("style", "display:block;");
                $(".builder-preview .baked").attr("style", "display:none;");
            }
            $navLinkListChild.appendTo($navLinkList);
            var $tab = $("<div>").attr("id", types[i]).addClass("step");

            $tabs.append($tab);
        }
    };
    
    var renderSection = function() {
        for (type in subTypes) {
            var $tab = $("#" + type);
            var $optionPicker;

            var len = subTypes[type].length;
            for (var i = 0; i < len; i++) {  
                $optionPicker = $("<fieldset>").addClass("option-picker");
                var $caption = $("<legend>").append(subTypes[type][i]).appendTo($optionPicker);
                if (len === 1) {
                    $caption.hide();
                }

                $tab.append($optionPicker);
            }
        }
    };
    
    var addTopping = function() {
        var toppingID = this.id.split("-")[3];
        var toppingName = $(this).children(".topping-info").children(".topping-name").text();

        $.ajax({
            method: 'POST',
            url: '../customization/check/topping',
            beforeSend: function(xhrObj) {
                xhrObj.setRequestHeader("X-CSRF-Token", CSRF);
            },
            data: {"line_num" : line_num,
                   "added_topping_count" : $('.toppings')[0].childElementCount,
                   "topping_name" : toppingName}
        }).done(function(results) {
            if (results !== "INACTIVE") {
                let res  = JSON.parse(results);

                if (res['toppingUnit'] === 0) {
                    renderToppingLabels(toppingName);
                    renderToppingDropImg(toppingName);
                }
                else {
                    let $toppingQty = $("div[id='added-topping-" + toppingID + "']").children(".topping-qty");
                    let qty = parseInt($toppingQty.text());
                    $toppingQty.text(qty + 1);
                    $toppingQty.effect("shake", {times:"4", distance:"4", direction: "up"}, 1000);
                }
                $.ajax({
                    method: 'POST',
                    url: '../customization/add/topping',
                    beforeSend: function(xhrObj) {
                        xhrObj.setRequestHeader("X-CSRF-Token", CSRF);
                    },
                    data: {"line_num" : line_num,
                           "added_topping_count" : $('.toppings')[0].childElementCount,
                           "topping_name" : toppingName}
                }).done(function(results) {
                    if (results !== "INACTIVE") {
                        let res  = JSON.parse(results);

                        let $selectedTopping = $('#topping-list-child-' + toppingID);
                        if (res['toppingUnit'] === 1) {
                            $selectedTopping.addClass("active");
                        }
                        else if (res['toppingUnit'] === 2) {
                            $selectedTopping.addClass("disabled");
                        }
                        $(".product-price").html('<span class="currency">&#36;</span>' + res['item_price']);
                        $(".items-total-price").html('<span class="currency">&#36;</span>' + res['new_total']);
                    } else {
                        $('#modal-dialog').show();
                        setTimeout(function() {
                            window.location.href = "../";
                        }, 3000);
                    }
                });
            } else {
                $('#modal-dialog').show();
                setTimeout(function() {
                    window.location.href = "../";
                }, 3000);
            }
        });

    };
    
    var checkOptions = function() {
        var checkedOption = $(this).attr("value");
        var checkedOptionName = $(this).attr("name");

        if (checkedOptionName === "Crust Style") {
            $('input[name="Size"][value="LARGE"]').attr("disabled", false);
            $('input[name="Size"][value="MEDIUM"]').attr("disabled", false);
            $('input[name="Size"][value="SMALL"]').attr("disabled", false);
            $('input[name="Size"][value="EXTRA LARGE"]').attr("disabled", false);
            if (checkedOption === "GLUTEN-FREE") {
                $('input[name="Size"][value="SMALL"]').prop("checked", true);
                $('input[name="Size"][value="MEDIUM"]').attr("disabled", true);
                $('input[name="Size"][value="LARGE"]').attr("disabled", true);
                $('input[name="Size"][value="EXTRA LARGE"]').attr("disabled", true);
                $(".pizza-builder").attr("data-builder-size", "2");
            }
            else if (checkedOption === "THIN") {
                $('input[name="Size"][value="LARGE"]').prop("checked", true);
                $('input[name="Size"][value="MEDIUM"]').attr("disabled", true);
                $('input[name="Size"][value="SMALL"]').attr("disabled", true);
                $('input[name="Size"][value="EXTRA LARGE"]').attr("disabled", true);
                $(".pizza-builder").attr("data-builder-size", "3");
            }
            else if (checkedOption === "ORIGINAL") {
                $('input[name="Size"][value="LARGE"]').prop("checked", true);
                $(".pizza-builder").attr("data-builder-size", "3");
            }
        }
        else if (checkedOptionName === "Size" || checkedOptionName === "Cut") {
            if (checkedOption === "SMALL") {
                $(".pizza-builder").attr("data-builder-size", "2");
            }
            else if (checkedOption === "MEDIUM") {
                $(".pizza-builder").attr("data-builder-size", "3");
            }
            else if (checkedOption === "LARGE") {
                $(".pizza-builder").removeAttr("data-builder-size");
            }
            else if (checkedOption === "EXTRA LARGE") {
                $(".pizza-builder").attr("data-builder-size", "5");
            }
        }

        $.ajax({
            method: 'POST',
            url: '../customization/change/option',
            beforeSend: function(xhrObj) {
                xhrObj.setRequestHeader("X-CSRF-Token", CSRF);
            },
            data: {"line_num" : line_num,
                   "checkedOption" : checkedOption,
                   "checkedOptionName" : checkedOptionName,
                   "added_topping_count" : $('.toppings')[0].childElementCount}
        }).done(function(results) {
            if (results !== "INACTIVE") {
                let res  = JSON.parse(results);

                if (checkedOptionName === "Sauce") {
                    var $sauce_image = $('<img>').attr("src", res["image_path"]).addClass("transparent");
                    $(".builder-preview .sauce img").remove();
                    $(".builder-preview .sauce").append($sauce_image);
                    $(".builder-preview .cut img").fadeOut();
                    $sauce_image.removeClass("transparent").fadeIn();

                    setTimeout(function() {
                        $sauce_image.addClass("transparent").fadeOut();
                        $(".builder-preview .cut img").fadeIn();
                    }, 1500);
                } else if (checkedOptionName === "Size" || checkedOptionName === "Cut" || checkedOptionName === "Crust Style" ) {
                    var $size_image = $('<img>').attr("src", res["image_path"]);
                    $(".builder-preview .pizza-base img").remove();             
                    $(".builder-preview .pizza-base").append($size_image);

                    var $cut_image = $('<img>').attr("src", res["cut_image_path"]).attr("style", "display:block;").attr("data-builder-img", "cut");
                    $(".builder-preview .cut img").remove();  
                    $(".builder-preview .cut").append($cut_image);
                }

                $(".product-price").html('<span class="currency">&#36;</span>' + res['item_price']);
                $(".items-total-price").html('<span class="currency">&#36;</span>' + res['new_total']);
            } else {
                $('#modal-dialog').show();
                setTimeout(function() {
                    window.location.href = "../";
                }, 3000);
            }
            
        });
    };
    
    var renderOptions = function() {
        for (subType in items) {
            var len = items[subType].length;
            var $optionPicker = $("legend").filter(function() {
                return $(this).text() === subType;
            }).parent();

            var $optionGrid = $("<div>").addClass("pizza-options-grid");
            var $toppingGrid = $("<ul>").addClass("topping-picker").addClass("pizza-toppings-grid");   
            for (var i = 0; i < len; i++) {
                var optionOrTopping = items[subType][i];

                if (typeof optionOrTopping === "string") {
                    var $radioBtn = $("<input>")
                        .attr({type: "radio",
                            class: "visually-hidden",
                            name: subType,
                            value: optionOrTopping,
                            id: "instr-" + (index++)});
                    if (i === 0)
                        $radioBtn.attr("checked", "checked");

                    $radioBtn.change(checkOptions);
                    $optionGrid.append($radioBtn);
                    $('<label for="instr-' + (index-1) + '">').addClass("button--outline").append(optionOrTopping).appendTo($optionGrid);
                }
                else {
                    var toppingID= items[subType][i]["ingred_id"];
                    var toppingName = items[subType][i]["ingred_name"];

                    var $listChild = $("<li>").addClass("topping").attr("id", "topping-list-child-" + toppingID).appendTo($toppingGrid);
                    $listChild.on('click', addTopping);

                    $("<img>").addClass("topping-image").attr("src", "../images/pizzaBuilder/TOPPINGS/" + toppingName + ".jpg").appendTo($listChild);
                    var $toppingInfo = $("<div>").addClass("topping-info").appendTo($listChild);
                    $("<strong>").addClass("topping-name").append(toppingName).appendTo($toppingInfo);
                }
            }
            if ($optionGrid[0].childElementCount > 0) {
                $optionGrid.appendTo($optionPicker);
            }
            else if ($toppingGrid[0].childElementCount > 0) {
                $toppingGrid.appendTo($optionPicker);
            }
        }
        $(".steps .step").each(function() {
            if (this.id !== "INSTRUCTIONS")
                $(this)[0].style.display = "none";
        });
    };
    
    var removeTopping = function() {
        var toppingName = $(this).prev().prev().text();
        var toppingID = ($(this).parent().attr('id')).split('-')[2];
        $.ajax({
            method: 'POST',
            url: removeToppingURL,
            beforeSend: function(xhrObj) {
                xhrObj.setRequestHeader("X-CSRF-Token", CSRF);
            },
            data: {"line_num" : line_num,
                   "added_topping_count" : $('.toppings')[0].childElementCount,
                   "topping_name" : toppingName}
        }).done(function(results) {
            if (results !== "INACTIVE") {
                let res  = JSON.parse(results);

                var clickedList = $('li[id="topping-list-child-' + toppingID + '"]');
                if (res['toppingUnit'] === 1) {
                    clickedList.removeClass("disabled");
                    $("div[id='added-topping-" + toppingID + "']").children(".topping-qty").text(res['toppingUnit']);
                }
                else if (res['toppingUnit'] === 0) {
                    clickedList.removeClass("active");
                    $(".topping-drop.topping-" + toppingID).remove();
                    $('#added-topping-' + toppingID).remove();
                }

                $(".product-price").html('<span class="currency">&#36;</span>' + res['item_price']);
                $(".items-total-price").html('<span class="currency">&#36;</span>'+ res['new_total']);
            } else {
                $('#modal-dialog').show();
                setTimeout(function() {
                    window.location.href = "../";
                }, 3000);
            }
            
        });

    };

    var changeToppingPosition = function() {
        var id = this.id;
        var str = id.split("-");
        var toppingDropDivClass = addedToppingList[str[0]]["id"];
        var toppingName = str[0];
        var $toppingDropDiv = $(".topping-drop.topping-" + toppingDropDivClass + " .baked-toppings");

        $toppingDropDiv.children(".topping-right").remove();
        $toppingDropDiv.children(".topping-left").remove();

        var $img1 = $('<img>').attr('src', '../images/pizzaBuilder/TOPPINGS/' + str[0] + '-Baked-Left.jpg').addClass('topping').addClass("topping-left").addClass("fadeIn");
        var $img2 = $('<img>').attr('src', '../images/pizzaBuilder/TOPPINGS/' + str[0] + '-Baked-Right.jpg').addClass('topping').addClass("topping-right").addClass("fadeIn"); 
        var pos = "";
        if (str[1] === "left") {
            pos = "left";
            $toppingDropDiv.append($img1);
        }
        else if (str[1] === "right") {
            pos = "right";
            $toppingDropDiv.append($img2);
        }
        else if (str[1] === "both") {
            pos = "both";
            $toppingDropDiv.append($img1)
                .append($img2);    
        }

        $.ajax({
            method: 'POST',
            url: '../customization/change/toppingPos',
            beforeSend: function(xhrObj) {
                xhrObj.setRequestHeader("X-CSRF-Token", CSRF);
            },
            data: {"line_num" : line_num,
                   "topping_name" : toppingName,
                   "position" : pos,
                   "added_topping_count" : $('.toppings')[0].childElementCount}
        }).done(function(results) {
            if (results !== undefined && results === "INACTIVE") {
                $('#modal-dialog').show();
                setTimeout(function() {
                    window.location.href = "../";
                }, 3000);
            }
        });
    };

    var renderToppingLabels = function(toppingName) {
        var toppingID = addedToppingList[toppingName]["id"];

        var leftID = toppingName + "-left-" + toppingID;
        var bothID = toppingName + "-both-" + toppingID;
        var rightID = toppingName + "-right-" + toppingID;

        var toppingLabel = 
            "<div class='topping' id='added-topping-" + toppingID + "'>" +
                "<fieldset class='topping-side-switcher'>" +
                    "<input class='topping-left visually-hidden' " +
                        "id='" + leftID + "' type='radio' name='" + toppingName + "' " + ((toppingName in item_toppings) ? ((item_toppings[toppingName]['pos'] === 'left') ? "checked=''" : "") : "") + ">" +
                    "<label class='topping-left-label' " +
                        "for='" + leftID + "'>" + 
                        "<svg title='left half' width='24' height='24' " +
                            "viewBox='0 0 24 24'>" +
                            "<path fill='currentColor' " +
                                "d='M12 24C5.4 24 0 18.6 0 12S5.4 0 12 0v24z'></path></svg></label>" +
                    "<input class='topping-both visually-hidden' " +
                        "id='" + bothID + "' type='radio' name='" + toppingName + "' " + ((toppingName in item_toppings) ? ((item_toppings[toppingName]['pos'] === 'both') ? "checked=''" : "") : "checked=''")+ ">" +
                    "<label class='topping-both-label' " +
                        "for='" + bothID + "'>" + 
                        "<svg title='whole pizza' width='24' height='24' " +
                            "viewBox='0 0 24 24'>" +
                            "<circle fill='currentColor' cx='12' cy='12' r='12'></circle></svg></label>" +
                    "<input class='topping-right visually-hidden' " +
                        "id='" + rightID + "' type='radio' name='" + toppingName + "' " + ((toppingName in item_toppings) ? ((item_toppings[toppingName]['pos'] === 'right') ? "checked=''" : "") : "") + ">" +
                    "<label class='topping-right-label' " +
                        "for='" + rightID + "'>" + 
                        "<svg title='right half' width='24' height='24' " +
                            "viewBox='0 0 24 24'>" +
                            "<path fill='currentColor' " +
                                "d='M12 0c6.6 0 12 5.4 12 12s-5.4 12-12 12V0z'></path></svg></label>" +
                "</fieldset>" +
                "<span class='topping-name'>" + toppingName + "</span>" +
                "<span class='topping-qty'>" + ((toppingName in item_toppings) ? item_toppings[toppingName]['qty'] : 1) + "</span>" +
                "<button class='remove-button' id='topping-label-remove-button-" + toppingID + "'></button>" +
            "</div>";

        $(".toppings").append(toppingLabel);
        var $removeToppingBtn = $("#topping-label-remove-button-" + toppingID);
        $removeToppingBtn.on('click', removeTopping);

        var $toppingPosBtn = $("input:radio[name='" + toppingName + "']");
        $toppingPosBtn.change(changeToppingPosition);
    };

    var renderToppingDropImg = function(toppingName) {
        var toppingID = addedToppingList[toppingName]["id"];

        var $baked = $('.baked');
        var $toppingDrop = $("<div>").addClass("topping-drop")
            .addClass("topping-" + toppingID)
            .appendTo($baked);
        var $img1 = $('<img>').attr('src', '../images/pizzaBuilder/TOPPINGS/' + toppingName + '-Falling-A.jpg').addClass('drop-img').addClass('transparent');
        var $img2 = $('<img>').attr('src', '../images/pizzaBuilder/TOPPINGS/' + toppingName + '-Falling-B.jpg').addClass('drop-img').addClass('transparent');
        var $img3 = $('<img>').attr('src', '../images/pizzaBuilder/TOPPINGS/' + toppingName + '-Falling-C.jpg').addClass('drop-img').addClass('transparent');

        var $fallingToppings = $('<div>').addClass('falling-toppings').addClass('basic-topping').appendTo($toppingDrop)
            .append($img1);
        setTimeout(function(){
            $fallingToppings.append($img2);
        }, 200);
        setTimeout(function(){
            $fallingToppings.append($img3);
        }, 300);

        setTimeout(function() {
            var $bakedToppings = $('<div>').addClass('baked-toppings');
            var $img1 = $('<img>').attr('src', '../images/pizzaBuilder/TOPPINGS/' + toppingName + '-Baked-Left.jpg').addClass('topping').addClass("topping-left").addClass("fadeIn");
            var $img2 = $('<img>').attr('src', '../images/pizzaBuilder/TOPPINGS/' + toppingName + '-Baked-Right.jpg').addClass('topping').addClass("topping-right").addClass("fadeIn");
            if (item_toppings[toppingName] === undefined ) {
                $bakedToppings.append($img1)
                .append($img2)
                .appendTo($toppingDrop);
            } else if (item_toppings[toppingName] !== undefined && item_toppings[toppingName]['pos'] === 'both') {
                $bakedToppings.append($img1)
                .append($img2)
                .appendTo($toppingDrop);
            } else if (item_toppings[toppingName] !== undefined && item_toppings[toppingName]['pos'] === 'left') {
                $bakedToppings.append($img1)
                .appendTo($toppingDrop);
            } else if (item_toppings[toppingName] !== undefined && item_toppings[toppingName]['pos'] === 'right') {
                $bakedToppings.append($img2)
                .appendTo($toppingDrop);
            }

        }, 400);
    };
    
    var renderAddedToppings = function(toppingList) {
        for(topping in toppingList) {
            if(toppingList[topping]["qty"] && toppingList[topping]["qty"] > 0) {
                renderToppingLabels(topping);
                setTimeout(renderToppingDropImg(topping), 1000);
                $('li[id="topping-list-child-' + toppingList[topping]["id"] + '"]').addClass('active');
            }
            else if (toppingList[topping]["ingred_name"]) {

                if (topping === "Crust Style") {

                    if (toppingList[topping]["ingred_name"] === "GLUTEN-FREE") {
                        $('input[name="Size"][value="MEDIUM"]').attr("disabled", true);
                        $('input[name="Size"][value="LARGE"]').attr("disabled", true);
                        $('input[name="Size"][value="EXTRA LARGE"]').attr("disabled", true);

                        $(".pizza-builder").attr("data-builder-size", "2");

                        var image_path = "../images/pizzaBuilder/" + toppingList["Size"]["ingred_name"] + ".jpg";
                        var $size_image = $('<img>').attr("src", image_path);
                        $(".builder-preview .pizza-base img").remove();             
                        $(".builder-preview .pizza-base").append($size_image);

                        var cut_image_path = "../images/pizzaBuilder/" + toppingList["Size"]["ingred_name"] + "-" + toppingList["Cut"]["ingred_name"] + "-CUT.png";
                        var $cut_image = $('<img>').attr("src", cut_image_path).attr("style", "display:block;").attr("data-builder-img", "cut");
                        $(".builder-preview .cut img").remove();  
                        $(".builder-preview .cut").append($cut_image);
                    }
                    else if (toppingList[topping]["ingred_name"] === "THIN") {
                        $('input[name="Size"][value="MEDIUM"]').attr("disabled", true);
                        $('input[name="Size"][value="SMALL"]').attr("disabled", true);
                        $('input[name="Size"][value="EXTRA LARGE"]').attr("disabled", true);

                        $(".pizza-builder").attr("data-builder-size", "3");

                        var image_path = "../images/pizzaBuilder/" + toppingList["Crust Style"]["ingred_name"] + ".jpg";
                        var $size_image = $('<img>').attr("src", image_path);
                        $(".builder-preview .pizza-base img").remove();             
                        $(".builder-preview .pizza-base").append($size_image);

                        var cut_image_path = "../images/pizzaBuilder/" + toppingList["Size"]["ingred_name"] + "-" + toppingList["Cut"]["ingred_name"] + "-CUT.png";
                        var $cut_image = $('<img>').attr("src", cut_image_path).attr("style", "display:block;").attr("data-builder-img", "cut");
                        $(".builder-preview .cut img").remove();  
                        $(".builder-preview .cut").append($cut_image);
                    }
                }
                else if (topping === "Size") {
                    if (toppingList[topping]["ingred_name"] === "SMALL") {
                        $(".pizza-builder").attr("data-builder-size", "2");
                    }
                    else if (toppingList[topping]["ingred_name"] === "MEDIUM") {
                        $(".pizza-builder").removeAttr("data-builder-size");
                    }
                    else if (toppingList[topping]["ingred_name"] === "LARGE") {
                        $(".pizza-builder").attr("data-builder-size", "3");
                    }
                    else if (toppingList[topping]["ingred_name"] === "EXTRA LARGE") {
                        $(".pizza-builder").attr("data-builder-size", "5");
                    }

                    var image_path = "../images/pizzaBuilder/" + toppingList["Size"]["ingred_name"] + ".jpg";
                    var $size_image = $('<img>').attr("src", image_path);
                    $(".builder-preview .pizza-base").append($size_image);
                }
                else if (topping === "Cut") {
                    var image_path = "../images/pizzaBuilder/" + toppingList["Size"]["ingred_name"] + "-" + toppingList[topping]["ingred_name"] + "-CUT.png";
                    var $cut_image = $('<img>').attr("src", image_path).attr("style", "display:block;").attr("data-builder-img", "cut");
                    $(".builder-preview .cut").append($cut_image);
                }
                else if (topping === "Sauce") {
                    var image_path = "../images/pizzaBuilder/" + toppingList["Sauce"]["ingred_name"] + "-SAUCE.jpg";
                    var $sauce_image = $('<img>').attr("src", image_path).addClass("transparent");            
                    $(".builder-preview .sauce").append($sauce_image);
                }

                $('input[name="' + topping + '"][value="'+ toppingList[topping]["ingred_name"] + '"]').prop("checked", true);
            }            
        }
        $(".product-price").html('<span class="currency">&#36;</span>' + parseFloat(item_price).toFixed(2));
    };
    
    var _renderElements = function() {
        renderTab();
        renderSection();
        renderOptions();
        renderAddedToppings(item_toppings);
    };
    
    var _initElements = function() {
        $(".steps ul li").on("click", "a", function(event) {
            event.preventDefault();
            var clickedTabID = new String($(this).attr("href")).split("#")[1];

            if ( $(clickedTabID).not(":visible") ) {
                var $activeLink = $("a[class='step-link active'");
                var activeTabID = new String($activeLink.attr("href")).split("#")[1];
                $("#" + activeTabID).css("display", "none");
                $("a[href='#"+activeTabID+"']").removeClass("active");
                $("a[href='#"+clickedTabID+"']").addClass("active");
                $("#" + clickedTabID).css("display", "block");

                var $prevBtn = $(".next-step--wrapper .prev");
                var $nextBtn = $prevBtn.next();

                var first = ( !($(this).parent().prev().length) ? true : false  );
                var last = ( !($(this).parent().next().length) ? true : false  );

                var $newActiveLink = $("a[class='step-link active'");

                if ($newActiveLink.attr("href") === "#INSTRUCTIONS") {
                    $(".builder-preview .cut img").attr("style", "display:block;");
                    $(".builder-preview .baked").attr("style", "display:none;");
                }
                else {
                    $(".builder-preview .cut img").attr("style", "display:none;");
                    $(".builder-preview .baked").attr("style", "display:block;");
                }

                var prevBtnTxt = (($newActiveLink.parent().prev().children().length) ? $newActiveLink.parent().prev().children().attr("href") : "");
                var nextBtnTxt = (($newActiveLink.parent().next().children().length) ? $newActiveLink.parent().next().children().attr("href") : "");
                $prevBtn.attr("href", prevBtnTxt);
                $nextBtn.attr("href", nextBtnTxt);
                $nextBtn.text("Next: " + nextBtnTxt.split("#")[1]);
                $prevBtn.show();
                $nextBtn.show();
                $(".quantity-selector").hide();
                $("#addToCart").hide();

                if (first) {
                    $prevBtn.hide();
                }
                if (last) {
                    $nextBtn.hide();
                    $(".quantity-selector").show();
                    $("#addToCart").show();
                }
            }
        });

        $(".next-step--wrapper a").on("click", function(event) {
            event.preventDefault();
            var nextTabID = $(this).attr("href");

            var $activeLink = $("a[class='step-link active'");
            var activeTabID = ($activeLink.attr("href")).split("#")[1];
            $("#" + activeTabID).css("display", "none");           
            $("a[href='#"+activeTabID+"']").removeClass("active");

            $("a[href='"+nextTabID+"']").addClass("active");
            $(nextTabID).css("display", "block");

            var first;
            var last;

            if ($(this).hasClass("prev")) {
                var prevBtnTxt = $("a[href='" + nextTabID + "'][class='step-link active']").parent().prev().children().text();
                $(this).attr("href", "#" + prevBtnTxt);
                $(this).next().text("Next: " + activeTabID);
                $(this).next().attr("href", "#" + activeTabID);

                first = ((!$("a[href='#"+activeTabID+"']").parent().prev().prev().length) ? true:false);
                last = ((!$("a[href='#"+activeTabID+"']").parent().next().length) ? true:false);

                if (first) {
                    $(this).hide();
                }
                if (last) {
                    $(this).next().show();
                    $(".quantity-selector").hide();
                    $("#addToCart").hide();
                }
            }
            else {
                var nextBtnTxt = $("a[href='" + nextTabID + "'][class='step-link active']").parent().next().children().text();
                $(this).attr("href",  "#" + nextBtnTxt);
                $(this).text("Next: " + nextBtnTxt);
                $(this).prev().attr("href", "#" + activeTabID);

                first = ((!$("a[href='#"+activeTabID+"']").parent().prev().length) ? true:false);
                last = ((!$("a[href='#"+activeTabID+"']").parent().next().next().length) ? true:false);

                if (first) {
                    var $prev = $(this).prev();
                    $prev.attr("href", "#" + activeTabID);
                    $prev.show();
                }
                if (last) {
                    $(this).hide();
                    $(".quantity-selector").show();
                    $("#addToCart").show();
                }
            }
        });

        $('#addToCart').on('click', function() {
            $.ajax({
                method: 'GET',
                url: '../cart',
                beforeSend: function(xhrObj) {
                    xhrObj.setRequestHeader("X-CSRF-Token", "Fetch");
                }
            }).done(function() {
                window.location.replace("../cart/view");
            });
        });

        $("#quantity").change(function() {
            var qty = parseInt($("#quantity option:selected").text());

            $.ajax({
                method: 'POST',
                url: '../cart/change/itemCount',
                beforeSend: function(xhrObj) {
                    xhrObj.setRequestHeader("X-CSRF-Token", CSRF);
                },
                data: {"line_num" : line_num,
                       "item_qty" : qty,
                       "added_topping_count" : $('.toppings')[0].childElementCount}
            }).done(function(results) {
                if (results !== "INACTIVE") {
                    let res  = JSON.parse(results);

                    $(".items-in-cart").html(res['item_qty']);
                    $(".items-total-price").html('<span class="currency">&#36;</span>'+res['new_total']);
                } else {
                    window.location.href = "../";
                }
                
            });
        });
    };
    
    PizzaMaker.prototype = {
        constructor:PizzaMaker,
        init:function() {
            _renderElements();
            _initElements();
        }
    };
    
    return PizzaMaker;
})();


var Cart = (function() {
    var data;
    
    var discount;
    var discountrate; 
    var tax;
    var taxrate;
    
    var turned;
    
    var updateCartSummary = function(total_price) {
        discount = total_price * parseFloat(discountrate);
        tax = total_price * parseFloat(taxrate);
                
        $(".subtotal-amount-nodiscount").html(
            total_price ===  0 ? "$0.00" : "$" + total_price);
        $(".subtotal-amount").html(
            (total_price - parseFloat(discount)) === 0 ? 
                "$0.00" : "$" + (total_price - parseFloat(discount)));
        $(".tax-total").html(tax === 0 ? "$0.00" : "$" + tax);
        $(".estimated-total-amount h3").html(
            (total_price - discount + tax) === 0 ? 
                "$0.00" : "$" + (total_price - discount + tax));
    };
    
    var renderCart = function(cartData, target, listTemplate) {
        $.each(cartData, function(key, val) {
            var min=200; 
            var max=500;
            var random = 
                (Math.floor(Math.random() * (+max - +min)) + +min).toString(); 

            var img = 
                '<img src="../images/items/' + cartData[key].item_name +'.jpg" ' +
                    'class="product-image">';
            var toppings = '';
            var instructions = '';
            var editLinks = 
                '<p class="edit-links">' +
                    '<a class="remove-item" href="#"' +
                        ' id="cart-remove-item-0-' + key + '">Remove</a>' +
                '</p>';
            let path = window.location.pathname;
            if (path === "/checkout/view") {
                editLinks = '';
            }
            if (cartData[key].item_type === "PIZZAS") {
                var toppingData = cartData[key].item_toppings;
                var imgPath = 
                    ( (toppingData["Crust Style"]["ingred_name"] === "ORIGINAL") ? 
                        (toppingData["Size"]["ingred_name"]) : 
                        ((toppingData["Crust Style"]["ingred_name"] === "GLUTEN-FREE") ? 
                            "SMALL" : toppingData["Crust Style"]["ingred_name"] ) );
                            
                img = 
                    '<div class="builder-preview product-image1 product-cart no-padding">' +
                        '<div class="builder-preview-inner pizza-image">';
                
                var pizzaBase = 
                    '<div class="pizza-base">' +
                        '<img class="" alt="" src="../images/pizzaBuilder/' +
                            imgPath + '.jpg">' +
                    '</div>';
                var pizzaToppingsDiv = '<div class="baked">';

                img += pizzaBase + pizzaToppingsDiv;    

                toppings = '<p class="description-short deal-product-title">Toppings: <em>';
                instructions = '<p class="description-short">Instructions: <em>';

                var pizzaTopping;
                for (tkey in toppingData) {
                    random = (Math.floor(Math.random() * (+max - +min)) + +min);
                    if (toppingData[tkey].hasOwnProperty('qty') && toppingData[tkey].qty > 0) {
                        toppings += tkey + ', ';
                        pizzaTopping = '<div class="topping-drop '+ 'topping">' +
                                            '<div class="baked-toppings">';
                        var position = toppingData[tkey].pos;
                        if (position === "both") {
                            pizzaTopping += 
                                '<img class="topping topping-left"' +
                                    ' src="../images/pizzaBuilder/TOPPINGS/'+ 
                                        tkey +'-Baked-Left.jpg"' +
                                    ' style="z-index:' + 
                                        (random + parseInt(toppingData[tkey].id)) + ';">' +
                                '<img class="topping topping-right"' +
                                    ' src="../images/pizzaBuilder/TOPPINGS/'+ 
                                        tkey +'-Baked-Right.jpg"' +
                                    ' style="z-index:' + 
                                        (random + parseInt(toppingData[tkey].id)) + ';">';
                        } else if (position === "left") {
                            pizzaTopping += 
                                '<img class="topping topping-left"' +
                                    ' src="../images/pizzaBuilder/TOPPINGS/' + 
                                        tkey + '-Baked-Left.jpg"' +
                                    ' style="z-index:' + 
                                        (random + parseInt(toppingData[tkey].id)) + ';">';
                        } else if (position === "right") {
                            pizzaTopping += 
                                '<img class="topping topping-right"' +
                                    ' src="../images/pizzaBuilder/TOPPINGS/' +
                                        tkey +'-Baked-Right.jpg"' +
                                    ' style="z-index:' + 
                                        (random + parseInt(toppingData[tkey].id)) + ';">';
                        }
                        pizzaTopping += '</div></div>';
                        img += pizzaTopping;
                    }
                    else if (toppingData[tkey].hasOwnProperty('ingred_name')) {
                        instructions += (toppingData[tkey].ingred_name + ' ' + tkey) + ', ';
                    }           
                }
                random = (Math.floor(Math.random() * (+max - +min)) + +min).toString();

                img += '</div></div></div>';

                toppings = toppings.substring(0, toppings.length-2);
                instructions = instructions.substring(0, instructions.length-2);  
                toppings += '</em></p>';
                instructions += '</em></p>';
                editLinks = 
                    '<p class="edit-links">' +
                        '<a class="remove-item" href="#"' +
                            ' id="cart-remove-item-0-' + key + '">Remove</a>' +
                        '<span class="separator">|</span>\n' +
                        '<a href="#" class="edit-item"' +
                            ' id="cart-edit-item-0-' + key + '">Edit</a>\n' +
                        '<span class="separator">|</span>' +
                        '<a class="edit-product show-hide" href="#"' +
                            ' id="' + val.item_id + '-' + random +'">' +
                            '<span class="show-hide-links">Details</span>' +
                            '<i class="icon-expand icon"></i>' +
                        '</a>' +
                        '<div id="instr-' + val.item_id + '-' + random + '"' +
                            ' style="display:none;">' + instructions + '</div>' +
                    '</p>';
                path = window.location.pathname;
                if (path === "/checkout/view") {
                    editLinks = 
                        '<p class="edit-links">' +
                            '<a class="edit-product show-hide" href="#"' +
                                ' id="' + val.item_id + '-' + random +'">' +
                                '<span class="show-hide-links">Details</span>' +
                                '<i class="icon-expand icon"></i>' +
                            '</a>' +
                            '<div id="instr-' + val.item_id + '-' + random + '"' +
                                ' style="display:none;">' + instructions + '</div>' +
                        '</p>';
                }
            }
            random = (Math.floor(Math.random() * (+max - +min)) + +min).toString();
            
            const listData = {
                img:img,
                item_name:(val.item_name),
                toppings:toppings,
                editLinks:editLinks,
                key:key,
                qty:(val.item_qty),
                sub_total:(val.item_price * val.item_qty)
            };
            var listItem = Mustache.render(listTemplate, listData);
            target.append(listItem);
        });
    };
    
    var _renderElements = function() {
        const listTemplate =                 
            ['<li class="cart-product-item" id="line-item-{{key}}">',
                '<div class="product-cart">',
                    '{{&img}}',
                    '<div class="cart-description">',
                        '<p class="ordered-item-name">{{item_name}}</p>',
                        '{{&toppings}}',
                        '{{&editLinks}}',
                    '</div>',
                    '<form class="ordered-item-form" id="cart-item-form-0-{{key}}">',
                        '<input name="line_num" id="cart-item-line-num-0-{{key}}"' +
                            ' type="hidden" value="{{key}}">',
                        '<div class="ordered-item-total">',
                            '<div class="ordered-item-quantity">',
                                '<input name="item_qty" id="item-qty-{{key}}"' +
                                    ' type="number" value="{{qty}}" min=1 max=50>',
                            '</div>',
                            '<div class="ordered-item-price">',
                                '<p id="item-price-{{key}}" class="price">' +
                                    '${{sub_total}}</p>',
                            '</div>' ,
                        '</div>' ,
                    '</form>' ,
                '</div>' ,
            '</li>'].join("\n");
        renderCart(data, $(".ordered-item-list ul"), listTemplate);
        
        updateCartSummary(total);
    };
    
    var _initElements = function() {
        
        $("input[id^='item-qty-']").on("input", function(event){
            var id = event.target.id;
            var str = id.split("-");
            var newID = str[str.length-1];

            $.ajax({
                method: 'POST',
                url: '../cart/change/itemCount',
                beforeSend: function(xhrObj) {
                    xhrObj.setRequestHeader("X-CSRF-Token", CSRF);
                },
                data: {"line_num" : newID,
                       "item_qty" : parseInt($("#item-qty-" + newID).val())}
            }).done(function(results) {
                let res  = JSON.parse(results);

                $(".items-in-cart").html(res['item_qty']);
                $(".items-total-price").html('<span class="currency">&#36;</span>'+res['new_total']);
                $("#item-price-" + newID).html('$' + parseFloat(data[newID].item_price * parseInt($("#item-qty-" + newID).val()) ).toFixed(2));
                updateCartSummary(parseFloat(res['new_total']));
            });
        });

        $('.edit-item').on('click', function(event) {
            var id = event.target.id;
            var str = id.split("-");
            var newID = str[str.length-1];
//            $('#cart-item-form-0-' + newID).submit();
            
            $.ajax({
                method: 'POST',
                url: '../cart/edit/item',
                beforeSend: function(xhrObj) {
                    xhrObj.setRequestHeader("X-CSRF-Token", CSRF);
                },
                data: $('#cart-item-form-0-' + newID).serialize()
            }).done(function() {
                $.ajax({
                    method: 'GET',
                    url: '../customization',
                    beforeSend: function(xhrObj) {
                        xhrObj.setRequestHeader("X-CSRF-Token", 'Fetch');
                    }
                }).done(function() {
                    window.location.href = '../customization/view';
                });
            });
        });

        $('.remove-item').on('click', function(event) {
            event.preventDefault();
            var id = event.target.id;
            var str = id.split("-");
            var newID = str[str.length-1];

            $.ajax({
                method: 'POST',
                url: '../cart/remove/item',
                beforeSend: function(xhrObj) {
                    xhrObj.setRequestHeader("X-CSRF-Token", CSRF);
                },
                data: $('#cart-item-form-0-' + newID).serialize()
            }).done(function(results) {
                let res  = JSON.parse(results);

                $(".items-in-cart").html(res['item_qty']);
                $(".items-total-price").html('<span class="currency">&#36;</span>'+res['new_total']);

                updateCartSummary(parseFloat(res['new_total']));
                
                data.splice(newID, 1);
                $('#line-item-' + newID).remove();
                $('input[id^="cart-item-line-num-0-"]').each(function(i) {
                    $(this).val(i);
                });
            });
        });
        
        $(".edit-product").on("click", function(event){
            event.preventDefault();
            if(!turned) {
                $(this).children(".icon-expand").css("transform", "rotate(180deg)");
                $("div[id='instr-"+this.id +"']").removeAttr("style");
                turned = true;
            }
            else {
                $(this).children(".icon-expand").removeAttr("style");
                $("div[id='instr-"+this.id +"']").css("display", "none");
                turned = false;
            }                  
        });

        $('.button-checkout').on('click', function(event) {
            event.preventDefault();
                        $.ajax({
                method: 'GET',
                url: checkoutAddr,
                beforeSend: function(xhrObj) {
                    xhrObj.setRequestHeader("X-CSRF-Token", "Fetch");
                }
            }).done(function() {
                window.location.href = retCheckoutAddr;
            });
        });
    };
    
    var init = function(params) {
        data = params.cart;
        
        discount = 0;
        discountrate = params.discountrate; 
        tax = 0;
        taxrate = params.taxrate;
        
        turned = false;
        
        _renderElements();
        _initElements();
    };
    
    return {init:init,
            renderCart:renderCart};
})();

var Checkout = (function($) {
    var data;
    
    var discount;
    var discountrate; 
    var tax;
    var taxrate;
    
    var turned;
    var showPwd;
    var clicked;
    
    var renderAddressInfo = function() {
        var jsonAddr = JSON.parse(addressInfo);
        var order_type = Object.keys(jsonAddr)[0];
        var address_str = jsonAddr[order_type];

        var address_component = address_str.split(',');
        var address = address_component[0] + '<br>';
        var len = address_component.length;
        for (var i = 1; i < len; i++) {
            address += address_component[i].trim();
            if (i < len - 1)
                address += ', ';
        }
        var store = JSON.parse(storeInfo);
        var phone = store['phone'];
        var addressHTML = 
            '<div class="h5-new">Carryout Store Address</div>' +
            '<div class="spacing-top-sm spacing-bottom-sm">' +
                '<address>' +
                address + '<br>' +
                phone +
                '</address>' +
                '<p class="spacing-top-sm spacing-bottom-sm">' +
                    '<a href="address.jsp?target=CARRYOUT">Change Carry-out Store</a>' +
                    ' | ' +
                    '<a href="address.jsp?target=DELIVERY">Change to ' +
                        '<strong>Delivery</strong></a>' +
                '</p>' +
            '</div>';

        var storeAddressHTML = 
            '<div class="h5-new title spacing-bottom-xs">Your Carryout Store</div>' +
            '<address>' + address + '<br>' + phone + '</address>' +
            '<div class="hours-module">' +
                '<p class="spacing-bottom-sm">' +
                    '<strong>Opening Hours</strong><br>' +
                    store['opening_hours'] +
                '</p>' +
            '</div>';

        if (order_type === 'DELIVERY') {
            addressHTML = 
                '<div class="h5-new">Delivery Address</div>' +
                '<div class="spacing-top-sm spacing-bottom-sm">' +
                    '<address>' +
                    address + '<br>' +
                    '</address>' +
                    '<p class="spacing-top-sm spacing-bottom-sm">' +
                        '<a href="address.jsp?target=DELIVERY">Edit Delivery Address</a>' +
                        ' | ' +
                        '<a href="address.jsp?target=CARRYOUT">Change to ' +
                            '<strong>Carry-out</strong></a>' +
                    '</p>' +
                '</div>';
            var store_address_component = store['address'].split(',');
            var store_address = store_address_component[0] + '<br>';
            var len = store_address_component.length;
            for (var i = 1; i < len; i++) {
                store_address += store_address_component[i].trim();
                if (i < len - 1)
                    store_address += ', ';
            }
            storeAddressHTML = 
                '<div class="h5-new">Delivery Address</div>' +
                '<div class="spacing-top-sm spacing-bottom-sm">' +
                    '<address>' +
                    address + '<br>' +
                    '</address>' +
                '</div>' +
                '<div class="h5-new title spacing-bottom-xs">Your Delivery Store</div>' +
                '<address>' + store_address + '<br>' + store['phone'] + '</address>' +
                '<div class="hours-module">' +
                    '<p class="spacing-bottom-sm">' +
                        '<strong>Opening Hours</strong><br>' +
                        store['opening_hours'] +
                    '</p>' +
                '</div>';
        }
        $('.checkout-order-location-form').append(addressHTML);
        $('.review-order .address').prepend(storeAddressHTML);
    };
    
    var updateCartSummary = function(total_price) {
        discount = total_price * parseFloat(discountrate);
        tax = total_price * parseFloat(taxrate);
                
        $(".subtotal-amount-nodiscount").html(
            total_price ===  0 ? "$0.00" : "$" + total_price);
        $(".subtotal-amount").html(
            (total_price - parseFloat(discount)) === 0 ? 
                "$0.00" : "$" + (total_price - parseFloat(discount)));
        $(".tax-total").html(tax === 0 ? "$0.00" : "$" + tax);
        $(".estimated-total").html(
            (total_price - discount + tax) === 0 ? 
                "$0.00" : "$" + (total_price - discount + tax));
    };
    
    var _renderElements = function() {
        let user;
        user = (userInfo.length > 0 ? JSON.parse(userInfo) : null);
 
        if (user) {
            let name = user['name'];
            let lastName = user['lastName'];
            let phone = user['phone'];
            let email = user['email'];
            
            $('#checkoutFirstName').val(name);
            $('#checkoutLastName').val(lastName);
            $('#checkoutEmail').val(email);
            $('#checkoutPhoneNum').val(phone);
        }
        renderAddressInfo();
        
        const listTemplate =  
            ['<div class="product-cart-display">',
                '{{&img}}',
                '<div class="description cart-description-padding">',
                    '<p class="product-name">{{item_name}}</p>',
                    '{{&toppings}}',
                    '{{&editLinks}}',
                '</div>',
                '<div class="details">',
                    '<p id="item-price-{{key}}" class="price">${{sub_total}}</p>',
                    '<p class="quantity">Qty: {{qty}}</p>',         
                '</div>',
            '</div>'].join("\n");
        Cart.renderCart(data, $(".review-order-cart-items"), listTemplate);
        updateCartSummary(total);
    };
    
    var _initElements = function() {
        $("input#checkoutPhoneNum").mask("(999) 999-9999");
        $("input#paymentZipCode").mask("99999");
        $("input#paymentSecurityCode").mask("999");
        var creditcard = $("#paymentCardNumber").mask("9999 9999 9999 9999");

        $("#paymentCardType").change(
          function() {
            switch ($(this).val()){
              case 'amex':
                creditcard.unmask().mask("9999 999999 99999");
                break;
              default:
                creditcard.unmask().mask("9999 9999 9999 9999");
                break;
            }
          }
        );

        $("#payment-type").tabs();

        $(".edit-product").on("click", function(event){
            event.preventDefault();

            if(!turned) {
                $(this).children(".icon-expand").css("transform", "rotate(180deg)");
                $("div[id='instr-"+this.id +"']").removeAttr("style");
                turned = true;
            }
            else {
                $(this).children(".icon-expand").removeAttr("style");
                $("div[id='instr-"+this.id +"']").css("display", "none");
                turned = false;
            }               
        });

        $("#schedule-order").on("click", function(){
            $(this).is(':checked') ? 
                $("#schedule-order-pao").removeAttr("style") :
                $("#schedule-order-pao").css("display", "none"); 
        });
        
        $("#create-account-from-checkout").on("click", function(){
            $(this).is(':checked') ? 
                $("#create-account-password-from-checkout").removeAttr("style") :
                $("#create-account-password-from-checkout").css("display", "none");
        });
        
        $('#password-help').on('click', function(event) {
            event.preventDefault();
            if(!clicked) {
                $('#tooltip175010').css('display', 'block');
                clicked = true;
            }
            else {
                $('#tooltip175010').css('display', 'none');
                clicked = false;
            }  
        });
        $('#create-account-show-password').on('click', function(event) {
            event.preventDefault();
            if(!showPwd) {
                $('#create-account-password').prop('type', 'password');
                $(this).text('Show password');
                showPwd = true;
            }
            else {
                $('#create-account-password').prop('type', 'text');
                $(this).text('Hide password');
                showPwd = false;
            }      
        });

        $("#scheduled-date").datepicker();
        
        jQuery.validator.addMethod("escapecode", function(value, element){
            if (/^<script\b[^>]*>(.*?)<\/script>/.test(value)) {
                return false;  // FAIL validation when REGEX matches
            } else {
                return true;   // PASS validation otherwise
            };
        }, "Invalid Input!");

        var validator = $('#place-order').validate({
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
                phoneNum: {
                    required: true,
                    phoneUS: true
                },
                cardNumber: {
                    required: true
                    //creditcard: true
                },
                cardType: {
                    required: true
                },
                nameOnCard: {
                    required: true
                },
                expMonth: 'required',
                expYear: 'required',
                zipCode: 'required',
                securityCode: 'required',
                termsAgreement: 'required'
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
                cardType:'Card type required!'
            }
        });

        $('#checkout-review-order').on('click', function(event) {
            event.preventDefault();

            if (validator.form()) {
                $('.contact-payment').hide();
                $('.review-order').show();
                $('#review a').addClass('active');
                $('#payment a').removeClass('active');

                var contact = $('#checkoutFirstName').val() + ' ' +
                              $('#checkoutLastName').val() + '<br>' +
                              $('#checkoutEmail').val() + '<br>' +
                              $('#checkoutPhoneNum').val();

                $('#contact-information').html(contact);
            }

        });

        $('.contact-payment-button').on('click', function(event) {
            event.preventDefault();

            $('.contact-payment').show();
            $('.review-order').hide();
            $('#review a').removeClass('active');
            $('#payment a').addClass('active');
        });
        
        $('#user-info-edit-cart').on('click', function(event) {
            event.preventDefault();
            $.ajax({
                method: 'GET',
                url: cartAddr,
                beforeSend: function(xhrObj) {
                    xhrObj.setRequestHeader("X-CSRF-Token", "Fetch");
                }
            }).done(function() {
                window.location.href = retCartAddr;
            });
        });
        
        $('#review-order-edit-cart').on('click', function(event) {
            event.preventDefault();
            $.ajax({
                method: 'GET',
                url: cartAddr,
                beforeSend: function(xhrObj) {
                    xhrObj.setRequestHeader("X-CSRF-Token", "Fetch");
                }
            }).done(function() {
                window.location.href = retCartAddr;
            });
        });
        
        $('#review-order-shopping').on('click', function(event) {
            event.preventDefault();
            $.ajax({
                method: 'GET',
                url: menuURL,
                beforeSend: function(xhrObj) {
                    xhrObj.setRequestHeader("X-CSRF-Token", "Fetch");
                }
            }).done(function() {
                window.location.href = retAddrMenuURL;
            });
        });
        
        $('#user-info-shopping').on('click', function(event) {
            event.preventDefault();
            $.ajax({
                method: 'GET',
                url: menuURL,
                beforeSend: function(xhrObj) {
                    xhrObj.setRequestHeader("X-CSRF-Token", "Fetch");
                }
            }).done(function() {
                window.location.href = retAddrMenuURL;
            });
        });

        $('#payment-type ul li a').on('click', function(event) {
            event.preventDefault();
            var payment_type_str = $(this).attr('href').split('#')[1];
            var arr = payment_type_str.split('_');
            var len = arr.length;
            var payment_type = '';
            for (var i = 0; i < len; i++) {
                payment_type += arr[i];
                if (len > 1 && i < len-1)
                    payment_type += ' ';
            }
            $('#payment-type-name').text(payment_type);
            $('#checkout-payment-type').val(payment_type);
        });
        
        $('#place-order').on('submit', function(event) {
            event.preventDefault();
            
            $.ajax({
                method: 'POST',
                url: placeOrderURL,
                beforeSend: function(xhrObj) {
                    xhrObj.setRequestHeader("X-CSRF-Token", CSRF);
                },
                data: $('#place-order').serialize()
            }).done(function(result) {
                if (result === 'SUCCESS') {
                    $('#checkout-status').text('Order Placed Successfully!');
                } else {
                    $('#checkout-status').text(result);
                }
                $('.order-success').show();
                $('.review-order').hide();
                $('#review a').removeClass('active');
                $('#success a').addClass('active');
            });
        });
    };
    
    var init = function(params) {
        data = params.cart;
        
        discount = 0;
        discountrate = params.discountrate; 
        tax = 0;
        taxrate = params.taxrate;
        
        turned = false;
        showPwd = false;
        clicked = false;
        
        _renderElements();
        _initElements();
    };
    
    return {init:init};
})(jQuery);