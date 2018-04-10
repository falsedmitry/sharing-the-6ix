document.addEventListener('turbolinks:load', function() {
  var getBackToolButton = document.querySelector("[name=get-tool-back]");

  getBackToolButton.addEventListener('click', function() {
    var toolID = getBackToolButton.getAttribute('data-toolid');

    $.ajax({
      url: 'http://localhost:3000/tools/' + toolID,
      method: 'GET',
      data: {},
      dataType: 'json'
    }).done(function(data) {
      console.log("done");
      console.log(toolID);
    }).fail(function() {
      console.log("fail");
      console.log(toolID);
    })
  })
})
