/*
function getURLParameter(name) {
    return decodeURI(
        (RegExp(name + '=' + '(.+?)(&|$)').exec(location.search)||[,null])[1]
    );
}
*/
(function(){
  var getURLParameter;
  getURLParameter = function(name){
    return decodeURI((RegExp(name + '=' + '(.+?)(&|$)').exec(location.search) || [void 8, null])[1]);
  };
  $(function(){
    var encoded, data, obj;
    encoded = getURLParameter('data');
    if (encoded != 'null') {
      data = decodeURIComponent(encoded);
      obj = window.JSON.parse(data);
      window.armLen = obj.armLen;
      window.poiLen = obj.poiLen;
      window.poiABeats = obj.poiABeats;
      window.poiBBeats = obj.poiBBeats;
      window.armBDirection = obj.armBDirection;
      window.armADirection = obj.armADirection;
      window.showHands = obj.showHands;
      window.showTrails = obj.showTrails;
      window.poiAShift = obj.poiAShift;
      window.poiBShift = obj.poiBShift;
      window.poiARotation = obj.poiARotation;
      return window.poiBRotation = obj.poiBRotation;
    }
  });
  $(function(){
    return $('#shareURLButton').click(function(){
      var obj, data, txt, link;
      obj = {
        armLen: window.armLen,
        poiLen: window.poiLen,
        poiABeats: window.poiABeats,
        poiBBeats: window.poiBBeats,
        armBDirection: window.armBDirection,
        armADirection: window.armADirection,
        showHands: window.showHands,
        showTrails: window.showTrails,
        poiAShift: window.poiAShift,
        poiBShift: window.poiBShift,
        poiARotation: window.poiARotation,
        poiBRotation: window.poiBRotation
      };
      data = window.JSON.stringify(obj);
      txt = encodeURIComponent(data);
      link = window.location.pathname + '?data=' + txt;
      return $('#shareURLLabel').html('<a href="' + link + '">-> Link <-</a>');
    });
  });
  $(function(){
    return $('#showHands').change(function(){
      if ($('#showHands').attr('checked') == "checked") {
        return window.showHands = true;
      } else {
        return window.showHands = false;
      }
    });
  });
  $(function(){
    return $('#showTrails').change(function(){
      if ($('#showTrails').attr('checked') == "checked") {
        return window.showTrails = true;
      } else {
        return window.showTrails = false;
      }
    });
  });
  /*			
  $ ->
  	$ '#poiAShift' .change ->
  		select = $('#poiAShift')[0]
  		shift = select .options[select.selectedIndex] .value
  		window.poiAShift = shift
  */
  $(function(){
    return $('#poiAShift').slider({
      min: 0,
      max: 360,
      value: 0
    }, {
      slide: function(event, ui){
        window.poiAShift = ui.value;
        return $('#poiAShiftLabel').text(ui.value + '°');
      }
    });
  });
  $(function(){
    return $('#poiBShift').slider({
      min: 0,
      max: 360,
      value: 180
    }, {
      slide: function(event, ui){
        window.poiBShift = ui.value;
        return $('#poiBShiftLabel').text(ui.value + '°');
      }
    });
  });
  $(function(){
    return $('#poiBRotation').slider({
      min: 0,
      max: 360,
      value: 0
    }, {
      slide: function(event, ui){
        window.poiBRotation = ui.value;
        return $('#poiBRotationLabel').text(ui.value + '°');
      }
    });
  });
  $(function(){
    return $('#poiARotation').slider({
      min: 0,
      max: 360,
      value: 0
    }, {
      slide: function(event, ui){
        window.poiARotation = ui.value;
        return $('#poiARotationLabel').text(ui.value + '°');
      }
    });
  });
  $(function(){
    return $('#poiRotation').slider({
      min: 0,
      max: 360,
      value: 0
    }, {
      slide: function(event, ui){
        window.poiARotation = ui.value;
        window.poiBRotation = ui.value;
        $('#poiARotationLabel').text(ui.value + '°');
        $('#poiARotationLabel').text(ui.value + '°');
        return $('#poiBRotationLabel').text(ui.value + '°');
      }
    });
  });
}).call(this);
