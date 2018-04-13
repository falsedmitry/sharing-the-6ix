document.addEventListener('turbolinks:load', function() {
  var getBackToolButton = document.querySelector("[name=get-tool-back]");
  var lendToolButton = document.querySelector("[name=lend-tool]");

  if (getBackToolButton && lendToolButton) {
    if (lendToolButton.getAttribute('data-loan') == 'true') {
      lendToolButton.style.display = 'none';
      getBackToolButton.style.display = 'block';
    } else {
      lendToolButton.style.display = 'block';
      getBackToolButton.style.display = 'none';
    }

    getBackToolButton.addEventListener('click', function() {
      var toolID = getBackToolButton.getAttribute('data-toolid');

      $.ajax({
        url: 'https://limitless-dawn-77973.herokuapp.com/tools/' + toolID,
        method: 'PATCH',
        data: {},
        dataType: 'json'
      }).done(function(data) {
        console.log("done");
        console.log(toolID);

        getBackToolButton.style.display = 'none';
        lendToolButton.style.display = 'block';

      }).fail(function() {
        console.log("fail");
        console.log(toolID);
      });
    });
  }
});
