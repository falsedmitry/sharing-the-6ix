document.addEventListener('turbolinks:load', function(){
// When the user scrolls down 20px from the top of the document, show the button
  var backToTopButton = document.querySelector('#back-to-top-btn');
  window.onscroll = function() {scrollFunction()};

  function scrollFunction() {
      if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
          document.getElementById('back-to-top-btn').style.display = 'block';
      } else {
          document.getElementById("back-to-top-btn").style.visibility = 'visible';
      }
  }

  // When the user clicks on the button, scroll to the top of the document
  function topFunction() {
      document.body.scrollTop = 0;
      document.documentElement.scrollTop = 0;
  }
}
