danu.main.Options = {
	/**
	 * mode는 프로그램이 몇 개의 자치단체를 대상으로 하는지를 나타낸다.
	 * single은 1개 자치단체, multi는 2개 이상 자치단체 또는 자치단체 통합. 개별과 통합프로그램의 구현이 다른 경우는
	 * 
	 * 			if (danu.main.Option.mode === "single") {
	 *				// 코드 
	 * 			} else if (danu.main.Option.mode === "multi") {
	 * 				// 코드
	 * 			}
	 * 
	 * 와 같이 구현한다.
	 */
	mode: "single",
	grid: {
		
	},
	style: {
		lookAndFeel: "custom",
		lookAndFeelName: "blackberry"
	},
	myformatter : function(date){
        var y = date.getFullYear();
        var m = date.getMonth()+1;
        var d = date.getDate();
        return y+'-'+(m<10?('0'+m):m)+'-'+(d<10?('0'+d):d);
    },
    myparser : function(s){
    	$('.datebox-black .combo-arrow').removeClass("combo-arrow").addClass("combo-arrow_sel");
        if (!s) return new Date();
        var ss = (s.split('-'));
        var y = parseInt(ss[0],10);
        var m = parseInt(ss[1],10);
        var d = parseInt(ss[2],10);
        if (!isNaN(y) && !isNaN(m) && !isNaN(d)){
            return new Date(y,m-1,d);
        } else {
            return new Date();
        }
    }
};