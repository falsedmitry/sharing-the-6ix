document.addEventListener("turbolinks:load", function(){
  var menu = document.querySelector("#hamburger-menu")
  var dropdownContent = document.querySelector('.dropdown-content')
  menu.addEventListener('click', function() {
    dropdownContent.style.display = 'block'
    if (dropdownContent.style.visibility == 'hidden') {
      dropdownContent.style.visibility = 'visible'
    }
    else {
      dropdownContent.style.visibility = 'hidden'
    }
  })
})
