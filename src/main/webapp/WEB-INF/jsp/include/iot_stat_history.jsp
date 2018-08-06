<!-- 기간검색 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="cont_area">
	<div id="iotStatH_management" title="" style="height:100%;">
		<ul class="stat_list_condi">
			<li class="list">					
				<em class="list_em">기간검색</em>
				<input id="startDate" class="easyui-datebox" data-options="formatter:myformatter,parser:myparser,prompt:'시작일 입력'" style="width:140px;">
				&nbsp;~ 
				<input id="endDate" class="easyui-datebox" data-options="formatter:myformatter,parser:myparser,prompt:'종료일 입력'" style="width:140px;">
				<select id="searchGubun" class="easyui-combobox"  style="width:82px;">
					<option value="d">일일통계</option>
					<option value="m">월간통계</option>
					<option value="y">연간통계</option>
				</select>
				<!-- <select id="search_iotStatH_gbn" class="easyui-combobox"  style="width:72px;">
					<option value="1">1시</option>
					<option value="3">3시</option>
					<option value="6">6시</option>
					<option value="9">9시</option>
					<option value="11">11시</option>
					<option value="13">13시</option>
					<option value="16">16시</option>
					<option value="19">19시</option>
					<option value="21">21시</option>
				</select> -->
		
				<a href="#" id="search_iotStatH" class="iotStatH_button_list" onclick="search_iotStatH()">조회</a>
			
			</li>
		</ul>
		
		<ul class="list_ty" style="height:calc(100% - 129px);">
			<div class="table_title"><br>
				기간검색 : <em>0000-00-00 ~ 0000-00-00</em><br><br>
			</div>
			<div class="containerx">
				<table width="100%" id="charth_group">
				<tr>
					<td width="50%"><img class="chart_title" src="/images/icons/iot_graph_title1.png" title="악취 (OU/㎥)"><div id="charth1" style="z-index:1;width: 100%;">분석중...</div></td>
					<td width="50%"><img class="chart_title" src="/images/icons/iot_graph_title2.png" title="온도 (ºC)"><div id="charth2" style="z-index:1;width: 100%;">분석중...</div></td>
				</tr>
				<tr>
					<td width="50%"><img class="chart_title" src="/images/icons/iot_graph_title3.png" title="습도 (%)"><div id="charth3" style="z-index:1;width: 100%;">분석중...</div></td>
					<td width="50%"><img class="chart_title" src="/images/icons/iot_graph_title4.png" title="풍속 (m/s)"><div id="charth4" style="z-index:1;width: 100%;">분석중...</div></td>			
				</tr>
				</table>
				<!-- <div class="easyui-panel" title="Register" style="position: absolute;width:100%;max-width:400px;padding:30px 60px;z-index:100;">
					<div class="chart_btn"></div>
				</div> -->
			</div>
			<script>
			
			var graph_stat_width = window.innerWidth/2;
			var graph_stat_height = 225;
			var graph_stat_padding_right = 40;
			var graph_stat_padding_left = 110;
			var graph_stat_nodeid = ['s1', 's102', 's103', 's104', 's105', 's106', 's107', 's108', 's109', 's110', 's1101', 's1102', 's1103', 's1104', 's1105', 's1106', 's1107', 's1108', 's1109', 's1110', 's1111', 's1112', 's1113', 's1114', 's1115', 's1116', 's1117'];
			var graph_stat_data = [{"hh":"20180101","s1":0.00,"s102":0.00,"s103":0.00,"s104":0.00,"s105":0.00,"s106":0.00,"s107":0.00,"s108":0.00,"s109":0.00,"s110":0.00,"s1101":0.00,"s1102":0.00,"s1103":0.00,"s1104":0.00,"s1105":0.00,"s1106":0.00,"s1107":0.00,"s1108":0.00,"s1109":0.00,"s1110":0.00,"s1111":0.00,"s1112":0.00,"s1113":0.00,"s1114":0.00,"s1115":0.00,"s1116":0.00,"s1117":0.00}];

			var charth1 = c3.generate({
				bindto: '#charth1',
				size: {
					width: graph_stat_width,
					height: graph_stat_height,
				},
				padding: {
					right: graph_stat_padding_right,
					left: graph_stat_padding_left,
				},
				legend: {
			        show: false
			    },
			    data: {
					
		            json: graph_stat_data
					,	
			    	keys: {
		                x: 'hh', // it's possible to specify 'x' when category axis
		                value: graph_stat_nodeid,
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
		        },
				grid: {
					y: {
						show: true
					}
				},
				axis: {
		            x: {
		                type: 'category',
	                	//type: 'timeseries',
	                    tick: {
	                    	format: '%d'
	                    	//format: function(idx){return idx.toLocaleString()+'aaaaa';}
	                    }
		            }
		        }
			});
			var charth2 = c3.generate({
				bindto: '#charth2',
				size: {
					width: graph_stat_width,
					height: graph_stat_height,
				},
				padding: {
					right: graph_stat_padding_right,
					left: graph_stat_padding_left,
				},
				legend: {
			        show: false
			    },
			    data: {
					
					json: graph_stat_data
					,
					keys: {
		                x: 'hh', // it's possible to specify 'x' when category axis
		                value: graph_stat_nodeid
		            }
		        },
				grid: {
					y: {
						show: true
					}
				},
				axis: {
		            x: {
		            	type: 'category',
	                	//type: 'timeseries',
	                    tick: {
	                    	format: '%d'
	                    	//format: function(idx){return idx.toLocaleString()+'aaaaa';}
	                    }
		            }
		        }
				
			});
			var charth3 = c3.generate({
				bindto: '#charth3',
				size: {
					width: graph_stat_width,
					height: graph_stat_height,
				},
				padding: {
					right: graph_stat_padding_right,
					left: graph_stat_padding_left,
				},
				legend: {
			        show: false
			    },
			    data: {
					
					json: graph_stat_data
					,
					keys: {
		                x: 'hh', // it's possible to specify 'x' when category axis
		                value: graph_stat_nodeid
		            }
		        },
				grid: {
					y: {
						show: true
					}
				},
				axis: {
		            x: {
		            	type: 'category',
	                	//type: 'timeseries',
	                    tick: {
	                    	format: '%d'
	                    	//format: function(idx){return idx.toLocaleString()+'aaaaa';}
	                    }
		            }
		        }
			});
			
			var charth4 = c3.generate({
				bindto: '#charth4',
				size: {
					width: graph_stat_width,
					height: graph_stat_height,
				},
				padding: {
					right: graph_stat_padding_right,
					left: graph_stat_padding_left,
				},
				legend: {
			        show: false
			    },
				data: {
					
					json: graph_stat_data
					,
		            keys: {
		                x: 'hh', // it's possible to specify 'x' when category axis
		                value: graph_stat_nodeid
		            },
		        },

		    	grid: {
		    		y: {
		    			show: true
		    		}
		    	},
		        axis: {
		            x: {
		            	type: 'category',
	                	//type: 'timeseries',
	                    tick: {
	                    	format: '%d'
	                    	//format: function(idx){return idx.toLocaleString()+'aaaaa';}
	                    }
		            }
		        }
		    });			
			
							
	

			//console.log(charth1.internal);
			//console.log(charth1.internal.xAxisTickFormat[[Scopes]][0].e.data_names);
			//시설물 선택리스트
			d3.select('.containerx').append('div').attr('class', 'legend').selectAll('span')
			    .data(charth1.internal.hiddenLegendIds)
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
			  .each(function (id) {//console.log(charth1.color(id));
			    	d3.select(this).style('background-color', charth1.color(id));
			    	d3.select(this).style('background-color', charth2.color(id));
			    	d3.select(this).style('background-color', charth3.color(id));
			    	d3.select(this).style('background-color', charth4.color(id));
			    })
			    
			    .on('mouseover', function (id) {
			    	charth1.focus(id);
			    	charth2.focus(id);
			    	charth3.focus(id);
			    	charth4.focus(id);
			    })

			    /* .on('mouseout', function (id) {
			    	charth1.revert();
			    	charth2.revert();
			    	charth3.revert();
			    	charth4.revert();
			    })
			    .on('click', function (id) {
			    	charth1.toggle(id);
			    	charth2.toggle(id);
			    	charth3.toggle(id);
			    	charth4.toggle(id);
			    }); */
			</script>
			
		</ul>
	</div>
	
</div>
<!-- 	<div id="dlgIotStat" class="easyui-dialog" title="기간검색 통계" data-options="iconCls:'',modal:true" style="width:500px;height:140px;padding:20px;">
	 <div style="text-align: center;">
	 <br>
	 출력할 데이터가 없습니다.
	 <br>
	 </div>
	</div> -->
