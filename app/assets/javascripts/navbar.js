document.addEventListener("turbolinks:load", function(){
  var menu = document.querySelector("#hamburger-menu");
  var dropdownContent = document.querySelector('.dropdown-content');

  menu.addEventListener('click', function() {
    dropdownContent.style.display = 'block';
    console.log(dropdownContent.style.visibility);

    if (dropdownContent.style.visibility !== 'visible') {
      dropdownContent.style.visibility = 'visible';
    }
    else {
      dropdownContent.style.visibility = 'hidden';
    }
  })
})
