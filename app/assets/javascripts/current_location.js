function getGeoLocation() {
    navigator.geolocation.getCurrentPosition(setGeoCookie);
}

function setGeoCookie(position) {
    var cookie_val = position.coords.latitude + "|" + position.coords.longitude;
      document.cookie = "lat_lng=" + escape(cookie_val);
}
//// Check to see if the browser supports the GeoLocation API.
//if (navigator.geolocation) {
//  navigator.geolocation.getCurrentPosition(function(position) {
//    var lat = position.coords.latitude;
//    var lon = position.coords.longitude;
//  });
//} else {
//    // Print out a message to the user.
//   document.write('Your browser does not support GeoLocation');
//}
