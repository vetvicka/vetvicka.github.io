(function(){
  $(function(){
    return $('#showHands').change(function(){
      if ($('#showHands').attr('checked') == "checked") {
        return window.showHands = true;
      } else {
        return window.showHands = false;
      }
    });
  });
}).call(this);
