<!DOCTYPE html>
<html>
<head>
<title>My poi canvas experiment</title>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
<script src="http://code.jquery.com/ui/1.9.0/jquery-ui.js"></script>
<link rel="stylesheet" href="./css/screen.css" />
<link rel="stylesheet" href="http://code.jquery.com/ui/1.9.0/themes/base/jquery-ui.css" />
</head>

<body>
	<canvas id="canvasArea" width="1000px" height="1000px" ></canvas> 
	<div id="controlPanel" >
		<table>
			<tr>
				<td>
					Animation speed: 
				</td>
				<td>
					<select id="speedSelect" >
						<option value="1" >1</option>
						<option value="2" >2</option>
						<option value="3" >3</option>
						<option value="4" >4</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>
					Arm Length:
				</td>
			</tr>
			<tr>
				<td colspan=2>
					<div id="armSlider"></div>
				</td>
			</tr>
			<tr>
				<td>
					Poi Length:
				</td>
			</tr>
			<tr>
				<td colspan=2>
					<div id="poiSlider"></div>
				</td>
			</tr>
			<tr>
				<td><h3>Poi #1</h3></td>
			</tr>
			<tr>
				<td>Number of beats: </td>
			</tr>
			<tr>
				<td>
					<input id="poiABeats" value="-3"></input>
				</td>
			</tr>
			<tr>
				<td>Reverse arm movement</td>
			</tr>
			<tr>
				<td><input type="checkbox" name="armADirection" value="true" id="armADirection"></input></td>
			</tr>
				<tr>
				<td><h3>Poi #2</h3></td>
			</tr>
			<tr>
				<td>Number of beats: </td>
			</tr>
			<tr>
				<td>
					<input id="poiBBeats" value="-3"></input>
				</td>
			</tr>
			<tr>
				<td>Reverse arm movement</td>
			</tr>
			<tr>
				<td><input type="checkbox" name="armBDirection" value="true" id="armBDirection"></input></td>
			</tr>
			
		</table>
	</div>
	<script type="text/javascript" src="./js/testScript.js"></script>
	<script type="text/javascript" src="./js/controlPanel.js"></script>
</body>


</html>