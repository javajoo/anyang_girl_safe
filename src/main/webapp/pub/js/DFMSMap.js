Map = OpenLayers.Class(OpenLayers.Map, {
	allOverlays: true,
	maxlevel: 12,
	displayProjection: null,
	projection: null,
	maxResolution: 2048,
	maxExtent: null,
	numZoomLevels: 19,
	units: "m",
	mapType: null,

	initialize: function (div, options) {
		OpenLayers.Map.prototype.initialize.apply(this,[div,options]);
	},
	
	initMeasurement: function() {
		for (var i=0;i<prnSeq;i++){
			try{
				document.body.removeChild(document.getElementById('mprn'+i));
			}catch(ecp){}
		}

		if (document.getElementById('mprn-1') != null)
			document.body.removeChild(document.getElementById('mprn-1'));

		prnSeq = 0;
	
		if (this.measureControls != null) {
			this.measureControls["line"].deactivate();
			this.measureControls["polygon"].deactivate();
			this.removeControl(this.measureControls["line"]);
			this.removeControl(this.measureControls["polygon"]);
		}

		var sketchSymbolizers = {
				"Point": {pointRadius: 4,graphicName: "square",fillColor: "white",fillOpacity: 1,strokeWidth: 1,strokeOpacity: 1,strokeColor: "#f3c"},
				"Line": {strokeWidth: 3,strokeOpacity: 1,strokeColor: "#f33",strokeDashstyle: "solid"},
				"Polygon": {strokeWidth: 2,strokeOpacity: 1,strokeColor: "#f33",fillColor: "#fa5",fillOpacity: 0.3}
		};

		var style = new OpenLayers.Style();
		style.addRules([new OpenLayers.Rule({symbolizer: sketchSymbolizers})]);
		var styleMap = new OpenLayers.StyleMap({"default": style});

		// OpenLayers.Handler.Path 재정의
		DFMSPathHandler = OpenLayers.Class(OpenLayers.Handler.Path, {
		    addPoint: function(pixel) {
		    	// 툴팁 초기화
		    	if(endCheck){
		    		for (var i=0;i<prnSeq;i++){
		    			try{
		    				document.body.removeChild(document.getElementById('mprn'+i));
		    			}catch(ecp){}
		    		}

					if (document.getElementById('mprn-1') != null)
						document.body.removeChild(document.getElementById('mprn-1'));
	
					prnSeq = 0;
					endCheck = false;
		    	}
		        this.layer.removeFeatures([this.point]);
		        var lonlat = this.layer.getLonLatFromViewPortPx(pixel); 
		        this.point = new OpenLayers.Feature.Vector(
		            new OpenLayers.Geometry.Point(lonlat.lon, lonlat.lat)
		        );
		        this.line.geometry.addComponent(
		            this.point.geometry, this.line.geometry.components.length
		        );
		        this.layer.addFeatures([this.point]);
		        this.callback("point", [this.point.geometry, this.getGeometry()]);
		        this.callback("modify", [this.point.geometry, this.getSketch()]);
		        this.drawFeature();
		        delete this.redoStack;
		    },
		    
		    finishGeometry: function() {
		    	endCheck = true;
		        var index = this.line.geometry.components.length - 1;
		        this.line.geometry.removeComponent(this.line.geometry.components[index]);
		        this.removePoint();
		        this.finalize();
		    }
		});


		this.measureControls = {
				line: new OpenLayers.Control.Measure(
						DFMSPathHandler, {
								persist: true,
								handlerOptions: {
										layerOptions: {styleMap: styleMap}
								}
						}
				),
				polygon: new OpenLayers.Control.Measure(
						OpenLayers.Handler.Polygon, {
								persist: true,
								handlerOptions: {
										layerOptions: {styleMap: styleMap}
								}
						}
				)
		};
		
		if (this.getControlsByClass("OpenLayers.Control.Measure") != null) {
			for(var key in this.measureControls) {
				this.measureControls[key].events.on({
						"measure": function(event) {
							var geometry = event.geometry;
							var units = event.units;
							var order = event.order;
							var measure = event.measure;
							var out = "";
							if(order == 1) {
								out += measure.toFixed(3) + " " + units;
							} else {
								out += measure.toFixed(3) + " " + units + "<sup>2</sup>";
							}
							//el.innerHTML = out;
							var temp = geometry.components[geometry.components.length-1];
							if (typeof(temp.x) == 'undefined') {
								prnSeq--;
								temp = temp.components[0];
							}
							
							if(geometry.CLASS_NAME == "OpenLayers.Geometry.Polygon" && geometry.getVertices().length > 2){
								temp = geometry.getCentroid();
							}
							var pos = new OpenLayers.LonLat(temp.x, temp.y);

							var spos = this.map.getViewPortPxFromLonLat(pos);
							var offset = getAbsPos(this.map.viewPortDiv);
							spos.x = spos.x + offset[0];
							spos.y = spos.y + offset[1];
							if(measure.toFixed(3) != "0.000")
								mapPrint.show(prnSeq, null, out, null, spos, pos);
							prnSeq++;
						},
						"measurepartial": function(event) {
							var geometry = event.geometry;
							var units = event.units;
							var order = event.order;
							var measure = event.measure;
							var out = "";
							if(order == 1) {
								out +=  measure.toFixed(3) + " " + units;
							} else {
								out += measure.toFixed(3) + " " + units + "<sup>2</sup>";
							}
							//el.innerHTML = out;
							var temp = geometry.components[geometry.components.length-1];
							if (typeof(temp.x) == 'undefined') {
								prnSeq--;
								temp = temp.components[0];
							}

							if(geometry.CLASS_NAME == "OpenLayers.Geometry.Polygon" && geometry.getVertices().length > 2){
								temp = geometry.getCentroid();
							}

							var pos = new OpenLayers.LonLat(temp.x, temp.y);
							var spos = this.map.getViewPortPxFromLonLat(pos);
							var offset = getAbsPos(this.map.viewPortDiv);
							spos.x = spos.x + offset[0];
							spos.y = spos.y + offset[1];
							if(measure.toFixed(3) != "0.000")
								mapPrint.show(prnSeq, null, out, null, spos, pos);
							prnSeq++;
						}
				});
				this.addControl(this.measureControls[key]);
			}
		}
	},
	
	calcDistance: function() {
		this.initMeasurement();

		this.measureControls["line"].activate();
		this.measureControls["polygon"].deactivate();
	},
	calcArea: function() {
		this.initMeasurement();

		this.measureControls["line"].deactivate();
		this.measureControls["polygon"].activate();
	},
	CLASS_NAME: "Map"
});