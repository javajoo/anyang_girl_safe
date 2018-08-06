function ChangeMapSize(ptype)
{
	mapCenter = map.getCenter();
	//PageUpdate(ptype);
}

function PageUpdate(ptype)
{
	/*var pWidth , pHeight;
	switch(ptype){
	case 'A0':
		pWidth = 3024;
		pHeight = 3042;
		break;
	case 'A1':
		pWidth = 2091;
		pHeight = 2124;
		break;		
	case 'A2':
		pWidth = 1433;
		pHeight = 1470;
		break;		
	case 'A3':
		pWidth = 968;
		pHeight = 1010;
		break;	
	case 'A4':
		pWidth = 639;
		pHeight = 684;
		break;	
	default:
		pWidth = 639;
		pHeight = 684;
		break;
	}
	
	$('#mapImage').css('width',pWidth+'px');
	$('#mapImage').css('height',pHeight+'px');
	$('#tiltMapImage').css('width',pWidth+'px');
	$('#tiltMapImage').css('height',pHeight+'px');
	
	map.updateSize();
	if(tiltMap!=null){
		tiltMap.updateSize();
	}
	//map.updateSize();
	try{
		$('#maps').css('width',pWidth+'px');
		$('#maps').css('height',pHeight+'px');
	}catch(e){}*/
	try{
		tlb_titile.style.width		= (pWidth)+'px'; 
	}catch(e){}
	try{
		tlb_position.style.width	= (pWidth)+'px';
	}catch(e){}
	try{
		tlb_content.style.width		= (pWidth)+'px';
	}catch(e){}
	try{
		tlb_legend.style.width		= (pWidth)+'px';
	}catch(e){}
}

function aPrint(){
	self.focus();
	self.print();
}

/*
function Print_Preview( intOLEcmd, intOLEparam )
{
	// if intOLEparam이 정의되어 있지 않으면 디폴트 값 설정
	//intOLEparam -1 이면 직접 인쇄
	if ( ( ! intOLEparam ) || ( intOLEparam < -1 )  || (intOLEparam > 1 ) ){
        	intOLEparam = 1;
	}
	PageSetup_Null();
	parent.document.all.printMain.ExecWB( intOLEcmd , intOLEparam);
	PageSetup_Default();
}
*/

function Print_Preview( intOLEcmd, intOLEparam )
{
	// 로그를 기록하기 위한 임시 코드. 전혀 의미 없다.
	$.ajax({
			url: "/print/printMap.do",
			type: "get",
			success: function(datas, textStatus, jQxhr){
				
			},
			error: function(jqXhr, textStatus, errorThrown){
				
			}
		});
	//--- 전혀 의미 없다.
	
	if ( ( ! intOLEparam ) || ( intOLEparam < -1 )  || (intOLEparam > 1 ) ){
        	intOLEparam = 1;
	}

	if(intOLEcmd == 8 && !browserCheck()){
		alert("용지설정은 Windows Internet Explorer 8에서만 사용할 수 있습니다. 하단에 인쇄하기를 눌러 인쇄해주세요.");
		//alert("사용하고 계시는 브라우져에서는 용지설정이 되지 않습니다. 아래 인쇄하기를 눌러주세요.");
		return;
	}
	
	if(intOLEcmd == 7){
		if(!browserCheck()){
			parent.printOther();
			return;
		}
	}
	
	parent.document.all.printMain.ExecWB( intOLEcmd , intOLEparam);
}

function getInternetVersion(ver) { 
	var rv = -1; // Return value assumes failure.      
	var ua = navigator.userAgent;  
	var re = null;
	if(ver == "MSIE"){
		re = new RegExp("MSIE ([0-9]{1,}[\.0-9]{0,})");
	}else{
		re = new RegExp(ver+"/([0-9]{1,}[\.0-9]{0,})");
	}
	if (re.exec(ua) != null){ 
		rv = parseFloat(RegExp.$1);
	} 
		return rv;  
} 
	 
function browserCheck(){ 
	var ver = 0; 
	if(navigator.appName.charAt(0) == "N"){ 
		return false; 
	}else if(navigator.appName.charAt(0) == "M"){
		ver = getInternetVersion("MSIE");
		if(ver >= 9)
			return false;
		else
			return true;
	}
} 


// Print Web pages in the air for the header footer  
function PageSetup_Null()  
{  
  try  
  {  
    var Wsh = new ActiveXObject("WScript.Shell");  
    HKEY_Key = "header";  
    Wsh.RegWrite(HKEY_Root+HKEY_Path+HKEY_Key ,"");  
    HKEY_Key = "footer";  
    Wsh.RegWrite (HKEY_Root+HKEY_Path+HKEY_Key ,"");  
  } catch(e){
    alert(e);
  }
}  

function PageSetup_Default()  
{  
  try  
  {  
    var Wsh = new ActiveXObject("WScript.Shell");  
    HKEY_Key = "header";  
    Wsh.RegWrite (HKEY_Root+HKEY_Path+HKEY_Key, "Page&b&w,&p/&P");  
    HKEY_Key = "footer";  
    Wsh.RegWrite (HKEY_Root+HKEY_Path+HKEY_Key, "&u&b&d");  
  }  catch (e) {}  
}
