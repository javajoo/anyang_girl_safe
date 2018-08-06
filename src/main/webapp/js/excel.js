/*접속이력 - 조회결과 엑셀*/
function accessR_excel(){
	console.log('접속이력조회 - 조회결과 엑셀 출력');
	
	var startDate = $("#search_accessR_timeS").datebox('getValue').replace(/\//g, '');
	var endDate = $("#search_accessR_timeE").datebox('getValue').replace(/\//g, '');
	var totSearch = $("#search_accessR_tot").val();
	
	var data = {
			startDate: startDate,
			endDate: endDate,
			totSearch : totSearch
        };
	var opts = $('#accessR_table').datagrid("getColumnFields");
	var cnt = 0;
	for(i = 0; i < opts.length; i++){
		if($('#accessR_table').datagrid("getColumnOption", opts[i]).hidden) continue;
		data["headerText"+cnt] = $('#accessR_table').datagrid("getColumnOption", opts[i]).title;
		data["headerField"+cnt] = opts[i];
		data["headerUse"+cnt] = "true";
		cnt++;
	}
	data["headerCnt"]=cnt;
	$.download( "com/danusys/platform/selectLogExcel.do", data);
}

/*접속이력 - 상세내역 엑셀*/
function accessR_dtl_excel(){
	console.log('접속이력조회 - 상세내역 엑셀 출력');
	
	var sessionId = $('#accessR_dtl_table').datagrid('getData').rows[0].sessionId;
	
	var data = {
			sessionId: sessionId
        };
	var opts = $('#accessR_dtl_table').datagrid("getColumnFields");
	var cnt = 0;
	for(i = 0; i < opts.length; i++){
		if($('#accessR_dtl_table').datagrid("getColumnOption", opts[i]).hidden) continue;
		data["headerText"+cnt] = $('#accessR_dtl_table').datagrid("getColumnOption", opts[i]).title;
		data["headerField"+cnt] = opts[i];
		data["headerUse"+cnt] = "true";
		cnt++;
	}
	data["headerCnt"]=cnt;
	$.download( "com/danusys/platform/selectCctvViewLogExcel.do", data);
}

/*시설물관제>시설물관리 - 일괄등록(엑셀업로드)*/
function excel_upd_facility(){
	
}

/*시설물관제>시설물관리 - 엑셀다운로드*/
function excel_down_facility(){
	console.log('시설물관리 - 엑셀 출력');
	 
	var facilityType = $("#search_facilityM_gbn1").combobox('getValue');
	
	var data = {
			facilityType: facilityType
        };
	var opts = $('#facilityM_table').datagrid("getColumnFields");
	var cnt = 0;
	for(i = 0; i < opts.length; i++){
		if($('#facilityM_table').datagrid("getColumnOption", opts[i]).hidden) continue;
		data["headerText"+cnt] = $('#facilityM_table').datagrid("getColumnOption", opts[i]).title;
		data["headerField"+cnt] = opts[i];
		data["headerUse"+cnt] = "true";
		cnt++;
	}
	data["headerCnt"]=cnt;
	$.download( "com/danusys/platform/selectFacilityMListExcel.do", data);
}