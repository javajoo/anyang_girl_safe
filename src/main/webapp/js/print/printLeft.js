//**********************************************//
//***************이진석 입력 시작****************//

// 컬러테이블 페이지 열기
function OpenColorTable(cType)
{
	srcType = cType;
	if (srcType == "t")
	{				
		openLayer("tColorTable");
	}
	else if (srcType == "c")
	{
		openLayer("cColorTable");
	}
	else if (srcType == "p")
	{
		openLayer("pColorTable");
	}
}

// 편지쓰기 - 편집툴 보여주기 / 얼
var openingLayer=0;
var t_height,t_width;

function openLayer(layerName) {
	if(!openingLayer){
		closeLayers();
		var sv = document.getElementById(layerName).style;
		
		t_height = parseInt(sv.height);
		t_width = parseInt(sv.width);
		
		sv.height=10;
		sv.width=10;
		
		openingLayer=1;
		sv.display = 'inline';
		
		movingLayer(layerName);
	}
}

function movingLayer(layerName) {
	var steps=2.5;
	var sv = document.getElementById(layerName).style;
	
	tmpx = parseInt(sv.height);
	tmpy = parseInt(sv.width);
	
	if(t_height - tmpx > 1){
		sv.height = tmpx+(t_height-tmpx)/steps+1;
		sv.width = tmpy+(t_width-tmpy)/steps+1;
		window.setTimeout("movingLayer('"+layerName+"')",30);
	}else{
		sv.height = t_height;
		sv.width = t_width;
		openingLayer=0;
	}
}

function closeLayers(){
	if (srcType == "t")
	{				
		//tColorTable.style.display='none';
		$('#tColorTable').hide();
	}
	else if (srcType == "c")
	{
		//cColorTable.style.display='none';
		$('#cColorTable').hide();
	}
	else if (srcType == "p")
	{
		//pColorTable.style.display='none';
		$('#pColorTable').hide();
	}
}

var tColor = "#000000";
var cColor = "#000000";
var pColor = "#000000";

var srcType = "";
//폰트컬러 바꾸기
function ChangeFontColor(color)
{
	if (srcType == "t")
	{				
		tColor = color;
		//document.all.txtTColor.style.color = tColor;
		//document.all.txtTColor.style.borderColor = "#000000";
		$('#txtTColor').css('color',tColor);
		$('#txtTColor').css('border-color',"#000000");
		tColorTable.style.display='none';
	}
	else if (srcType == "c")
	{
		cColor = color;
		//document.all.txtCColor.style.color = cColor;
		//document.all.txtCColor.style.borderColor = "#000000";
		$('#txtCColor').css('color',cColor);
		$('#txtCColor').css('border-color',"#000000");
		cColorTable.style.display='none';
	}
	else if (srcType == "p")
	{
		pColor = color;
		//document.all.txtPColor.style.color = pColor;
		//document.all.txtPColor.style.borderColor = "#000000";
		$('#txtPColor').css('color',pColor);
		$('#txtPColor').css('border-color',"#000000");
		pColorTable.style.display='none';
	}
}


//******************이진석 입력******************//
//**********************************************//
function OnChangePrintSizse()
{
	var idx = document.all.ptype.selectedIndex;
	var newptype = document.all.ptype.options[idx].value;
	if (newptype != ptype){
		document.printMain.ChangeMapSize(newptype);
	}
}

// 제목,내용과 관련된 폰트설정 적용
function onUpdate()
{
	var strTitle = "";			// 제목글
	var strPosition = "";		// 위치글
	var strContent = "";		// 내용글
	
	try{
		// 제목글 특수문자들을 알맞은 HTML 예약어로 바꾼다.
		strTitle 	= $('#title').val().replace(/</gi, "&lt;");
		strTitle 	= strTitle.replace(/>/gi, "&gt;");
		strTitle 	= strTitle.replace(/\s/gi, "&nbsp;");
	}catch(e){}
	try{
		// 위치글 특수문자들을 알맞은 HTML 예약어로 바꾼다.
		strPosition 	= $('#position').val().replace(/</gi, "&lt;");
		strPosition 	= strPosition.replace(/>/gi, "&gt;");
		strPosition 	= strPosition.replace(/\s/gi, "&nbsp;");
	}catch(e){}
	try{
		// 내용글 특수문자들을 알맞은 HTML 예약어로 바꾼다.
		strContent 	= $('#contents').val().replace(/</gi, "&lt;");
		strContent 	= strContent.replace(/>/gi, "&gt;");		
		strContent 	= strContent.replace(/\r\n/gi, "<br>");
		strContent 	= strContent.replace(/\s/gi, "&nbsp;");
	}catch(e){}
	
	// 제목 설정
	printMain.$('#title').html(strTitle);
	printMain.$('#title').css('color',tColor);
	printMain.$('#title').css('font-size',$('#title_size').val());
	printMain.$('#title').css('font-family',$('#title_font').val());
	if( $('#title_bold').attr('checked') ) printMain.$('#title').css('font-weight','bolder');
	else printMain.$('#title').css('font-weight','normal');
	if( $('#title_italic').attr('checked') ) printMain.$('#title').css('font-style','italic');
	else printMain.$('#title').css('font-style','normal');
	if( $('#title_underline').attr('checked') ) printMain.$('#title').css('text-decoration','underline');
	else printMain.$('#title').css('text-decoration','none');
	
	// 위치 설정
	printMain.$('#position').html(strPosition);
	printMain.$('#position').css('color',pColor);
	printMain.$('#position').css('font-size',$('#position_size').val());
	printMain.$('#position').css('font-family',$('#position_font').val());
	if( $('#position_bold').attr('checked') ) printMain.$('#position').css('font-weight','bolder');
	else printMain.$('#position').css('font-weight','normal');
	if( $('#position_italic').attr('checked') ) printMain.$('#position').css('font-style','italic');
	else printMain.$('#position').css('font-style','normal');
	if( $('#position_underline').attr('checked') ) printMain.$('#position').css('text-decoration','underline');
	else printMain.$('#position').css('text-decoration','none');
	
	// 출력일 설정
	printMain.$('#tbDate').css('color',pColor);
	printMain.$('#tbDate').css('font-size',$('#position_size').val());
	printMain.$('#tbDate').css('font-family',$('#position_font').val());
	if( $('#position_bold').attr('checked') ) printMain.$('#tbDate').css('font-weight','bolder');
	else printMain.$('#tbDate').css('font-weight','normal');
	if( $('#position_italic').attr('checked') ) printMain.$('#tbDate').css('font-style','italic');
	else printMain.$('#tbDate').css('font-style','normal');
	if( $('#position_underline').attr('checked') ) printMain.$('#tbDate').css('text-decoration','underline');
	else printMain.$('#tbDate').css('text-decoration','none');
	
	// 내용 설정
	printMain.$('#contents').html(strContent);
	printMain.$('#contents').css('color',cColor);
	printMain.$('#contents').css('font-size',$('#content_size').val());
	printMain.$('#contents').css('font-family',$('#content_font').val());
	if( $('#content_bold').attr('checked') ) printMain.$('#contents').css('font-weight','bolder');
	else printMain.$('#contents').css('font-weight','normal');
	if( $('#content_italic').attr('checked') ) printMain.$('#contents').css('font-style','italic');
	else printMain.$('#contents').css('font-style','normal');
	if( $('#content_underline').attr('checked') ) printMain.$('#contents').css('text-decoration','underline');
	else printMain.$('#contents').css('text-decoration','none');
}

// 16진수 컬러 만들기
function MakeColor(Dec)
{
	var colorHex;
	var hex = DecToHex (Dec);
	
	var b = hex.substr(0,2);
	var g = hex.substr(2,2);
	var r = hex.substr(4,2);
	
	colorHex = r + g + b;
	
	document.all.txtTColor.style.backgroundColor = colorHex;
}

// 10진수를 16진수(6자리)로 만들기
function DecToHex (Dec) 
{
	var hexCode = "0123456789ABCDEF";
	var hexNum = "";
	
	p = Dec;
	i = 0;
	while(i < 6)
	{
		a = p%16;
		p = p/16;
		
		hex = hexCode.charAt(a);
		hexNum = hex + hexNum;
		i++;
	}
	
	return hexNum;
}

function printOther(){
	printMain.focus();
	printMain.print();
}