/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

var addrZipCode = zipcode;
var map;
var service;
var mapMarkers = {};
var labels = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
var labelIndex = 0;
var bounds;

var originAddr;
var origins = []; //for distance service
var originsDelivery = [];
var dests = {};
var destsGeos = [];
var distances = {};

var minDistance = 0;
var $listMarker;  

var readyToCheckOut;
readyToCheckOut = sessionStorage.getItem('readyToCheckOut');

function autoCompleteCreateAcctForm() {
    let map = new google.maps.Map(document.getElementById('map'), {
        zoom: 5,
        center: {lat: 37.275, lng: -104.656}
    });
    
    let input = document.getElementById('createAccountForm-streetaddress');
    let cityInputElem = document.getElementById('createAccountForm-usa-city');
    let zipInputElem = document.getElementById('createAccountForm-usa-zipcode');

    let autocomplete = new google.maps.places.Autocomplete(input);
    let autocomplete1 = new google.maps.places.Autocomplete(cityInputElem);
    let autocomplete2 = new google.maps.places.Autocomplete(zipInputElem);

    autocomplete.bindTo('bounds', map);

    autocomplete.addListener('place_changed', function() {
        let place = autocomplete.getPlace();
        let street_name = '';
        let zipcode = '';
        if (place !== undefined && place.address_components !== undefined) {
            let addr_components = place.address_components;
            for (let i = 0, addr_comp; addr_comp = addr_components[i]; i++) {
                if (addr_comp['types'][0] === 'street_number' ) {
                    street_name += addr_comp['short_name'] + ' '; 
                } else if (addr_comp['types'][0] === 'route' ) {
                    street_name += addr_comp['short_name'];
                } else if (addr_comp['types'][0] === 'postal_code') {
                    zipcode = addr_comp['short_name'];
                }
            }
        }

        input.value = street_name;
        let zipCodeInputElem = document.getElementById('createAccountForm-usa-zipcode');
        zipCodeInputElem.value = zipcode;
    });

    autocomplete1.addListener('place_changed', function() {
        let place = autocomplete1.getPlace();
        let state = '';
        let city = '';
        if (place !== undefined && place.address_components !== undefined) {

            let addr_components = place.address_components;
            for (let i = 0, addr_comp; addr_comp = addr_components[i]; i++) {
                if (addr_comp['types'][0] === 'administrative_area_level_1') {
                    state = addr_comp['short_name'];
                } else if (addr_comp['types'][0] === 'locality') {
                    city = addr_comp['short_name'];
                }
            }
        }
        $('#createAccountForm-state').val(state);
        $('#createAccountForm-usa-city').val(city);
    });

    autocomplete2.addListener('place_changed', function() {
        let place = autocomplete2.getPlace();
        let zipcode = '';
        if (place !== undefined && place.address_components !== undefined) {

            let addr_components = place.address_components;
            for (let i = 0, addr_comp; addr_comp = addr_components[i]; i++) {
                if (addr_comp['types'][0] === 'postal_code') {
                    zipcode = addr_comp['short_name'];
                }
            }
        }
        if (zipcode.length > 0) {
            let zipCodeInputElem = document.getElementById('createAccountForm-usa-zipcode');
            zipCodeInputElem.value = zipcode;
        }
    });
}

function autoComplete() {
    let map = new google.maps.Map(document.getElementById('map'), {
        zoom: 5,
        center: {lat: 37.275, lng: -104.656}
    });
    
    let input = document.getElementById('locations-streetaddress');
    let cityInputElem = document.getElementById('locations-city');
    let zipInputElem = document.getElementById('locations-zipcode');
    let zipInputElem1 = document.getElementById('locations-zipPostalcode');

    let autocomplete = new google.maps.places.Autocomplete(input);
    let autocomplete1 = new google.maps.places.Autocomplete(cityInputElem);
    let autocomplete2 = new google.maps.places.Autocomplete(zipInputElem);
    let autocomplete3 = new google.maps.places.Autocomplete(zipInputElem1);

    autocomplete.bindTo('bounds', map);

    autocomplete.addListener('place_changed', function() {
        let place = autocomplete.getPlace();
        let street_name = '';
        let zipcode = '';
        if (place !== undefined && place.address_components !== undefined) {
            let addr_components = place.address_components;
            for (let i = 0, addr_comp; addr_comp = addr_components[i]; i++) {
                if (addr_comp['types'][0] === 'street_number' ) {
                    street_name += addr_comp['short_name'] + ' '; 
                } else if (addr_comp['types'][0] === 'route' ) {
                    street_name += addr_comp['short_name'];
                } else if (addr_comp['types'][0] === 'postal_code') {
                    zipcode = addr_comp['short_name'];
                }
            }
        }

        input.value = street_name;
        let zipCodeInputElem = document.getElementById('locations-zipcode');
        zipCodeInputElem.value = zipcode;
    });

    autocomplete1.addListener('place_changed', function() {
        let place = autocomplete1.getPlace();
        let state = '';
        let city = '';
        if (place !== undefined && place.address_components !== undefined) {

            let addr_components = place.address_components;
            for (let i = 0, addr_comp; addr_comp = addr_components[i]; i++) {
                if (addr_comp['types'][0] === 'administrative_area_level_1') {
                    state = addr_comp['short_name'];
                } else if (addr_comp['types'][0] === 'locality') {
                    city = addr_comp['short_name'];
                }
            }
        }
        $('#locations-state').val(state);
        $('#locations-city').val(city);
    });

    autocomplete2.addListener('place_changed', function() {
        let place = autocomplete2.getPlace();
        let zipcode = '';
        if (place !== undefined && place.address_components !== undefined) {

            let addr_components = place.address_components;
            for (let i = 0, addr_comp; addr_comp = addr_components[i]; i++) {
                if (addr_comp['types'][0] === 'postal_code') {
                    zipcode = addr_comp['short_name'];
                }
            }
        }
        if (zipcode.length > 0) {
            let zipCodeInputElem = document.getElementById('locations-zipcode');
            zipCodeInputElem.value = zipcode;
        }
    });

    autocomplete3.addListener('place_changed', function() {
        let place = autocomplete3.getPlace();
        let zipcode = '';
        if (place !== undefined && place.address_components !== undefined) {
            let addr_components = place.address_components;
            for (let i = 0, addr_comp; addr_comp = addr_components[i]; i++) {
                if (addr_comp['types'][0] === 'postal_code') {
                    zipcode = addr_comp['short_name'];
                }
            }
        }
        if (zipcode.length > 0) {
            let zipCodeInputElem1 = document.getElementById('locations-zipPostalcode');
            zipCodeInputElem1.value = zipcode;
        }
    });
}

var deliveryAddress;

function geocodeAddressDelivery() {
    let geocoder = new google.maps.Geocoder();
    return new Promise(function(resolve, reject) {
        geocoder.geocode(
            {'address': deliveryAddress},
            function(results, status) {
                if (status == google.maps.GeocoderStatus.OK) {
                    // resolve results upon a successful status
                    originAddr = results[0].formatted_address;
                    originsDelivery.push(results[0].geometry.location);
                    deliveryAddress = results[0].formatted_address;
                    resolve(results);
                } else {
                    // reject status upon un-successful status
                    reject(status);
                }
            });
    });
}


function getPlaceDetails(place, service) {
    return new Promise(function(resolve, reject) {
        let request = {
            placeId: place.place_id,
            fields: ['formatted_address', 'opening_hours',
                'formatted_phone_number', 'geometry']
        };
        service.getDetails(request, function(place, status) {
            if (status == google.maps.places.PlacesServiceStatus.OK) {
                destsGeos.push(place.geometry.location);
                dests[place.formatted_address] = place;
                resolve(place);
            } else {
                reject(status);
            }
        });
    });
}

function nearbyDeliveryStoreSearch(service, geocodeResults) {
    return new Promise(function(resolve, reject) {
        service.nearbySearch(
            {location: geocodeResults[0].geometry.location, 
             radius: 8000, 
             name: ["Papa John's Pizza"]},
            function(places, status) {
                if (status == google.maps.places.PlacesServiceStatus.OK) {
                    for (var i = 0, place; place = places[i]; i++) {
                        getPlaceDetails(place, service)
                            .catch(function(status) {
                                console.log(status + " " + places[i] + i);
                            });
                    }
                    resolve(places);
                } else {
                    reject(status);
                }
            });
    });
}

function getDistances() {
    return new Promise(function(resolve, reject) {
        let disService = new google.maps.DistanceMatrixService;
            disService.getDistanceMatrix({
                origins: originsDelivery,
                destinations: destsGeos,
                travelMode: 'DRIVING',
                unitSystem: google.maps.UnitSystem.IMPERIAL,
                avoidHighways: false,
                avoidTolls: false
            }, function(response, status) {
                if (status === 'OK') {
                    let results = response.rows[0].elements;
                    let minDistance = 0.0;
                    for (let i = 0; i < results.length; i++) {
                        let distance = 
                            parseFloat(results[i].distance.text.split(" ")[0]).toFixed(2);
                        distances[distance] = response.destinationAddresses[i];
                        if (i === 0)
                            minDistance = distance;
                        if (minDistance > distance)
                            minDistance = distance;
                        i++;
                    }
                    let storeInfo = dests[distances[minDistance]];
                    if (storeInfo !== undefined) {
                        let date = new Date();
                        let day = date.getDay();
                        let openingHours = 
                            storeInfo.opening_hours
                                .weekday_text[(day === 0 ? 6 : day - 1)];

                        let store_address = storeInfo.formatted_address;
                        let store_phone = storeInfo.formatted_phone_number;
                        let store_opening_hours = openingHours.split(": ")[1];
                        let store_distance = minDistance;

                        $.ajax({
                            method: 'POST',
                            url: saveAddrURL,
                            beforeSend: function(xhrObj) {
                                xhrObj.setRequestHeader("X-CSRF-Token", CSRF);
                            },
                            data: {'address' : deliveryAddress,
                                   'orderType' : 'DELIVERY',
                                   'store_address' : store_address,
                                   'store_phone' : store_phone,
                                   'store_opening_hours' : store_opening_hours,
                                   'store_distance' : store_distance,
                                   'store_direction' : 'https://www.google.com/maps/dir/?api=1',
                                   'origin' : originAddr,
                                   'destination' : store_address,
                                   'travelmode' : 'driving'}
                        }).done(function() {
                            if (readyToCheckOut === "true") {
                                $.ajax({
                                    method: 'GET',
                                    url: checkoutAddr,
                                    beforeSend: function(xhrObj) {
                                        xhrObj.setRequestHeader("X-CSRF-Token", "Fetch");
                                    }
                                }).done(function() {
                                    window.location.href = retCheckoutAddr;
                                });
                            }
                            else {
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
                    resolve(response);
                } else {
                    reject(status);
                }
            });
    });
}

function nearestDeliveryStore() {
    let map = new google.maps.Map(document.getElementById('map'), {
        zoom: 5,
        center: {lat: 37.275, lng: -104.656}
    });
    
    deliveryAddress = deliveryAddressParam;

    
    let service = new google.maps.places.PlacesService(map);

    geocodeAddressDelivery()
        .then(function(results) {
            nearbyDeliveryStoreSearch(service, results)
                .then(function() {
                    getDistances()
                        .catch(function(status) {
                            $('#modal-dialog').show();
                            console.log(status);
                        });
                })
                .catch(function(status) {
                    $('#modal-dialog').show();
                    console.log(status);
                });
        })
        .catch(function(status) {
            $('#modal-dialog').show();
            console.log(status);
        });
    if ($('#spinner').is(':visible')) {
        $('#spinner').hide();
    }
}

/**
 * Google Map API starter (callback) 
 */
function initMap() {

    map = new google.maps.Map(document.getElementById('map'), {
        zoom: 5,
        center: {lat: 37.275, lng: -104.656}
    });
    bounds = new google.maps.LatLngBounds();
    var geocoder = new google.maps.Geocoder();
    geocodeAddress(geocoder, map);
  
}

/*
 * Retrieve the longitude and the latitude of the zip code
 * , and perform a nearby search to get nearby stores
 * , and create a list for nearby stores' detailed information. 
 * @param {google.maps.Geocoder} geocoder
 * @param {google.maps.Map} resultsMap
 */
function geocodeAddress(geocoder, resultsMap) {
    geocoder.geocode(
        {'address' : addrZipCode.toString()}, 
        function(results, status) {
            if (status === 'OK') {
                originAddr = results[0].formatted_address;

                // Create the places service.
                service = new google.maps.places.PlacesService(resultsMap);
                origins.push(results[0].geometry.location);

                new google.maps.Marker({
                    map: map,
                    icon: '../images/home.png',
                    position: results[0].geometry.location
                });

                // Perform a nearby search.
                service.nearbySearch(
                    {location: results[0].geometry.location, 
                     radius: 8000, 
                     name: ["Papa John's Pizza"]},
                    function(places, status) {
                        if (status !== 'OK') return;
                        //create a list of store details on the side
                        createStoreListElem(places);                    
                    }
                );
            } else {
                alert('Geocode was not found for the following reason: ' + status);
            }
        });
}

/*
 * Create a list of detailed store information,
 * and get details about each store.
 * @param {Array<google.maps.places.PlaceResult>} places
 */
function createStoreListElem(places) {
    for (var i = 0, place; place = places[i]; i++) {   
        var request = {
            placeId: place.place_id,
            fields: ['formatted_address', 'opening_hours',
                'formatted_phone_number', 'geometry']
        };

        service.getDetails(request, function(place, status) {
            if (status == google.maps.places.PlacesServiceStatus.OK) {                      
                calculateDistances(place);
            }
        });                     
    }
}

/*
 * Calculate distance for each nearby stores (retrieved from nearby
 * search). Attach details to the list (accordion control).
 * @param {google.maps.places.PlaceResult} place
 */
function calculateDistances(place) {              
    var disService = new google.maps.DistanceMatrixService;
    disService.getDistanceMatrix({
        origins: origins,
        destinations: [place.geometry.location],
        travelMode: 'DRIVING',
        unitSystem: google.maps.UnitSystem.IMPERIAL,
        avoidHighways: false,
        avoidTolls: false
    }, function(response, status) {
        if (status !== 'OK') {
            alert('Error was: ' + status);
        } 
        else {
            createMarker(place);

            let results = response.rows[0].elements;
            //store address and relevant info
            let $listElem = createStoreInfo(place, results);

            //store detail
            $listElem.append(createStoreDetails(place));

            $('.store-locations-accord').append($listElem);                        
        }
    });      
}

/*helper functions*/

/*
 * Create markers with alphabet labels on the map.
 * @param {google.maps.places.PlaceResult} place
 */
function createMarker(place) {             
    let image = {
        url: '../images/loc.png',
        origin: new google.maps.Point(0, 0),
        labelOrigin: new google.maps.Point(24, 24)
    };

    let label = {
        color: '#FFFFFF',
        fontFamily: '"HCo Knockout 49","HelveticaNeue-CondensedBold",' +
            'Helvetica,Arial,sans-serif',
        fontSize: '20px',
        text: labels[labelIndex++ % labels.length]
    };

    let marker = new google.maps.Marker({
        map: map,
        icon: image,
        label: label,
        title: place.name,
        position: place.geometry.location
    });          

    marker.addListener('mouseover', function() {
        var newImage = {
            url: '../images/loc-red.png',
            origin: new google.maps.Point(0, 0),
            labelOrigin: new google.maps.Point(24, 24)
        };

        this.setIcon(newImage);

        //highlight relevant list maker on accordion
        //when the mouse cursor hang over a map marker
        $listMarker = $('#icon-' + this.label.text);
        $listMarker.toggleClass('icon-marker-selected');
    });

    marker.addListener('mouseout', function(){
        this.setIcon(image);

        $listMarker.toggleClass('icon-marker-selected');
    });

    //store each map marker in an object 
    //in the format {A: markerObj0, B: markerObj1,...}
    //which would be easier to retrieve
    mapMarkers[labels[labelIndex-1 % labels.length]] = marker;

    bounds.extend(place.geometry.location);
    map.fitBounds(bounds);          
}

/*
 * Combining store information in div containers.
 * @param {google.maps.places.PlaceResult} place
 * @param {google.maps.DistanceMatrixResponse} results
 * @returns {jQuery}
 */
function createStoreInfo(place, results) {
    let $listElem = $('<article>')
            .addClass('store-summary')
            .addClass('clearfix');
    $('.store-summary:first').addClass('active-panel');
    let $h3 = $('<h3>').attr('id', 'accord-' + 
        labels[(labelIndex-1) % labels.length])
            .addClass('clearfix')
            .append(createStoreLocMarker())
            .append(createStoreLocInfo(place, results));

    $h3.on('click', function(event) {
        event.stopPropagation();
        let $details = $(this).next('.store-details');
        let $accordBtn = $(this).children('.store-loc')
            .children('a');

        if ($(this).parent().hasClass('active-panel')) {
            if ($details.is(':visible')) {
                $accordBtn.css('transform', '');
                $details.css("display", "none");
            }
            else {
                $accordBtn.css('transform', 'rotate(180deg)');
                $details.css("display", "block");
            }
        }
        else {
            let $activePanel = $('.active-panel');
            let $activePanelDetails = $activePanel
                .children('.store-details');
            let $activeAccdBtn = $activePanel.children('h3')
                .children('.store-loc')
                .children('a');

            if ($activePanelDetails.is(':visible')) {
                $activePanelDetails.css("display", "none");
                $activeAccdBtn.css('transform', '');
            }

            $activePanel.removeClass('active-panel');
            $(this).parent().addClass('active-panel');
            $accordBtn.css('transform', 'rotate(180deg)');
            $details.css("display", "block");
        }
    });
    return $listElem.append($h3);  
}

/*
 * Create list markers on accordion control.
 * @returns {jQuery}
 */
function createStoreLocMarker() {
    let $iconMarker = $('<i>')
        .attr('id', 'icon-' + labels[(labelIndex-1) % labels.length])
        .addClass('icon-marker');

    var id;
    var idElem;
    var $selectedMapMarker; 
    $iconMarker.on('mouseover', function() {
        $(this).toggleClass('icon-marker-selected');

        id = $(this).attr('id');
        //the value of 'idElem[1]' would be 'A' 
        //if the value of 'id' is 'icon-A'
        idElem = id.split('-');
        $selectedMapMarker = mapMarkers[idElem[1]];
        $selectedMapMarker.setIcon({
            url: '../images/loc-red.png',
            origin: new google.maps.Point(0, 0),
            labelOrigin: new google.maps.Point(24, 24)
        });                        
    });
    
    $iconMarker.on('mouseout', function() {
        $(this).toggleClass('icon-marker-selected');

        $selectedMapMarker.setIcon({
            url: '../images/loc.png',
            origin: new google.maps.Point(0, 0),
            labelOrigin: new google.maps.Point(24, 24)
        });
    });
    return $('<div>').addClass("store-loc-marker")
        .append($iconMarker);
}

/*
 * Combining store location information with div containers.
 * @param {google.maps.places.PlaceResult} place
 * @param {google.maps.DistanceMatrixResponse} results
 * @returns {jQuery}
 */
function createStoreLocInfo(place, results) {
    //store address
    let $storeLoc = $('<div>')
        .addClass('store-loc')
        .attr('id', 'store-loc-' + (labelIndex-1));
    $('<p>').append(place.formatted_address)
        .appendTo($storeLoc);

    //stores' distances from provided zipcode
    $('<div>').addClass('store-distance')
        .append(results[0].distance.text + 
            'les from ' + addrZipCode.toString())
        .appendTo($storeLoc);

    //attach accordion expansion button
    let $showHideInfoBtn = $('<a href="#">')
        .addClass("show-hide-store-info");
    $('<i>').addClass('icon-expand')
        .addClass('icon')
        .appendTo($showHideInfoBtn);

    //information about whether a store is open or closed.
    let $storeStatus = $('<span>').addClass('store-status');

    if (place.opening_hours.open_now) {
        $storeStatus.append("Now Accepting Online Orders");
    }
    else {
        $storeStatus.css('color', 'red')
            .append("Now Store Is Closed");
    }

    //put information into div container
    $storeStatus.appendTo($storeLoc);
    $showHideInfoBtn.appendTo($storeLoc);
    return $storeLoc;
}

/*
 * Combining miscllaneous information such as opening hours, directions,
 * phone number and order form.
 * @param {google.maps.places.PlaceResult} place
 * @returns {jQuery}
 */
function createStoreDetails(place) {
    let $storeDetails = $('<div>').addClass('store-details');
    return $storeDetails.append(createStoreDirection(place))
        .append(createStoreHours(place));
}

/**
 * Combining direction link and phone number with div containers.
 * @param {google.maps.places.PlaceResult} place
 * @returns {jQuery}
 */
function createStoreDirection(place) {
    //store direction link
    let $direction = $('<div>').addClass('store-directions');
    let linkString = 'https://www.google.com/maps/dir/?api=1' +
        '&origin=' + originAddr + '&destination=' +
        place.formatted_address + '&travelmode=driving';

    let $directionLink = $('<a>')
        .attr('href', linkString)
        .attr('target', '_blank')
        .append('Get directions');
    $('<span>').addClass('direction')
        .append($directionLink)
        .appendTo($direction);

    //phone number
    let $phoneLink = $('<a>')
        .attr('href', 'tel:' + place.formatted_phone_number)
        .append(place.formatted_phone_number);
    $('<span>').addClass('phone')
        .append('  ')
        .append($phoneLink)
        .appendTo($direction);

    return $direction;
}

/**
 * Combining opening hours and order form with div containers.
 * @param {google.maps.places.PlaceResult} place
 * @returns {jQuery}
 */
function createStoreHours(place) {
    let $split2 = $('<div>').addClass('split-2')
        .addClass('clearfix');
    let $openingHour = $('<div>').addClass('store-opening-hour')
        .append('Opening Hour')
        .append('<br>');

    //formatting opening hours information
    let date = new Date();
    let day = date.getDay();

    let openingHourStr = place.opening_hours.weekday_text[(day === 0 ? 6 : day - 1)].split(": ")[1];
    $('<span>').addClass('timing')
        .append(openingHourStr)
        .appendTo($openingHour);
    $openingHour.appendTo($split2);

    //order form and link to the menu
    let $orderCarryOutBtn = $('<button>')
        .attr('id', 'store-order-carryout-btn-' + (labelIndex-1) )
        .addClass('store-order-carryout-btn')
        .append('Order Carryout');

    $orderCarryOutBtn.on('click', function(event) {
        event.preventDefault();
        let id = event.target.id;
        let str = id.split("-");
        let newID = str[str.length-1];

        let store_phone = place.formatted_phone_number;
        let store_opening_hours = openingHourStr;
        let store_distance = $('#store-loc-' + newID + ' .store-distance').text().split(' ')[0];
        let addressParam = place.formatted_address;
        $.ajax({
            method: 'POST',
            url: saveAddrURL,
            beforeSend: function(xhrObj) {
                xhrObj.setRequestHeader("X-CSRF-Token", CSRF);
            },
            data: {'address' : addressParam,
                   'orderType' : 'CARRYOUT',
                   'store_direction' : 'https://www.google.com/maps/dir/?api=1',
                   'origin' : originAddr,
                   'destination' : place.formatted_address,
                   'travelmode' : 'driving',
                   'store_phone' : store_phone,
                   'store_opening_hours' : store_opening_hours,
                   'store_distance' : store_distance}
        }).done(function() {
            if (readyToCheckOut === "true") {
                $.ajax({
                    method: 'GET',
                    url: checkoutAddr,
                    beforeSend: function(xhrObj) {
                        xhrObj.setRequestHeader("X-CSRF-Token", "Fetch");
                    }
                }).done(function() {
                    window.location.href = retCheckoutAddr;
                });
            }
            else {
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
    });
    let $orderCarryOutForm = $('<form>')
        .attr('id', 'store-order-carryout-form-' + (labelIndex-1) )
        .append($orderCarryOutBtn);
    $('<div>').addClass('store-order-carryout')
        .append($orderCarryOutForm)
        .appendTo($split2);

    return $split2;
}