/**
 * jquery.weather.js
 * 2017-12-26
 */

		// function to get weather for an address
		function getWeather(latitude,longitude) {
			if(latitude != '' && longitude != '') {
				$("#weather").text("Retrieving weather...");										// write temporary response while we get the weather
				// 5 day forecast is available at any location or city. weekly weather and param(id) of city code. busan:1838524
				// http://api.openweathermap.org/data/2.5/forecast?id=1838524&appid=faba8d5a8c992f5240b45622499d2bc1
				// http://api.openweathermap.org/data/2.5/weather?lat="+latitude+"&lon="+longitude+"&units=imperial&appid=faba8d5a8c992f5240b45622499d2bc1"
				// add '&units=imperial' to get U.S. measurements
				$.getJSON( "http://api.openweathermap.org/data/2.5/weather?id=1838524&appid=faba8d5a8c992f5240b45622499d2bc1", function(data) {	
					var currWeather					= new Array();								// create array to hold our weather response data
					currWeather['currTemp']			= Math.round(data.main.temp);				// current temperature
					currWeather['highTemp']			= Math.round(data.main.temp_max);			// today's high temp
					currWeather['lowTemp']			= Math.round(data.main.temp_min);			// today's low temp
					currWeather['humidity']			= Math.round(data.main.humidity);			// humidity (in percent)
					currWeather['pressure']			= data.main.pressure * 0.02961339710085;	// barometric pressure (converting hPa to inches)
					currWeather['pressure']			= currWeather['pressure'].toFixed(2);		// barometric pressure (rounded to 2 decimals)
					currWeather['description']		= data.weather[0].description;				// short text description (ie. rain, sunny, etc.)
					currWeather['icon']				= "http://openweathermap.org/img/w/"+data.weather[0].icon+".png";	// 50x50 pixel png icon
					currWeather['id']				= data.weather[0].id;						// short text id (200, 201, 962, etc.)
					currWeather['cloudiness']		= data.clouds.all;							// cloud cover (in percent)
					currWeather['windSpeed']		= Math.round(data.wind.speed);				// wind speed
					
					currWeather['windDegree']		= data.wind.deg;							// wind direction (in degrees)
					currWeather['windCompass']		= Math.round((currWeather['windDegree'] -11.25) / 22.5);	// wind direction (compass value)
					
					var textResponse 	= currWeather['description']+" : ";	// englishg and to hangul				
					switch (currWeather['id']){ // switch values is id to the response
					  
					
					case 200 :
						textResponse		+= "가벼운 비를 동반한 천둥구름";
					  break;
					case 201 :
						textResponse		+= "비를 동반한 천둥구름";
					  break;
					case 202 :
						textResponse		+= "폭우를 동반한 천둥구름";
					  break;
					case 210 :
						textResponse		+= "약한 천둥구름";
					  break;
					case 211 :
						textResponse		+= "천둥구름";
					  break;
					  
					case 301 :
						textResponse		+= "안개비";
					  break;
					case 310 :
						textResponse		+= "가벼운 적은 비";
					  break;
					case 311 :
						textResponse		+= "적은 비";
					  break;
					case 312 :
						textResponse		+= "굵게 내리는 적은 비";
					  break;
					case 313 :
						textResponse		+= "소나기와 안개비";
					  break;
					case 314 :
						textResponse		+= "강한 소나기와 안개비";
					  break;
					case 321 :
						textResponse		+= "소나기";
					  break;
					case 500 :
						textResponse		+= "약한 비";
					  break;
					case 501 :
						textResponse		+= "중간 비";
					  break;  
					case 502 :
						textResponse		+= "강한 비";
					  break;
					case 503 :
						textResponse		+= "매우 강한 비";
					  break; 
					case 504 :
						textResponse		+= "극심한 비";
					  break;   
					case 601 :
						textResponse		+= "눈";
					  break;
					case 602 :
						textResponse		+= "강한 눈";
					  break;
					case 611 :
						textResponse		+= "진눈깨비";
					  break;
					case 612 :
						textResponse		+= "소나기 진눈깨비";
					  break;
					case 615 :
						textResponse		+= "약한 비와 눈";
					  break;
					case 616 :
						textResponse		+= "비와 눈";
					  break;
					case 620 :
						textResponse		+= "약한 소나기 눈";
					  break;
					case 621 :
						textResponse		+= "소나기 눈";
					  break;
					case 622 :
						textResponse		+= "강한 소나기 눈";
					  break;
					case 721 :
						textResponse		+= "연무";
					  break;
					case 741 :
						textResponse		+= "안개";
					  break;
					case 771 :
						textResponse		+= "돌풍";
					  break;

					case 800 :
						textResponse		+= "구름 한 점 없는 맑은 하늘";
					  break;
					case 801 :
						textResponse		+= "약간의 구름이 낀 하늘";
					  break;
					case 802 :
						textResponse		+= "드문드문 구름이 낀 하늘";
					  break;
					case 803 :
						textResponse		+= "구름이 거의 없는 하늘";
					  break;
					case 804 :
						textResponse		+= "구름으로 뒤덮인 흐린 하늘";
					  break;
					  
					case 901 :
						textResponse		+= "태풍";
					  break;
					case 903 :
						textResponse		+= "한랭";
					  break;
					case 904 :
						textResponse		+= "고온";
					  break;
					case 905 :
						textResponse		+= "바람";
					  break;
					case 906 :
						textResponse		+= "우박";
					  break;
					case 951 :
						textResponse		+= "바람이 거의 없는";
					  break;
					case 960 :
						textResponse		+= "폭풍";
					  break;
					case 961 :
						textResponse		+= "강한 폭풍";
					  break;
					  
					default :
						textResponse		+= "("+currWeather['id']+")";
					}
					
					
					// array of direction (compass) names
					var windNames					= new Array("North","North Northeast","Northeast","East Northeast","East","East Southeast", "Southeast", "South Southeast","South","South Southwest","Southwest","West Southwest","West","West Northwest","Northwest","North Northwest");
					// array of abbreviated (compass) names
					var windShortNames				= new Array("N","NNE","NE","ENE","E","ESE", "SE", "SSE","S","SSW","SW","WSW","W","WNW","NW","NNW");
					currWeather['windDirection']	= windNames[currWeather['windCompass']];	// convert degrees and find wind direction name
					
					var iconResponse				= "<img src='"+currWeather['icon']+"' />"
					var response 					= "Current Weather: "+currWeather['currTemp']+"\xB0 and "+currWeather['description'];
					var spokenResponse				= "It is currently "+currWeather['currTemp']+" degrees and "+currWeather['description'];
					var spokenResponse_kr			= "오늘의 날씨.  "+textResponse+".";
					if(currWeather['windSpeed']>0) {											// if there's wind, add a wind description to the response
						response		= response+" with winds out of the "+windNames[currWeather['windCompass']]+" at "+currWeather['windSpeed'];
						spokenResponse	= spokenResponse+" with winds out of the "+windNames[currWeather['windCompass']]+" at "+currWeather['windSpeed'];
						if(currWeather['windSpeed']==1) {
							response		+= " mile per hour";
							spokenResponse	+= " mile per hour";
						} else {
							response		+= " miles per hour";
							spokenResponse	+= " miles per hour";
						}
					}
					
										
					//console.log(data);												// log weather data for reference (json format) 
					//$("#weather").text(response);									
					
					$("#weather_icon").html(iconResponse);
					$("#weather").text(textResponse);
					//speakText(spokenResponse_kr);
					//google_language_for_div(textResponse, 'translation1', 'en')
					
					// google translate.
					/* google.language.detect(textResponse, function(result) {
					    if (!result.error && result.language) {
					      google.language.translate(textResponse, result.language, 'ko',
					                                function(result) {
					        var translated = document.getElementById('translation1');
					        if (result.translation) {
					          translated.innerHTML = result.translation;
					          $("#translation1").text(result.translation);
					        }
					      });
					    }
					  }); */
				});
			} else {
				return false;														// respond w/error if no address entered
			}
		}
		