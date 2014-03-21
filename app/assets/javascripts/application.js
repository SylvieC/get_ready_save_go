// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require raphael
//= require morris
//= require_tree .

//google direction example
function flight() {
  var mapOptions = {
    zoom: 3,
    center: new google.maps.LatLng(0, -180),
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };

  var map = new google.maps.Map(document.getElementById('googleMap'),
      mapOptions);

  var flightPlanCoordinates = [
    new google.maps.LatLng(37.772323, -122.214897),
    new google.maps.LatLng(21.291982, -157.821856),
    new google.maps.LatLng(-18.142599, 178.431),
    new google.maps.LatLng(-27.46758, 153.027892)
  ];
  var flightPath = new google.maps.Polyline({
    path: flightPlanCoordinates,
    geodesic: true,
    strokeColor: '#FF0000',
    strokeOpacity: 1.0,
    strokeWeight: 2
  });

  flightPath.setMap(map);
}

google.maps.event.addDomListener(window, 'load', flight); 



//start
// var directionsDisplay;
// var directionsService = new google.maps.DirectionsService();
// var map2

function initialize() {
  directionsDisplay = new google.maps.DirectionsRenderer();
  var chicago = new google.maps.LatLng(41.850033, -87.6500523);
  var mapOptions = {
    zoom:6,
    center:chicago
  };
  map2 = new google.maps.Map(document.getElementById('anotherMap'), mapOptions);
  directionsDisplay.setMap(map);
 $("#anotherMap").on("click", showAlert(
   window.alert('Div Clicked')));
}
google.maps.event.addDomListener(window, 'load',initialize);



//last try with third map using tutorial that wasn't working before
  var location1;
  var location2;
  
  var address1;
  var address2;

  var latlng;
  var geocoder;
  var map;
  
  var distance;

 
  var location1;
  var location2;
  
  var address1;
  var address2;

  var latlng;
  var geocoder;
  var map;
  
  var distance;
  
  // finds the coordinates for the two locations and calls the showMap() function
  function initialize()
  {
    geocoder = new google.maps.Geocoder(); // creating a new geocode object
    
    // getting the two address values
    // address1 = document.getElementById("address1").value;
    // address2 = document.getElementById("address2").value;
     address1 = 'paris, France';
    address2 = 'San Francisco';
    
    // finding out the coordinates
    if (geocoder) 
    {
      geocoder.geocode( { 'address': address1}, function(results, status) 
      {
        if (status == google.maps.GeocoderStatus.OK) 
        {
          //location of first address (latitude + longitude)
          location1 = results[0].geometry.location;
        } else 
        {
          alert("Geocode was not successful for the following reason: " + status);
        }
      });
      geocoder.geocode( { 'address': address2}, function(results, status) 
      {
        if (status == google.maps.GeocoderStatus.OK) 
        {
          //location of second address (latitude + longitude)
          location2 = results[0].geometry.location;
          // calling the showMap() function to create and show the map 
          showMap();
        } else 
        {
          alert("Geocode was not successful for the following reason: " + status);
        }
      });
    }
  }
     
  // creates and shows the map
  function showMap()
  {
    // center of the map (compute the mean value between the two locations)
    latlng = new google.maps.LatLng((location1.lat()+location2.lat())/2,(location1.lng()+location2.lng())/2);
    
    // set map options
      // set zoom level
      // set center
      // map type
    var mapOptions = 
    {
      zoom: 1,
      center: latlng,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    
    // create a new map object
      // set the div id where it will be shown
      // set the map options
    map = new google.maps.Map(document.getElementById("thirdMap"), mapOptions);
    
    // show route between the points
    directionsService = new google.maps.DirectionsService();
    directionsDisplay = new google.maps.DirectionsRenderer(
    {
      suppressMarkers: true,
      suppressInfoWindows: true
    });
    directionsDisplay.setMap(map);
    var request = {
      origin:location1, 
      destination:location2,
      travelMode: google.maps.DirectionsTravelMode.DRIVING
    };
    directionsService.route(request, function(response, status) 
    {
      if (status == google.maps.DirectionsStatus.OK) 
      {
        directionsDisplay.setDirections(response);
        distance = "The distance between the two points on the chosen route is: "+response.routes[0].legs[0].distance.text;
        distance += "<br/>The aproximative driving time is: "+response.routes[0].legs[0].duration.text;
        document.getElementById("distance_road").innerHTML = distance;
      }
    });
    
    // show a line between the two points
    var line = new google.maps.Polyline({
      map: map, 
      path: [location1, location2],
      strokeWeight: 7,
      strokeOpacity: 0.8,
      strokeColor: "#FFAA00"
    });
    
    // create the markers for the two locations   
    var marker1 = new google.maps.Marker({
      map: map, 
      position: location1,
      title: "First location"
    });
    var marker2 = new google.maps.Marker({
      map: map, 
      position: location2,
      title: "Second location"
    });
    
    // create the text to be shown in the infowindows
    var text1 = '<div id="content">'+
        '<h1 id="firstHeading">First location</h1>'+
        '<div id="bodyContent">'+
        '<p>Coordinates: '+location1+'</p>'+
        '<p>Address: '+address1+'</p>'+
        '</div>'+
        '</div>';
        
    var text2 = '<div id="content">'+
      '<h1 id="firstHeading">Second location</h1>'+
      '<div id="bodyContent">'+
      '<p>Coordinates: '+location2+'</p>'+
      '<p>Address: '+address2+'</p>'+
      '</div>'+
      '</div>';
    
    // create info boxes for the two markers
    var infowindow1 = new google.maps.InfoWindow({
      content: text1
    });
    var infowindow2 = new google.maps.InfoWindow({
      content: text2
    });

    // add action events so the info windows will be shown when the marker is clicked
    google.maps.event.addListener(marker1, 'click', function() {
      infowindow1.open(map,marker1);
    });
    google.maps.event.addListener(marker2, 'click', function() {
      infowindow2.open(map,marker1);
    });
    
    // compute distance between the two points
    var R = 6371; 
    var dLat = toRad(location2.lat()-location1.lat());
    var dLon = toRad(location2.lng()-location1.lng()); 
    
    var dLat1 = toRad(location1.lat());
    var dLat2 = toRad(location2.lat());
    
    var a = Math.sin(dLat/2) * Math.sin(dLat/2) +
        Math.cos(dLat1) * Math.cos(dLat1) * 
        Math.sin(dLon/2) * Math.sin(dLon/2); 
    var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a)); 
    var d = R * c;
    
    document.getElementById("distance_direct").innerHTML = "<br/>The distance between the two points (in a straight line) is: "+d;
  }
  
  function toRad(deg) 
  {
    return deg * Math.PI/180;
  }      
    
   
     

//js.chart
  window.onload = function () {
    var chart = new CanvasJS.Chart("chartContainer", {

      title:{
        text: "Total Amount Saved For the Trip"              
      },
      data: [//array of dataSeries              
        { //dataSeries object

         /*** Change type "column" to "bar", "area", "line" or "pie"***/
         type: "line",
         dataPoints: [
         { label: "05-05-14", y: 104 },
         { label: "week2", y: 204 },
         { label: "week3", y: 300 },                                    
         { label: "week4", y: 302 },
         { label: "grape", y: 400 }
         ]
       }
       ]
     });

    chart.render();
  };

  
