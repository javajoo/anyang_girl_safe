/**
 * ChartGraph Default Setting
 * 김동식
 * 2018-01-19
 */

//iot 그래프챠트 초기화 
var graph_width = window.innerWidth-560;
var chart = c3.generate({
	bindto: '#chart',
	size: {
		width: graph_width,
		height: 225
	},
	padding: {
		right: 30
	},
	legend: {
        show: false
    },
	data: {
		xFormat: '%Y%m%d%H%M',
		//x: 'x',
		/*columns: [
			['x'	, '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23'],
			['악취농도'	, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
			['온도'	, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
			['습도'	, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
			['풍속'	, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
		],*/
		json: [
		       {"siteno":101,"seq":1,"hh":"201712242111","ou":7.4,"temperature":null,"humidity":null,"windspeed":null},
		       {"siteno":101,"seq":2,"hh":"201712242211","ou":8.4,"temperature":null,"humidity":null,"windspeed":null},
		       {"siteno":101,"seq":3,"hh":"201712242311","ou":2.4,"temperature":null,"humidity":null,"windspeed":null},
		       {"siteno":101,"seq":4,"hh":"201712250011","ou":6.4,"temperature":null,"humidity":null,"windspeed":null},
		       {"siteno":101,"seq":5,"hh":"201712250111","ou":9.4,"temperature":null,"humidity":null,"windspeed":null},
		       {"siteno":101,"seq":6,"hh":"201712250611","ou":2.4,"temperature":null,"humidity":null,"windspeed":null},
		       {"siteno":101,"seq":7,"hh":"201712250711","ou":1.4,"temperature":null,"humidity":null,"windspeed":null},
		       {"siteno":101,"seq":8,"hh":"201712250811","ou":4.4,"temperature":null,"humidity":null,"windspeed":null},
		       {"siteno":101,"seq":9,"hh":"201712250911","ou":8.4,"temperature":null,"humidity":null,"windspeed":null}
		],
		keys: {
			x: 'hh',
			value: ['ou']
		},
		type: 'spline',
	},
	grid: {
		x: {
			//선택된 이벤트
			//lines: [{value: 18}]
		},
		y: {
			show: true
		}
	},
    axis: {
        x: {
            type: 'timeseries',
            tick: {
            	format: '%H:%M'
            	//format: function(idx){return idx.toLocaleString()+'aaaaa';}
            }
        }
    }
});
/* setTimeout(function () {
    c3.generate({
        data: {
        	x: 'x',
        	url: '/json/iotChart.json',
            mimeType: 'json',
            type: 'spline'
        }
    });
}, 1000); */
/*   setTimeout(function () {
    chart.load({
    	x: 'x',
    	url: '/json/iotChart.json',
        mimeType: 'json',
        type: 'spline'
    });
}, 3000); */