// document.addEventListener('DOMContentLoaded', function() {
//
//   function initMap() {
//     var postalCode = {lat: <%= @lat %>, lng: <%= @lng %>};
//     var postalCode2 = {lat: (<%= @lat %> + 0.001), lng: (<%= @lng %> + 0.001)};
//
//     var map = new google.maps.Map(
//       document.querySelector('#map'), {
//       zoom: 14,
//       center: postalCode
//     });
//
//     var coordinates = <%= @coords %>
//
//     for (var i = 0; i < coordinates.length; i++) {
//       var marker = new google.maps.Marker({
//         position: {
//           lat: coordinates[i][0],
//           lng: coordinates[i][1]
//         },
//         map: map
//       })
//     }
//
//     var rectangle = new google.maps.Rectangle({
//       strokeColor: '#FF0000',
//       strokeOpacity: 0.8,
//       strokeWeight: 2,
//       fillColor: '#FFE180',
//       fillOpacity: 0.5,
//       map: map,
//       bounds: {
//         north: <%= @north %>,
//         south: <%= @south %>,
//         east: <%= @east %>,
//         west: <%= @west %>
//       }
//     });
//   }
// })
