// Generated by CoffeeScript 1.3.3
(function() {

  $(function() {
    return $('#speedSelect').change(function() {
      var select, speed;
      select = $('#speedSelect')[0];
      speed = select.options[select.selectedIndex].value;
      return window.canvasData.speed = parseInt(speed);
    });
  });

  $(function() {
    return $('#armSlider').slider({
      min: 1,
      max: 100,
      value: 50,
      slide: function(event, ui) {
        return window.armLen = ui.value;
      }
    });
  });

  $(function() {
    return $('#poiSlider').slider({
      min: 1,
      max: 100,
      value: 50,
      slide: function(event, ui) {
        return window.poiLen = ui.value;
      }
    });
  });

  $(function() {
    return $('#poiABeats').spinner({
      spin: function(event, ui) {
        return window.poiABeats = parseInt(ui.value);
      }
    });
  });

  $(function() {
    return $('#armADirection').change(function() {
      if ($('#armADirection').attr('checked') === "checked") {
        return window.armADirection = true;
      } else {
        return window.armADirection = false;
      }
    });
  });

  $(function() {
    return $('#poiBBeats').spinner({
      spin: function(event, ui) {
        return window.poiBBeats = parseInt(ui.value);
      }
    });
  });

  $(function() {
    return $('#armBDirection').change(function() {
      if ($('#armBDirection').attr('checked') === "checked") {
        return window.armBDirection = true;
      } else {
        return window.armBDirection = false;
      }
    });
  });

}).call(this);
