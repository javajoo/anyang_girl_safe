<!-- 실시간모니터링 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script>
$(function() {
    $('#search_iotStatM').change(function() {
      if($(this).prop('checked')==true){
    	  console.log('실시간 모니터링 시작');
    	  search_iotStatM();
      }else{
    	  console.log('실시간 모니터링 종료');
    	  search_iotStatM_stop();
      }
    })
  })
</script>
<div class="cont_area">
	<div id="iotStatM_management" title="" style="height:100%;">
		<ul class="stat_list_condi">
			<li class="list" style="flot:left">
				<em class="list_em">IoT환경 실시간모니터링입니다. Start를 클릭하시면 실시간 모니터링을 시작합니다.</em>
				<div class="iotStatM_button_list">		
				<input id="search_iotStatM" type="checkbox">&nbsp;<span>Start</span></input>
				</div>
				<!-- <a href="#" id="search_iotStatM" class="iotStatM_button_list" onclick="search_iotStatM()" alt="시작">Start</a> -->
			</li>
		</ul>
 		
		<ul class="list_ty" style="height:calc(100% - 129px);">
			<div class="table_title"><br>
				모니터링 시간: <em>0000-00-00 00:00</em><br><br>
			</div>
			<div class="containerm">
				<table id="chartm_group" cellpadding="10">
				<tr>
					<td >
					<img class="chart_title" src="/images/icons/iot_graph_title1.png" title="악취 (OU/㎥)">
					<div id="chartm1" style="z-index:1;width: 100%;">분석중...</div></td>
					<td >
					<img class="chart_title" src="/images/icons/iot_graph_title2.png" title="온도 (ºC)">
					<div id="chartm2" style="z-index:1;width: 100%;">분석중...</div></td>
				</tr>
				<tr>
					<td >
					<img class="chart_title" src="/images/icons/iot_graph_title3.png" title="습도 (%)">
					<div id="chartm3" style="z-index:1;width: 100%;">분석중...</div></td>
					<td >
					<img class="chart_title" src="/images/icons/iot_graph_title4.png" title="풍속 (m/s)">
					<div id="chartm4" style="z-index:1;width: 100%;">분석중...</div></td>			
				</tr>
				</table>
				<!-- <div class="easyui-panel" title="Register" style="position: absolute;width:100%;max-width:400px;padding:30px 60px;z-index:100;">
					<div class="chart_btn"></div>
				</div> -->
			</div>
			<script>
			
			var graph_mstatwidth = window.innerWidth/2;
			var graph_mstatheight = 225;
			var graph_mstatpadding_right = 40;
			var graph_mstatpadding_left = 110;
			var graph_mstatnodeid = ['s1', 's102', 's103', 's104', 's105', 's106', 's107', 's108', 's109', 's110', 's1101', 's1102', 's1103', 's1104', 's1105', 's1106', 's1107', 's1108', 's1109', 's1110', 's1111', 's1112', 's1113', 's1114', 's1115', 's1116', 's1117'];
			var graph_mstatdata = [{"hh":"201711101010","s1":0.00,"s102":0.00,"s103":0.00,"s104":0.00,"s105":0.00,"s106":0.00,"s107":0.00,"s108":0.00,"s109":0.00,"s110":0.00,"s1101":0.00,"s1102":0.00,"s1103":0.00,"s1104":0.00,"s1105":0.00,"s1106":0.00,"s1107":0.00,"s1108":0.00,"s1109":0.00,"s1110":0.00,"s1111":0.00,"s1112":0.00,"s1113":0.00,"s1114":0.00,"s1115":0.00,"s1116":0.00,"s1117":0.00}];

			var chartm1 = c3.generate({
				bindto: '#chartm1',
				size: {
					width: graph_mstatwidth,
					height: graph_mstatheight,
				},
				padding: {
					right: graph_mstatpadding_right,
					left: graph_mstatpadding_left,
				},
				legend: {
			        show: false
			    },
			    data: {
					xFormat: '%Y%m%d%H%M',
		            json: graph_mstatdata
					,	
			    	keys: {
		                x: 'hh', // it's possible to specify 'x' when category axis
		                value: graph_mstatnodeid,
		            },
		        	/* names: {
			            s1: '송정공원',
			            s102: '지오환경',
			            s103: '청정도금조합',
			            s104: '정산인터내셔널',
			            s105: '대동씨엠',
			            s106: '녹산하수처리장',
			            s107: '염색조합',
			            s108: '부영아파트',
			            s109: '명지소각장',
			            s110: '인후아스콘',
			        }, */
		            duration: 2000,
		        },
				grid: {
					y: {
						show: true
					}
				},
				axis: {
		            x: {
		                //type: 'category',
	                	type: 'timeseries',
	                    tick: {
	                    	format: '%M'
	                    	//format: function(idx){return idx.toLocaleString()+'aaaaa';}
	                    }
		            }
		        }
			});
			var chartm2 = c3.generate({
				bindto: '#chartm2',
				size: {
					width: graph_mstatwidth,
					height: graph_mstatheight,
				},
				padding: {
					right: graph_mstatpadding_right,
					left: graph_mstatpadding_left,
				},
				legend: {
			        show: false
			    },
			    data: {
					xFormat: '%Y%m%d%H%M',
					json: graph_mstatdata
					,
					keys: {
		                x: 'hh', // it's possible to specify 'x' when category axis
		                value: graph_mstatnodeid
		            },
			    	duration: 2000,
		        },
				grid: {
					y: {
						show: true
					}
				},
				axis: {
		            x: {
		                //type: 'category',
	                	type: 'timeseries',
	                    tick: {
	                    	format: '%M'
	                    	//format: function(idx){return idx.toLocaleString()+'aaaaa';}
	                    }
		            }
		        }
				
			});
			var chartm3 = c3.generate({
				bindto: '#chartm3',
				size: {
					width: graph_mstatwidth,
					height: graph_mstatheight,
				},
				padding: {
					right: graph_mstatpadding_right,
					left: graph_mstatpadding_left,
				},
				legend: {
			        show: false
			    },
			    data: {
					xFormat: '%Y%m%d%H%M',
					json: graph_mstatdata
					,
					keys: {
		                x: 'hh', // it's possible to specify 'x' when category axis
		                value: graph_mstatnodeid
		            },
			    	duration: 2000,
		        },
				grid: {
					y: {
						show: true
					}
				},
				axis: {
		            x: {
		                //type: 'category',
	                	type: 'timeseries',
	                    tick: {
	                    	format: '%M'
	                    	//format: function(idx){return idx.toLocaleString()+'aaaaa';}
	                    }
		            }
		        }
			});
			
			var chartm4 = c3.generate({
				bindto: '#chartm4',
				size: {
					width: graph_mstatwidth,
					height: graph_mstatheight,
				},
				padding: {
					right: graph_mstatpadding_right,
					left: graph_mstatpadding_left,
				},
				legend: {
			        show: false
			    },
				data: {
					xFormat: '%Y%m%d%H%M',
					json: graph_mstatdata
					,
		            keys: {
		                x: 'hh', // it's possible to specify 'x' when category axis
		                value: graph_mstatnodeid
		            },
			    	duration: 2000,
		        },

		    	grid: {
		    		y: {
		    			show: true
		    		}
		    	},
		        axis: {
		            x: {
		                //type: 'category',
	                	type: 'timeseries',
	                    tick: {
	                    	format: '%M'
	                    	//format: function(idx){return idx.toLocaleString()+'aaaaa';}
	                    }
		            }
		        }
		    });			
			
							
	

			//console.log(chartm1.internal);
			//console.log(chartm1.internal.xAxisTickFormat[[Scopes]][0].e.data_names);
			//시설물 선택리스트
			d3.select('.containerm').append('div').attr('class', 'legend').selectAll('span')
			    .data(chartm1.internal.hiddenLegendIds)
			  .enter()
			  .append('span')
			  .html(function (id,name) {
				  //임시로 임의지정 // 사이트번호 디비연동으로 변경해야 함
				  var nodename;
				  if(id=='s1'){nodename='송정공원'}
				  else if(id=='s102'){nodename='지오환경'}
				  else {nodename="기타시설물"}
				  var nodename = (id=='s1'?'송정공원':id=='s102'?'지오환경':id=='s103'?'청정도금조합':id=='s104'?'정산인터내셔널'
							:id=='s105'?'대동씨엠':id=='s106'?'녹산하수처리장':id=='s107'?'염색조합':id=='s108'?'부영아파트'
							:id=='s109'?'명지소각장':id=='s110'?'인후아스콘'
							:id=='s1101'?'르노남쪽1':id=='s1102'?'그린파워동쪽':id=='s1103'?'그린파워북쪽':id=='s1104'?'르노동쪽1'
							:id=='s1105'?'신호민원센터':id=='s1106'?'르노남쪽3':id=='s1107'?'삼득부지경계':id=='s1108'?'르노남쪽2'
							:id=='s1109'?'그린파워서쪽':id=='s1110'?'신호월더하임':id=='s1111'?'피마부지경계':id=='s1112'?'명지퀀텀'
							:id=='s1113'?'대동씨엠출입소':id=='s1114'?'조광배출원주변':id=='s1115'?'현대수산옥상':id=='s1116'?'현대수산배출구'
							:id=='s1117'?'피마배출구'
							:'기타시설물');
				  return id+":"+nodename; 
			  })  
			  .attr('data-id', function (id) { return id; })
			  .attr('class', 'chart_idcolor')  
			  .each(function (id) {
			    	d3.select(this).style('background-color', chartm1.color(id));
			    	d3.select(this).style('background-color', chartm2.color(id));
			    	d3.select(this).style('background-color', chartm3.color(id));
			    	d3.select(this).style('background-color', chartm4.color(id));
			    })
			    
			    .on('mouseover', function (id) {
			    	chartm1.focus(id);
			    	chartm2.focus(id);
			    	chartm3.focus(id);
			    	chartm4.focus(id);
			    })

			    /* .on('mouseout', function (id) {
			    	chartm1.revert();
			    	chartm2.revert();
			    	chartm3.revert();
			    	chartm4.revert();
			    })
			    .on('click', function (id) {
			    	chartm1.toggle(id);
			    	chartm2.toggle(id);
			    	chartm3.toggle(id);
			    	chartm4.toggle(id);
			    }); */
			</script>
			
		</ul>
	</div>
	
</div>
