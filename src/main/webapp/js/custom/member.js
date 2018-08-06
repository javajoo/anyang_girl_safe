danu.member.Login = {
	loginButton: "#login",
	idInput: "#id",
	pwInput: "#password",
	init : function() {
		var style = danu.main.Options.style;
		if (style.lookAndFeel === "custom" && style.lookAndFeelName === "blackberry") {
			//$("#cont").removeClass("login_cont").addClass("login_cont_black");
			//$("#login").removeClass("btn_login").addClass("btn_login_black");
			//$(".login_box").removeClass("login_box").addClass("login_box_black");
			//$(".login_area").removeClass("login_area").addClass("login_area_black");
		}
		
		var message = $('#message').val();
	    if (message != "") {
	        alert(message);
	    }
	},
	setEvents: function() {
		var _this = this;
		$(this.loginButton).on("click", function() {
			_this.login();
		});
		$(this.idInput).keydown(function(e) {
			if(e.which == 13){
				_this.login();
			}
		});
		$(this.pwInput).keydown(function(e) {
			if(e.which == 13){
				_this.login();
			}
		});
		
	},
	login : function() {
		if ($(this.idInput).val() =="") {
	        alert("아이디를 입력하세요");
	    } else if ($(this.pwInput).val() =="") {
	        alert("비밀번호를 입력하세요");
	    } else {
	    	document.getElementById('loginForm').submit();
	    }
	}
}

/*danu.member.Member = {
	searchButton: "#search",
	init : function() {
		$('.datebox').removeClass("datebox").addClass("datebox-black");
		$('.mt20 .easyui-linkbutton').removeClass("easyui-linkbutton").addClass("easyui-linkbutton-black");
		
		$('.combobox-item').parents("div").removeClass("panel-body").addClass("combobox-item_black");
	},
	setEvents: function() {
		var _this = this;
		$(this.searchButton).on("click", function() {
			_this.search();
		});
	},
	search : function() {
		$('#search-result').datagrid('loadData', {"total":0,"rows":[]});
		
		var type = parseInt($(':radio[name="search"]:checked').val());
		var city = $('#city').combobox('getValue');
		var sig = $('#sig').combobox('getText');
		var gu = $('#gu').combobox('getValue');
		var emd = $('#emd').combobox('getValue');
   		var startDate = $('#search-start-time').combobox('getText');
   		var endDate = $('#search-end-time').combobox('getText');
   		//var nm  = $('#searchNm').val();
   		
   		var data = new Object();
   		data.type = type;
   		data.strCityNo = city;				//도
   		if(sig!="전체") data.sigungu = sig;	//시군구
   		data.strGuNo = gu;					//구
   		data.strEmdNo = emd;				//읍면동
   		data.strInstDe = startDate;
   		data.strUpdDe = endDate;
   		//data.strNm = nm;
   		
   		$.ajax({
   			method : 'GET',
   			data : data,
   			url : 'danu/com/platform/selectMembersList.do',
   			dataType : 'json',
   			contentType: "application/json; charset=utf-8",
   		}).done(function(resposeJson) {
   			$('#search-result').datagrid('loadData', resposeJson);
   		});
   		
   		var startDateSplit = startDate.split('-');
   		var endDateSplit = endDate.split('-');
   		if(startDateSplit.length == endDateSplit.length){
   			for(i = 0 ; i < startDateSplit.length ; i++){
   				var a = parseInt(startDateSplit[i]);
   				var b = parseInt(endDateSplit[i]);
   				if(a > b){
   					alert("기간을 확인해주세요.");
   					return;
   				}else if(b > a){
   					break;
   				}
   			}
   		}
   		
   		if(type == 1){
   			$('#search-result').datagrid('showColumn','startEvent');
   			$('#search-result').datagrid('showColumn','endEvent');
   			$('#search-result').datagrid('hideColumn','sosEvent');
   			$('#search-result').datagrid('hideColumn','instDe');
   			$('#search-result').datagrid('hideColumn','deviceType');
   		} else if(type == 2){
   			$('#search-result').datagrid('showColumn','startEvent');
   			$('#search-result').datagrid('showColumn','endEvent');
   			$('#search-result').datagrid('showColumn','sosEvent');
   			$('#search-result').datagrid('hideColumn','instDe');
   			$('#search-result').datagrid('hideColumn','deviceType');
   		}else{
   			$('#search-result').datagrid('hideColumn','startEvent');
   			$('#search-result').datagrid('hideColumn','endEvent');
   			$('#search-result').datagrid('hideColumn','sosEvent');
   			$('#search-result').datagrid('showColumn','instDe');
   			$('#search-result').datagrid('showColumn','deviceType');
   		}
   		
   		var style = danu.main.Options.style;
   		if (style.lookAndFeel === "custom" && style.lookAndFeelName === "blackberry") {
   			$("#searchPop").removeClass("l-btn").addClass("l_btn_black");
   			$(".button_list").removeClass("button_list").addClass("button_list_sel");
   		}
   		
   		$('#search-result-wrapper').dialog('open');
	}
}

danu.member.Result = {
		dialog: "#search-result-wrapper",
		searchPopButton: "#searchPop",
		searchPopCloseButton: "#search-result-close",
		init : function() {
			
		},
		setEvents: function() {
			var _this = this;
			$(this.dialog).window({onBeforeClose: function() {
				_this.close();
			}});
			$(this.searchPopButton).on("click", function() {
				_this.searchPop();
			});
			$(this.searchPopCloseButton).on("click", function() {
				$('#search-result-wrapper').dialog('close');
				_this.close();
			});
		},
		close : function() {
			$('#searchNm').val('');
			$(".button_list_sel").removeClass("button_list_sel").addClass("button_list");
		},
		searchPop : function() {
			var type = parseInt($(':radio[name="search"]:checked').val());
			var city = $('#city').combobox('getValue');
			var sig = $('#sig').combobox('getText');
			var gu = $('#gu').combobox('getValue');
			var emd = $('#emd').combobox('getValue');
	   		var startDate = $('#search-start-time').combobox('getText');
	   		var endDate = $('#search-end-time').combobox('getText');
	   		var nm  = $('#searchNm').val();
	   		
	   		var data = new Object();
	   		data.type = type;
	   		data.strCityNo = city;				//도
	   		if(sig!="전체") data.sigungu = sig;	//시군구
	   		data.strGuNo = gu;					//구
	   		data.strEmdNo = emd;				//읍면동
	   		data.strInstDe = startDate;
	   		data.strUpdDe = endDate;
	   		data.strNm = nm;
	   		
	   		$.ajax({
	   			method : 'GET',
	   			data : data,
	   			url : 'danu/com/platform/selectMembersList.do',
	   			dataType : 'json',
	   			contentType: "application/json; charset=utf-8",
	   		}).done(function(resposeJson) {
	   			$('#search-result').datagrid('loadData', resposeJson);
	   		});
		}
}*/