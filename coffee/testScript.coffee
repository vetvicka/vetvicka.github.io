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
	x = Math.round window.canvas.width / 2
	y = Math.round window.canvas.height / 2
		# speed - how many degres will hands move per frame
	window.canvasData = (x: x, y: y, pos: 0, speed: 1)
	

$ ->
	$(window).resize ->
		window.canvas.width = window.innerWidth - 200
		window.canvas.height = window.innerHeight - 8
		window.canvasData.x = Math.round window.canvas.width / 2
		window.canvasData.y = Math.round window.canvas.height / 2
	

	# degres to radians...
degToRad = (deg) -> deg * 2 * Math.PI / 360


	# main loop, 17ms ~ 60 fps
$ ->
	setInterval animate, 17
	
	
	# The MAIN equation for poi position
calcX = (origin, deg, poi) -> origin + poi.armLen * Math.sin(poi.shift + degToRad deg) + poi.poiLen * Math.sin(poi.beats * (degToRad deg))
calcY = (origin, deg, poi) -> origin + poi.armLen * Math.cos(poi.shift + degToRad deg) + poi.poiLen * Math.cos(poi.beats * (degToRad deg))

	
drawPoi = (poi) ->
	# center of canvas TODO: make this dynamic!
	x0 = window.canvasData.x
	y0 = window.canvasData.y

	ctx = window.context
	
	# hand trail
	ctx.beginPath()
	x = window.canvasData.x
	y = window.canvasData.y
	ctx.arc x, y, poi.armLen, 0, Math.PI*2
	ctx.lineWidth = 0.5
	ctx.strokeStyle = "#cacaca"
	ctx.stroke()
	
	if poi.showPath == true
		ctx.beginPath()
		ctx.lineWidth = 0.5
		for i in [0..360]
			x = calcX x0, i, poi
			y = calcY y0, i, poi
			# console.log x, y
			ctx.lineTo x, y	
			ctx.strokeStyle = poi.poiColor	
		ctx.stroke()
		
	if poi.showHand == true
		ctx.beginPath()
		x = x0 + poi.armLen * Math.sin(poi.shift + degToRad poi.fromDeg)
		y = y0 + poi.armLen * Math.cos(poi.shift + degToRad poi.fromDeg)
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
		if breaker % 4 == 0
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
		fromDeg: pos + 90,
		toDeg: pos,
		poiColor: "Red",
		beats: window.poiABeats,
		showPath: true,
		shift: 0#Math.PI,
		showHand: true,
		armLen: window.canvas.height / 4 * (window.armLen / 100),
		poiLen: window.canvas.height / 4 * (window.poiLen / 100),
		# armClockwise: true
	poiB = 
		fromDeg: pos + 90 + 180,
		toDeg: pos + 180,
		poiColor: "Green",
		beats: window.poiBBeats,
		showPath: true,
		shift: 0#Math.PI,
		showHand: true,
		armLen: window.canvas.height / 4 * (window.armLen / 100)
		poiLen: window.canvas.height / 4 * (window.poiLen / 100)
		
	if window.armADirection
		poiA.fromDeg = 360 - pos
		poiA.toDeg = 360 - pos + 90
	
	if window.armBDirection
		poiB.fromDeg = 360 - pos + 180
		poiB.toDeg = 360 - pos + 90 + 180
	
	drawPoi poiA
	drawPoi poiB
	oldPos = window.canvasData.pos
	window.canvasData.pos = (pos + window.canvasData.speed) % 360
	