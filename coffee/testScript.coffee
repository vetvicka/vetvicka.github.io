	# init, all "global" variables are stored in window obj.
$ -> 
	window.context = document.getElementById( "canvasArea" ).getContext "2d"
	window.canvas  = document.getElementById( "canvasArea" )
	window.canvas.width = window.innerWidth - 350
	window.canvas.height = window.innerHeight - 8
	window.armLen = 50
	window.poiLen = 50
	window.poiABeats = -3
	window.poiBBeats = -3
	window.armBDirection = false
	window.armADirection = false
	window.showHands = true
	window.showTrails = true
	window.poiAShift = 0
	window.poiBShift = 180
	window.poiARotation = 0
	window.poiBRotation = 0
	x = Math.round window.canvas.width / 2
	y = Math.round window.canvas.height / 2
		# speed - how many degres will hands move per frame
	window.canvasData = (x: x, y: y, pos: 0, speed: 1)
	

$ ->
	$(window).resize ->
		window.canvas.width = window.innerWidth - 350
		window.canvas.height = window.innerHeight - 8
		window.canvasData.x = Math.round window.canvas.width / 2
		window.canvasData.y = Math.round window.canvas.height / 2
	

	# degres to radians...
degToRad = (deg) -> (deg * 2 * Math.PI) / 360


	# main loop, 17ms ~ 60 fps
$ ->
	setInterval animate, 21
	
	
	# The MAIN equation for poi position
calcX = (origin, deg, poi) -> origin + poi.armLen * Math.sin(degToRad(poi.rotation) + degToRad deg) + poi.poiLen * Math.sin(poi.beats * (degToRad deg))
calcY = (origin, deg, poi) -> origin + poi.armLen * Math.cos(degToRad(poi.rotation) + degToRad deg) + poi.poiLen * Math.cos(poi.beats * (degToRad deg))

	
drawPoi = (poi) ->
	# center of canvas TODO: make this dynamic!
	x0 = window.canvasData.x
	y0 = window.canvasData.y

	ctx = window.context
	
	# hand trail
	if window.showHands == true
		ctx.beginPath()
		x = window.canvasData.x
		y = window.canvasData.y
		ctx.arc x, y, poi.armLen, 0, Math.PI*2
		ctx.lineWidth = 0.5
		ctx.strokeStyle = "#cacaca"
		ctx.stroke()
	
	if window.showTrails == true
		ctx.beginPath()
		ctx.lineWidth = 0.5
		for i in [0..360]
			x = calcX x0, i, poi
			y = calcY y0, i, poi
			# console.log x, y
			ctx.lineTo x, y	
			ctx.strokeStyle = poi.poiColor	
		ctx.stroke()
		
	if window.showHands == true
		ctx.beginPath()
		x = x0 + poi.armLen * Math.sin(degToRad(poi.rotation) + degToRad poi.fromDeg)
		y = y0 + poi.armLen * Math.cos(degToRad(poi.rotation) + degToRad poi.fromDeg)
		ctx.arc x, y, 7, 0, Math.PI*2
		ctx.fillStyle = "brown" 
		ctx.fill()
		ctx.beginPath()
		ctx.moveTo x, y
		x = calcX x0, poi.fromDeg, poi
		y = calcY y0, poi.fromDeg, poi
		ctx.lineTo x, y
		ctx.stroke()
		
	
	# circle poi head
	x = calcX x0, poi.fromDeg, poi
	y = calcY y0, poi.fromDeg, poi
	ctx.beginPath()
	ctx.arc x, y, 7, 0, Math.PI * 2
	ctx.fillStyle = poi.poiColor
	ctx.fill()
	
	linePos = 91
	breaker = 0
	ctx.beginPath()
	for i in [poi.fromDeg..poi.toDeg]
		# console.log i
		x = calcX x0, i, poi
		y = calcY y0, i, poi
		# console.log x, y
		ctx.lineTo x, y	
		ctx.strokeStyle = poi.poiColor
		ctx.lineWidth = (10 * (linePos-- / 90))
		if breaker % 7 == 0
			ctx.stroke()
			ctx.beginPath()
			ctx.moveTo x, y
		# console.log breaker, breaker % 3
		breaker += 1
	ctx.stroke()
	

animate = ->
	# center of canvas TODO: make this dynamic!
	# will be stored in window
	x0 = 500
	y0 = 500

	ctx = window.context
		# clear the canvas
	ctx.clearRect 0, 0, window.canvas.width, window.canvas.height
	pos = window.canvasData.pos
	

	# poiObject, contains all data for functions
	poiA = 
		fromDeg: pos + 90 + window.poiAShift,
		toDeg: pos + window.poiAShift,
		poiColor: "Red",
		beats: window.poiABeats,
		showPath: true,
		rotation: window.poiARotation, # actually rotation !
		showHand: true,
		armLen: window.canvas.height / 4 * (window.armLen / 100),
		poiLen: window.canvas.height / 4 * (window.poiLen / 100),
		# armClockwise: true
	poiB = 
		fromDeg: pos + 90 + window.poiBShift,
		toDeg: pos + window.poiBShift,
		poiColor: "Green",
		beats: window.poiBBeats,
		showPath: true,
		rotation: window.poiBRotation,
		showHand: true,
		armLen: window.canvas.height / 4 * (window.armLen / 100)
		poiLen: window.canvas.height / 4 * (window.poiLen / 100)
		
	if window.armADirection
		poiA.fromDeg = 360 - pos + window.poiAShift
		poiA.toDeg = 360 - pos + 90 + window.poiAShift
	
	if window.armBDirection
		poiB.fromDeg = 360 - pos + window.poiBShift
		poiB.toDeg = 360 - pos + 90 + window.poiBShift
	
	drawPoi poiA
	drawPoi poiB
	oldPos = window.canvasData.pos
	window.canvasData.pos = (pos + 0.5 + window.canvasData.speed) % 360
	