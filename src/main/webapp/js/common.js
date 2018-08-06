
const common = {
	/*********************************************************
	 * JQUERY DATEPICKER INIT
	 *********************************************************/
	datePickerInit : function()
	{
		$.datepicker.setDefaults({
			inline: true,
			dateFormat: "yy-mm-dd",    	/* 날짜 포맷 */
			prevText: 'prev',
			nextText: 'next',
			showButtonPanel: true,    	/* 버튼 패널 사용 */
			changeMonth: true,        	/* 월 선택박스 사용 */
			changeYear: true,			/* 년 선택박스 사용 */
			showOtherMonths: true,    	/* 이전/다음 달 일수 보이기 */
			selectOtherMonths: true,    /* 이전/다음 달 일 선택하기 */
			//showOn: "button",
			//buttonImage: "/common/Images/common/btn_calendar.gif",
			//buttonImageOnly: true,
			minDate: '-30y',
			closeText: '닫기',
			currentText: '오늘',
			showMonthAfterYear: true,	/* 년과 달의 위치 바꾸기 */
			/* 한글화 */
			monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
			monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
			dayNames: ['일', '월', '화', '수', '목', '금', '토'],
			dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
			dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
			showAnim: 'slideDown',
		});

		$.datepicker._gotoToday = function(id)
		{
			$(id).datepicker('setDate', new Date()).datepicker('hide').blur();
		};
	},
	/*********************************************************
	 * 레이어 팝업 OPEN
	 *********************************************************/
	openDialogPop : function(id, title, width, height, iframe, url, param, dialogId, callBackFunc)
	{
		const dynamicDialog = (typeof dialogId != "undefined" ? dialogId : "subCommonDialog");
		const parameter = (typeof param != "undefined" ? param : "");

		if(iframe)
		{
			$("#" + dynamicDialog).remove();
			$("body").append('<div id="' + dynamicDialog + '" />');
			$("#" + dynamicDialog).load(url, parameter).dialog(
			{
				title: title,
				width: width,
				height: height,
				modal: true,
				draggable: false,
				resizable: false,
				closeOnEscape: false,
				open: function() {

				},
				close: function()
				{
					$(this).remove();
				}
			});
		}
		else
		{
			const dialogContainer = $("#" + id);
			const detachedChildren = dialogContainer.children().detach();

			dialogContainer.dialog(
			{
				title: title,
				width: width,
				height: height,
				modal: true,
				draggable: false,
				resizable: false,
				closeOnEscape: false,
				open: function ()
				{
					dialogContainer.empty();
					detachedChildren.appendTo(dialogContainer);
				},
				close: function()
				{
					$(this).remove();
				},
			});
		}

		if(typeof callBackFunc != "undefined")
		{
			$.fn.openDialogCallBack = eval(callBackFunc);
		}
	},
	/*********************************************************
	 * 레이어 팝업 OPEN TOP POSITION
	 *********************************************************/
	openDialogPopPosition : function(id, title, width, height, iframe, url, param, dialogId, callBackFunc)
	{
		const dynamicDialog = (typeof dialogId != "undefined" ? dialogId : "subCommonDialog");
		const parameter = (typeof param != "undefined" ? param : "");

		if(iframe)
		{
			$("#" + dynamicDialog).remove();
			$("body").append('<div id="' + dynamicDialog + '" />');
			$("#" + dynamicDialog).load(url, parameter).dialog(
			{
				title: title,
				width: width,
				height: height,
				modal: true,
				draggable: false,
				resizable: false,
				closeOnEscape: false,
				open: function()
				{

				},
				close: function()
				{
					$(this).remove();
				},
				position:
				{
					my : 'center top+50',
					at : 'center top',
				}
			});
		}
		else
		{
			const dialogContainer = $("#" + id);
			const detachedChildren = dialogContainer.children().detach();

			dialogContainer.dialog(
			{
				title: title,
				width: width,
				height: height,
				modal: true,
				draggable: false,
				resizable: false,
				closeOnEscape: false,
				open: function ()
				{
					dialogContainer.empty();
					detachedChildren.appendTo(dialogContainer);
				},
				close: function()
				{
					$(this).remove();
				},
			});
		}

		if(typeof callBackFunc != "undefined")
		{
			$.fn.openDialogCallBack = eval(callBackFunc);
		}
	},
	/*********************************************************
	 * 레이어 팝업 CLOSE
	 *********************************************************/
	closeDialogPop : function(id, callBackFunc)
	{
		if(typeof id != "undefined")
		{
			const el = id.split(",");
			$.each(el, function(index) {
				$("#" + $.trim(el[index])).dialog("destroy").remove();
				//$("#" + $.trim(el[index])).parent().find("div").find(".ui-dialog-titlebar-close").click();
			});
		}
		else
		{
			$(".ui-dialog-content:visible").dialog("destroy").remove();
		}

		if(typeof callBackFunc != "undefined")
		{
			$.each(callBackFunc, function(index) {
				eval(callBackFunc[index]());
			});
		}
	},
	/*********************************************************
	 * 오늘 날짜 YYYY-MM-DD 얻기
	 *********************************************************/
	getTodayDate : function(calc, Days)
	{
		let date = new Date();
		if(typeof calc != "undefined" && typeof Days != "undefined")
		{
			if(+(calc) > 0)
			{
				date.setDate(date.getDate() + +(Days));
			}
			else
			{
				date.setDate(date.getDate() - +(Days));
			}
		}
		
		const year  = date.getFullYear();
		const month = (date.getMonth() + 1 < 10 ? "0".concat(date.getMonth() + 1) : date.getMonth() + 1);
		const day   = (date.getDate() < 10 ? "0".concat(date.getDate()) : date.getDate());
		return year + "-" + month + "-" + day;
	},
	/*********************************************************
	 * 한달후 날짜 YYYY-MM-DD 얻기
	 *********************************************************/
	getEndMonthDate : function()
	{
		const date = new Date();
		const year  = date.getFullYear();
		const month = (date.getMonth() + 2 < 10 ? "0".concat(date.getMonth() + 2) : date.getMonth() + 2);
		const day   = (date.getDate() < 10 ? "0".concat(date.getDate()) : date.getDate());
		return year + "-" + month + "-" + day;
	},
	/*********************************************************
	 * 한달전 날짜 YYYY-MM-DD 얻기
	 *********************************************************/
	getLastMonthDate : function()
	{
		const date = new Date();
		const year  = date.getFullYear();
		const month = (date.getMonth() < 10 ? "0".concat(date.getMonth()) : date.getMonth());
		const day   = (date.getDate() < 10 ? "0".concat(date.getDate()) : date.getDate());
		return year + "-" + month + "-" + day;
	},
	/*********************************************************
	 * 현재 세션 체크
	 *********************************************************/
	sessionChecked : function()
	{
		const jsonObj = {};
		let isSession = false;

		jsonObj.userId = SESSION_INFO.userId;

		$.ajax(
		{
			type       : "POST",
			url        : CONTEXT.path + "/baseSessionCheck/action.do",
			dataType   : "json",
			data       : {"param" : JSON.stringify(jsonObj)},
			async      : false,
			beforeSend : function(xhr) {
				// 전송 전 Code
			}
		}).done(function(result) {
			isSession = result;
		}).fail(function(xhr) {

		}).always(function() {

		});
		return isSession;
	},
	/*********************************************************
	 * XSS ENCODE
	 *********************************************************/
	xssEncode : function(str)
	{
		let returnStr = "";
		if(typeof str != "undefined")
		{
			returnStr = str;
			returnStr = returnStr.replace("&", "&amp;");
			returnStr = returnStr.replace(">", "gt;");
			returnStr = returnStr.replace("<", "lt;");
			returnStr = returnStr.replace("(", "#40;");
			returnStr = returnStr.replace(")", "#41;");
		}
		return returnStr;
	},
	/*********************************************************
	 * XSS DECODE
	 *********************************************************/
	xssDecode : function(str)
	{
		let returnStr = "";
		if(typeof str != "undefined")
		{
			returnStr = str;
			returnStr = returnStr.replace("&gt;", ">");
			returnStr = returnStr.replace("&lt;", "<");
			returnStr = returnStr.replace("&#40;", "(");
			returnStr = returnStr.replace("&#41;", ")");
			returnStr = returnStr.replace("&#39;", "'");
		}
		return returnStr;
	},
	/* SELECT BOX ITEM CREATE
	** param : el, param, val, text, isDefault, callBackFunc
	 */
	getSelectBoxItem : function(param)
	{
		$("#" + param["el"]).empty();

		if(typeof param["isAll"] != "undefined")
		{
			$("#" + param["el"]).append($("<option></option>").val("").html("전체"));
		}

		if(typeof param["check"] != "undefined")
		{
			$("#" + param["el"]).append($("<option data-hidden='true'></option>").val("").html("선택"));
		}

		if(typeof param["isAllCheck"] != "undefined")
		{
			$("#" + param["el"]).append($("<option class='isAllCheck'></option>").val("").html("전체"));
		}
		
		const jsonObj = {};

		$.each(param, function(key, value) {
			jsonObj[key] = value;
		});

		$.ajax(
		{
			type      : "POST",
			url       : CONTEXT.path + "/select/" + param["sql"] + "/action.do",
			dataType  : "json",
			data      : {"param": JSON.stringify(jsonObj)},
			async     : false,
			beforeSend: function (xhr) {
				// 전송 전 Code
			},
		}).done(function (result) {
			if (result.length > 0)
			{
				$.each(result, function (index) {
					$("#" + param["el"]).append($("<option></option>").val(this[param["val"]]).html(this[param["text"]]));
				});
			}
	 	}).fail(function (xhr) {
			//console.log(xhr);
		}).always(function() {
			if(typeof param["callBackFunc"] != "undefined")
			{
				$.each(param["callBackFunc"], function(key, value) {
					eval(value);
				});
			}
		});
	},
	getEditorContent : function(settingType)
	{
		const returnObj = {};
		const jsonObj = {};
		jsonObj.settingType = settingType;

		$.ajax(
		{
			type      : "POST",
			url       : CONTEXT.path + "/select/Common.getSettingContent/action.do",
			dataType  : "json",
			data      : {"param": JSON.stringify(jsonObj)},
			async     : false,
			beforeSend: function(xhr)
			{
				// 전송 전 Code
			}
		}).done(function(result) {
			returnObj.noticeContent = result[0].noticeContent;
			returnObj.agreeContent = result[0].agreeContent;
		}).fail(function(xhr) {

		}).always(function() {

		});

		return returnObj;
	},
	setCKEditorDisable : function(id, isDisable)
	{
		if(isDisable)
		{
			$("#cke_" + id + "> span.cke_inner > span.cke_top > span.cke_toolbox > span.cke_toolbar").each(function(index) {
				$(this).children("span.cke_toolgroup").children("a")
				.attr("class", "cke_button cke_button__bold cke_button_disabled")
				.attr("aria-disabled", true);
			});

			$("#cke_" + id).find("iframe").contents().find("body")
			.addClass("disable-bg-gray")
			.attr("disabled", "disabled");
		}
		else
		{
			$("#cke_" + id + "> span.cke_inner > span.cke_top > span.cke_toolbox > span.cke_toolbar").each(function(index) {
				$(this).children("span.cke_toolgroup").children("a")
				.attr("class", "cke_button cke_button__bold cke_button_off")
				.removeAttr("aria-disabled");
			});

			$("#cke_" + id).find("iframe").contents().find("body")
			.removeClass("disable-bg-gray")
			.removeAttr("disabled");
		}
	},
	fileUpload : function(file)
	{
		let isSuccess = false;
		var reFile = '';
		if(!(!file))
		{
			const dataForm = new FormData();
			dataForm.append("upFile", file);

			$.ajax(
			{
				type: "POST",
				url: "/file/upload3.do",
				dataType: "json",
				data: dataForm,
				contentType: false,
				processData: false,
				async: false,
				beforeSend: function (xhr) {
					// 전송 전 Code
				}
			}).done(function (result)
			{
				if (result.resultCode === "1")
				{
					reFile = result.resultFile;
					isSuccess = true;
				}

			}).fail(function (xhr) {

			}).always(function () {

			});
		}

		return reFile;
	},
	fileDownLoad : function (fileName, isDelete) {

		var jsonObj = {};
		jsonObj.fileName = fileName;
		jsonObj.isDelete = (typeof isDelete != "undefined" ? true : false);
	
		$.fileDownload("/file/download.do", {
			httpMethod: "POST",
			data: {"param" : JSON.stringify(jsonObj)},
			prepareCallback: function() {
				//showProgress();
			},
			abortCallback: function() {
				//console.log("abortCallBack");
			},
			successCallback: function(url) {
				//$("#progress").hide();
				//console.log("successCallBack");
			},
			fail: function(responseHtml, url, error) {
				//$("#progress").hide();
				alert("파일다운로드 실패\n관리자에게 문의하세요.");
			}
		});
		/*.done(function () {
		 console.log("done");
		 })
		 .fail(function () {
		 console.log("fail");
		 });*/

		return false;
	},
	fileExtensionCheck : function(fileName)
	{
		let result = true;
		if(fileName.match(/\.xls/gi) == null)
		{
			alert("엑셀 파일만 선택하여 주십시오.");
			result = false;
		}
		return result;
	},
	fileSizeCheck : function(size)
	{
		let result = true;
		const maxSize = 1048576; /* 1MB */
		const fileSize = Math.round(size);

		if(maxSize < fileSize)
		{
			alert("1 MB(1048576 BYTE)를 초과하는 파일은 엑셀 파일 업로드할 수 없습니다.");
			result = false;
		}
		return result;
	},
	cleanHtml : function(id)
	{
		if(typeof id != "undefined")
		{
			const el = id.split(",");
			$.each(el, function(index) {
				$("#" + $.trim(el[index])).val("").text("").html("");
			});
		}
	},
	getOsInfo : function() {
		const osNo = navigator.userAgent.toLowerCase();
		$.os =
		{
			Linux: /linux/.test(osNo),
			Unix: /x11/.test(osNo),
			Mac: /mac/.test(osNo),
			Windows: /win/.test(osNo)
		};

		const uanaVigatorOs = navigator.userAgent;
		const AgentUserOs= uanaVigatorOs.replace(/ /g,'');
		let OSName;
		let OsVers;

		if($.os.Windows)
		{
			if(AgentUserOs.indexOf("WindowsCE") != -1)
			{
				OSName="Windows CE";
			}
			else if(AgentUserOs.indexOf("Windows95") != -1)
			{
				OSName="Windows 95";
			}
			else if(AgentUserOs.indexOf("Windows98") != -1)
			{
				if (AgentUserOs.indexOf("Win9x4.90") != -1)
				{
					OSName="Windows Millennium Edition (Windows Me)"
				}
				else
				{
					OSName="Windows 98";
				}
			}
			else if(AgentUserOs.indexOf("WindowsNT4.0") != -1)
			{
				OSName="Microsoft Windows NT 4.0";
			}
			else if(AgentUserOs.indexOf("WindowsNT5.0") != -1)
			{
				OSName="Windows 2000";
			}
			else if(AgentUserOs.indexOf("WindowsNT5.01") != -1)
			{
				OSName="Windows 2000, Service Pack 1 (SP1)";
			}
			else if(AgentUserOs.indexOf("WindowsNT5.1") != -1)
			{
				OSName="Windows XP";
			}
			else if(AgentUserOs.indexOf("WindowsNT5.2") != -1)
			{
				OSName="Windows 2003";
			}
			else if(AgentUserOs.indexOf("WindowsNT6.0") != -1)
			{
				OSName="Windows Vista/Server 2008";
			}
			else if(AgentUserOs.indexOf("WindowsNT6.1") != -1)
			{
				OSName="Windows 7";
			}
			else if(AgentUserOs.indexOf("WindowsNT6.2") != -1)
			{
				OSName="Windows 8";
			}
			else if(AgentUserOs.indexOf("WindowsNT6.3") != -1)
			{
				OSName="Windows 8.1";
			}
			else if(AgentUserOs.indexOf("WindowsPhone8.0") != -1)
			{
				OSName="Windows Phone 8.0";
			}
			else if(AgentUserOs.indexOf("WindowsPhoneOS7.5") != -1)
			{
				OSName="Windows Phone OS 7.5";
			}
			else if(AgentUserOs.indexOf("Xbox") != -1)
			{
				OSName="Xbox 360";
			}
			else if(AgentUserOs.indexOf("XboxOne") != -1)
			{
				OSName="Xbox One";
			}
			else if(AgentUserOs.indexOf("Win16") != -1)
			{
				OSName="Windows 3.x";
			}
			else if(AgentUserOs.indexOf("ARM") != -1)
			{
				OSName="Windows RT";
			}
			else
			{
				OSName="Windows (Unknown)";
			}

			if(AgentUserOs.indexOf("WOW64") != -1)
			{
				OsVers=" 64-bit(s/w 32-bit)";
			}
			else if(AgentUserOs.indexOf("Win64;x64;") != -1)
			{
				OsVers=" 64-bit(s/w 64-bit)";
			}
			else if(AgentUserOs.indexOf("Win16") != -1)
			{
				OsVers=" 16-bit";
			}
			else
			{
				OsVers=" 32-bit";
			}
		}
		else if ($.os.Linux)
		{
			if(AgentUserOs.indexOf("Android") != -1)
			{
				OSName = function() {
					const uaAdata = navigator.userAgent;
					const regex = /Android (.*);.*;\s*(.*)\sBuild/;
					const match = regex.exec(uaAdata);
					if(match)
					{
						const ver = match[1];
						const dev_name = match[2];
						return "Android " + ver + " " + dev_name;
					}

					return "Android OS";
				}();
			}
			else if(AgentUserOs.indexOf("BlackBerry9000") != -1)
			{
				OSName="BlackBerry9000";
			}
			else if(AgentUserOs.indexOf("BlackBerry9300") != -1)
			{
				OSName="BlackBerry9300";
			}
			else if(AgentUserOs.indexOf("BlackBerry9700") != -1)
			{
				OSName="BlackBerry9700";
			}
			else if(AgentUserOs.indexOf("BlackBerry9780") != -1)
			{
				OSName="BlackBerry9780";
			}
			else if(AgentUserOs.indexOf("BlackBerry9900") != -1)
			{
				OSName="BlackBerry9900";
			}
			else if(AgentUserOs.indexOf("BlackBerry;Opera Mini") != -1)
			{
				OSName="Opera/9.80";
			}
			else if(AgentUserOs.indexOf("Symbian/3") != -1)
			{
				OSName="Symbian OS3";
			}
			else if(AgentUserOs.indexOf("SymbianOS/6") != -1)
			{
				OSName="Symbian OS6";
			}
			else if(AgentUserOs.indexOf("SymbianOS/9") != -1)
			{
				OSName="Symbian OS9";
			}
			else if(AgentUserOs.indexOf("Ubuntu") != -1)
			{
				OSName="Ubuntu";
			}
			else if(AgentUserOs.indexOf("PDA") != -1)
			{
				OSName="PDA";
			}
			else if(AgentUserOs.indexOf("NintendoWii") != -1)
			{
				OSName="Nintendo Wii";
			}
			else if(AgentUserOs.indexOf("PSP") != -1)
			{
				OSName="PlayStation Portable";
			}
			else if(AgentUserOs.indexOf("PS2;") != -1)
			{
				OSName="PlayStation 2";
			}
			else if(AgentUserOs.indexOf("PLAYSTATION3") != -1)
			{
				OSName="PlayStation 3";
			}
			else OSName="Linux (Unknown)";

			if(AgentUserOs.indexOf("x86_64") != -1)
			{
				OsVers=" 64-bit";
			}
			else if(AgentUserOs.indexOf("i386") != -1)
			{
				OsVers=" 32-bit";
			}
			else if(AgentUserOs.indexOf("IA-32") != -1)
			{
				OsVers=" 32-bit";
			}
			else OsVers="";
		}
		else if ($.os.Unix)
		{
			OSName="UNIX";
		}
		else if ($.os.Mac)
		{
			if(AgentUserOs.indexOf("iPhone") != -1)
			{
				if(AgentUserOs.indexOf("iPhoneOS3") != -1)
				{
					OSName="iPhone OS 3";
				}
				else if(AgentUserOs.indexOf("iPhoneOS4") != -1)
				{
					OSName="iPhone OS 4";
				}
				else if(AgentUserOs.indexOf("iPhoneOS5") != -1)
				{
					OSName="iPhone OS 5";
				}
				else if(AgentUserOs.indexOf("iPhoneOS6") != -1)
				{
					OSName="iPhone OS 6";
				}
				else OSName="iPhone";
			}
			else if(AgentUserOs.indexOf("iPad") != -1)
			{
				OSName="iPad";
			}
			else if(AgentUserOs.indexOf("MacOS") != -1)
			{
				if(AgentUserOs.indexOf("Macintosh") != -1)
				{
					OSName="Macintosh";
				}
				else if((AgentUserOs.indexOf("MacOSX10_9")||AgentUserOs.indexOf("MacOSX10.1")) != -1)
				{
					OSName="Mac OS X Puma";
				}
				else if((AgentUserOs.indexOf("MacOSX10_9")||AgentUserOs.indexOf("MacOSX10.2")) != -1)
				{
					OSName="Mac OS X Jaguar";
				}
				else if((AgentUserOs.indexOf("MacOSX10_9")||AgentUserOs.indexOf("MacOSX10.3")) != -1)
				{
					OSName="Mac OS X Panther";
				}
				else if((AgentUserOs.indexOf("MacOSX10_9")||AgentUserOs.indexOf("MacOSX10.4")) != -1)
				{
					OSName="Mac OS X Tiger";
				}
				else if((AgentUserOs.indexOf("MacOSX10_9")||AgentUserOs.indexOf("MacOSX10.5")) != -1)
				{
					OSName="Mac OS X Leopard";
				}
				else if((AgentUserOs.indexOf("MacOSX10_9")||AgentUserOs.indexOf("MacOSX10.6")) != -1)
				{
					OSName="Mac OS X Snow Leopard";
				}
				else if((AgentUserOs.indexOf("MacOSX10_9")||AgentUserOs.indexOf("MacOSX10.7")) != -1)
				{
					OSName="Mac OS X Lion";
				}
				else if((AgentUserOs.indexOf("MacOSX10_9")||AgentUserOs.indexOf("MacOSX10.8")) != -1)
				{
					OSName="Mac OS X Mountain Lion";
				}
				else if((AgentUserOs.indexOf("MacOSX10_9")||AgentUserOs.indexOf("MacOSX10.9")) != -1)
				{
					OSName="Mac OS X Mavericks";
				}
			}
			else
			{
				OSName="MacOS (Unknown)";
			}
		}
		else
		{
			OSName="Unknown OS";
		}
		const OSDev = OSName + OsVers;
		return OSDev;
	},
	getUserBrowser : function()
	{
		const agt = navigator.userAgent.toLowerCase();

		return agt;

        // if (agt.indexOf("chrome") != -1)
		// {
			// return 'Chrome';
		// }
        // if (agt.indexOf("opera") != -1)
		// {
			// return 'Opera';
		// }
        // if (agt.indexOf("staroffice") != -1)
		// {
			// return 'Star Office';
		// }
        // if (agt.indexOf("webtv") != -1)
		// {
			// return 'WebTV';
		// }
        // if (agt.indexOf("beonex") != -1)
		// {
			// return 'Beonex';
		// }
        // if (agt.indexOf("chimera") != -1)
		// {
			// return 'Chimera';
		// }
        // if (agt.indexOf("netpositive") != -1)
		// {
			// return 'NetPositive';
		// }
        // if (agt.indexOf("phoenix") != -1)
		// {
			// return 'Phoenix';
		// }
        // if (agt.indexOf("firefox") != -1)
		// {
			// return 'Firefox';
		// }
        // if (agt.indexOf("safari") != -1)
		// {
			// return 'Safari';
		// }
        // if (agt.indexOf("skipstone") != -1) return 'SkipStone';
        // if (agt.indexOf("netscape") != -1) return 'Netscape';
        // if (agt.indexOf("msie") != -1) {}
        // if (agt.indexOf("mozilla/5.0") != -1) return 'Mozilla';
	},
	writeConnectLog : function(connType)
	{
		const jsonObj = {};
		jsonObj.connType = connType;
		jsonObj.userId = SESSION_INFO.userId;
		jsonObj.connUserBrowser = common.get
		$.ajax(
		{
			type: "POST",
			url: "/writeConnectLog.do",
			dataType: "json",
			data      : {"param": JSON.stringify(jsonObj)},
			contentType: false,
			processData: false,
			async: false,
			beforeSend: function (xhr) {
				// 전송 전 Code
			}
		}).done(function (result)
		{
			if (result.resultCode === "1")
			{
				isSuccess = true;
			}
		}).fail(function (xhr) {

		}).always(function () {

		});
	},
	gridRowSelectedIsValid : function(gridId)
	{
		const grid = $("#" + gridId).data("kendoGrid");
		const ds = $.map(grid.select(), function (item) { return grid.dataItem(item); });
		let rtnValid = false;

		if(ds.length < 1)
		{
			rtnValid = true;
		}
		else
		{
			$.each(ds, function (index) {
				if(typeof ds[index].rowNum === "undefined")
				{
					rtnValid = true;
				}
			});
		}
		return rtnValid;
	},
	gridExportIsValid: function(gridId)
	{
		const grid = $("#" + gridId).data("kendoGrid");
		let rtnValid = true;
		$.each(grid.dataSource.data(), function (index) {
			if(typeof grid.dataSource.data()[index].rowNum != "undefined")
			{
				rtnValid = false;
			}
		});
		return rtnValid;
	},
	getIsNullJsonVal : function(obj, key, nullValue)
	{
		const isNullVal = (typeof nullValue != "undefined" ? nullValue : "");
		const rtnVal = (typeof obj[$.trim(key)] != "undefined" ? obj[$.trim(key)] : isNullVal);
		return rtnVal;
	},
	openWindow : function(url, width, height)
	{
		var openWin = null;
        //alert("현재 시스템 점검중입니다.\n2016-05-22(일) 20시 이후에 사용하세요.");
        //return;

        var sWidth, sHeight, sTop, sLeft, sEtc;


        //2014-02-20 난수 처리 추가
        var temp = Math.floor((Math.floor(Math.random()*90000000) + 10000000));
        var windowName = temp;

        sWidth = width;
        sHeight = height;

        sTop = (window.screen.height - sHeight)/2;
        sLeft = (window.screen.width - sWidth)/2;
        etcParam = "toolbar=0,location=0,directories=0,status=1,menubar=0,scrollbars=1,resizable=1";
        sEtc = etcParam + ",width=" + sWidth + ",height=" + sHeight + ",top=" + sTop + ",left=" + sLeft;

        //2014-02-20 이미 열린 새창이 존재하면 Close 처리
        if(openWin)
        {
	  		openWin.close();
        }
        openWin = window.open(url,windowName,sEtc);
        openWin.focus();
	},
	comma : function (str) {
		str = String(str);
		return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');

	},
	uncomma : function (str) {
		str = String(str);
		return str.replace(/[^\d]+/g, '');
	},
	inputNumberFormat : function (obj) {
		obj.value = comma(uncomma(obj.value));
	}
}

/*************************************************
 추후 필요 시 추가
 *************************************************/
function autoComplete(id, sql)
{
	$("#" + id).autocomplete({
		source: function(request, response) {

			var jsonObj = {};

			jsonObj.searchWord = request.term;
			//jsonObj.

			$.ajax(
				{
					type       : "POST",
					url        : "${pageContext.request.contextPath}/select/" + sql + "/action.do",
					dataType   : "json",
					data       : {"param" : JSON.stringify(jsonObj)},
					async      : false,
					beforeSend : function(xhr) {
						// 전송 전 Code
					},
					success		: function(result) {
						response(
							$.map(result, function(indexData){
								return {
									label: indexData.NHGroupName,
									value: indexData.NHGroupNo
								};
							})
						);
					},
					error      : function(xhr) {

					}
				});
		},
		select: function (event, ui) {
			event.preventDefault();
			$("#" + id).val(ui.item.label);
			/*$("#" + id).attr("data-")
			 $("#" + hidid).val(ui.item.value);*/
		}
	});
}

function selectBoxInitDataSource(id, CodeCat1, CodeCat2, callBackFunc, isDefault)
{
	$("#" + id).empty();

	if(typeof isDefault != "undefined")
	{
		$("#" + id).append($("<option></option>").val("").html("전체"));
	}

	$.ajax({
		type 		: "POST",
		dataType	: "json",
		url 		: "/ajax/KendoUI/selectDataSourceList.do",
		data		: {
			sqlmapid 	: "common.selectComCodeInfo",
			CodeCat1	: CodeCat1,
			CodeCat2	: CodeCat2
		},
		success		: function(result) {

			if(result.dataset.recordSet.length > 0)
			{
				$.each(result.dataset.recordSet, function (indexData) {
					$("#" + id).append($("<option></option>").val(this.ComCode).html(this.KORName));
				});
				//$("#" + id).trigger("change");
			}
		},
		complete	: function() {
			if(typeof callBackFunc != "undefined")
			{
				$.each(callBackFunc, function(index) {
					eval(callBackFunc[index]());
				});
			}
		}
	});
}

function validTextBox(id)
{
	var isValid = true;
	if(id.split(",").length > 1)
	{
		var el = "";

		$.each(id.split(","), function(index) {

			el += "#" + $.trim(this);

			if(index != id.split(",").length - 1)
			{
				el += ",";
			}
		});

		$(el).each(function () {
			if ($.trim($(this).val()) == "") {
				isValid = false;
				$(this).css({
					"border": "1px solid red",
					"background": "#FFCECE"
				});
			}
			else {
				$(this).css({
					"border": "",
					"background": ""
				});
			}
		});
	}
	else
	{
		$("#" + id).each(function () {
			if ($.trim($(this).val()) == "") {
				isValid = false;
				$(this).css({
					"border": "1px solid red",
					"background": "#FFCECE"
				});
			}
			else {
				$(this).css({
					"border": "",
					"background": ""
				});
			}
		});
	}
	return isValid;
}

function validateNumber(id)
{
	var isValid = true;
	var regex = /^[1-9]{0,3}$/;

	if(!regex.test($("#" + id).val()) || $.trim($("#" + id).val()).length < 1)
	{
		isValid = false;
		$("#" + id).css({
			"border": "1px solid red",
			"background": "#FFCECE"
		});
	}
	else
	{
		$("#" + id).css({
			"border": "",
			"background": ""
		});

	}

	return isValid;
}

function validateHour(id)
{
	var isValid = true;
	var regex = /^(0?[1-9]|1[0-2])?$/;

	if(!regex.test($("#" + id).val()) || $.trim($("#" + id).val()).length < 1)
	{
		isValid = false;
		$("#" + id).css({
			"border": "1px solid red",
			"background": "#FFCECE"
		});
	}
	else
	{
		$("#" + id).css({
			"border": "",
			"background": ""
		});

	}

	return isValid;
}

function validateMinute(id)
{
	var isValid = true;
	var regex = /^([0-5]?[0-9])?$/;

	if(!regex.test($("#" + id).val()) || $.trim($("#" + id).val()).length < 1)
	{
		isValid = false;
		$("#" + id).css({
			"border": "1px solid red",
			"background": "#FFCECE"
		});
	}
	else
	{
		$("#" + id).css({
			"border": "",
			"background": ""
		});

	}

	return isValid;
}




function ftpDownLoad(filePath, fileName) {

	var jsonObj = {};

	jsonObj.filePath = filePath;
	jsonObj.fileName = fileName;

	$.fileDownload("/file/ftpDownload.do", {
		httpMethod: "POST",
		data: {"param" : JSON.stringify(jsonObj)},
		prepareCallback: function() {
			showProgress();
		},
		abortCallback: function() {
			//console.log("abortCallBack");
		},
		successCallback: function(url) {
			$("#progress").hide();
			//console.log("successCallBack");
		},
		fail: function(responseHtml, url, error) {
			$("#progress").hide();
			alert("파일다운로드 실패\n관리자에게 문의하세요.");
		}
	});
	/*.done(function () {
	 console.log("done");
	 })
	 .fail(function () {
	 console.log("fail");
	 });*/

	return false;
}


function showProgress() {
	if($("body > iframe").length)
	{
		$("body > iframe").remove();
	}
	$("#progress > div").html('<img src="/resources/img/circle_progress.gif"  alt="progress"/>');
	$("#progress").css("display", "table");
}



