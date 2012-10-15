$ ->
	$('#speedSelect').change ->
		select = $('#speedSelect')[0]
		speed = select.options[select.selectedIndex].value
		window.canvasData.speed = parseInt speed

	

	
$ -> 
	$('#armSlider').slider (min:1, max:100, value: 50, slide: (event, ui) -> window.armLen = ui.value)
	
$ -> 
	$('#poiSlider').slider (min:1, max:100, value: 50, slide: (event, ui) -> window.poiLen = ui.value)
	

$ -> 
	$('#poiABeats').spinner (spin: (event, ui) -> window.poiABeats = parseInt ui.value)	

	
$ -> 
	$('#armADirection').change -> 
		if $('#armADirection').attr('checked') == "checked"
			window.armADirection = true
		else
			window.armADirection = false

		
$ -> 
	$('#poiBBeats').spinner (spin: (event, ui) -> window.poiBBeats = parseInt ui.value)	

	
$ -> 
	$('#armBDirection').change -> 
		if $('#armBDirection').attr('checked') == "checked"
			window.armBDirection = true
		else
			window.armBDirection = false
