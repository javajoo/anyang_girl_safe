package com.danusys.platform.web;

import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.danusys.platform.helper.AESHelper;
import com.danusys.platform.service.ExcelHeaderVO;
import com.danusys.platform.service.PrintService;
import com.danusys.platform.west.service.LogService;
import com.danusys.platform.west.service.LogVO;

import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cmm.service.FileVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

/**
 * @Class Name : AppVersionsController.java
 * @Description : AppVersions Controller class
 * @Modification Information
 *
 * @author 신대영
 * @since 2016-09-22
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
public class AdminController {
    
    @Resource(name = "logService")
    private LogService logService;
    
    @Resource(name = "printService")
    private PrintService printService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
    
    @Resource(name = "EgovFileMngUtil")
	private EgovFileMngUtil fileUtil;

	@Resource(name = "EgovFileMngService")
	private EgovFileMngService fileMngService;
    
    /*@RequestMapping("/admin/version.do")
    public @ResponseBody JSONResult selectAppVersions(AppVersionsVO appVersionsVO, HttpServletRequest request) throws Exception {
    	JSONResult jr = null;
    	
    	EgovMap egovMap = this.appVersionsService.selectAppVersions(appVersionsVO);
    	if(request.getParameter("device").toUpperCase().equals("ANDROID")){
    		Map<String, String> map = new HashMap<String , String>();
    		map.put("version", (String)egovMap.get("androidVersion"));
    		jr = new JSONResult("OK", "", map);
    	}else if(request.getParameter("device").toUpperCase().equals("IOS")){
    		Map<String, String> map = new HashMap<String , String>();
    		map.put("version", (String)egovMap.get("iosVersion"));
    		jr = new JSONResult("OK", "", map);
    	}else{
    		jr = new JSONResult("ERROR", "지원되는 디바이스가 아닙니다.", "");
    	}
    		
        return jr;
    }*/

    /*@RequestMapping("/admin/path_listSafety.do")
    public @ResponseBody List<?> selectAdminPathsSafety(PathDetailsVO pathDetailsVO) throws Exception {
    	return this.pathDetailsService.selectPathDetailsList(pathDetailsVO);
    }*/
    
    /*@RequestMapping("/admin/path_listDimentia.do")
    public @ResponseBody List<?> selectAdminPathsDimentia(PathDetailsVO pathDetailsVO) throws Exception {
    	return this.dimentiaPathDetailsService.selectPathDetailsList(pathDetailsVO);
    }*/
    
    /*@RequestMapping("/admin/record_listSafety.do")
    public @ResponseBody List<?> selectAdminRecordsSafety(RecordDetailsVO recordDetailsVO) throws Exception {
    	return this.recordDetailsService.selectRecordDetails3(recordDetailsVO);
    }*/
    
    /*@RequestMapping("/admin/record_listDimentia.do")
    public @ResponseBody List<?> selectAdminRecordsDimentia(RecordDetailsVO recordDetailsVO) throws Exception {
    	return this.dimentiaRecordDetailsService.selectRecordDetails3(recordDetailsVO);
    }*/
    
    /**
	 * members 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 MembersDefaultVO
	 * @return "/member/MembersList"
	 * @exception Exception
	 */
    /*@RequestMapping(value="/admin/MembersListSafety.do")
    public  @ResponseBody List<?> selectMembersListSafety(@ModelAttribute("searchVO") MembersVO searchVO) throws Exception {
    	이용자 조회 시 상태값 체크
    	// 접속시간에서 90분이 지났으면 비이용중 상태로 업데이트. 적절하지 않다. 임시로 주석처리.
    	this.membersService.updateMembersStatusChk(searchVO);
    	return (List<EgovMap>) this.membersService.selectMembersList(searchVO);
    	membersService.updateMembersStatusChk(searchVO);
    	return (List<EgovMap>) membersService.selectMembersList(searchVO);
    }*/
       
    /*@RequestMapping("/admin/relation_list.do")
    public @ResponseBody List<?> selectRelationList(MemberRelationsVO vo) throws Exception {
    	MemberRelationsVO rVO = new MemberRelationsVO();
        rVO.setUserId(vo.getUserId());
       
    	return this.memberRelationsService.selectMemberRelationsName(rVO); 
    }*/
    
    /**
	 * members 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 MembersDefaultVO
	 * @return "/member/MembersList"
	 * @exception Exception
	 */
    /*@RequestMapping(value="/admin/MembersListCount.do")
    public  @ResponseBody List<?> selectMembersListCount(@ModelAttribute("searchVO") MembersVO searchVO) throws Exception {
    	return membersService.selectMembersListCount(searchVO);
    }*/

    /**
	 * members 목록을 조회한다. filter 적용
	 * @param searchVO - 조회할 정보가 담긴 MembersDefaultVO
	 * @return "/member/MembersLis"
	 * @exception Exception
	 */
    /*@RequestMapping(value="/admin/MembersListFilter.do")
    public  @ResponseBody List<?> selectMembersListFilter(@ModelAttribute("searchVO") MembersVO searchVO) throws Exception {
    	// 차트. safety인지 dimentia인지 구별 필요.
    	//String searchType = searchVO.getSearchType();
    	//List<EgovMap> list = null;
    	//if ("SAFETY".equals(searchType)) {
    	//	this.mService = this.membersService;
    	//	list = (List<EgovMap>) this.mService.selectMembersListFilter1(searchVO);
    	//} else if ("DIMENTIA".equals(searchType)) {
    	//	this.mService = this.dimentiaMembersService;
    	//	list = (List<EgovMap>) this.mService.selectMembersListFilter2(searchVO);
    	//}
    	
    	//int status = searchVO.getId();
    	//이용자 조회 시 상태값 체크
    	// 임시로 주석처리.
    	// mService.updateMembersStatusChk(searchVO);
        
		//return list;
    	
		return (List<EgovMap>) membersService.selectMembersListFilter1(searchVO);
    }*/
    
    /**
	 * 성별, 연령별 차트 데이터 조회
	 * @param searchVO - 조회할 정보가 담긴 MembersDefaultVO
	 * @return "/member/MembersLis"
	 * @exception Exception
	 */
    /*@RequestMapping(value="/admin/selectRegisterChartBySexAndAge.do")
    public  @ResponseBody String selectRegisterChartBySexAndAge(@RequestParam Map<String,Object> map) throws Exception {
    	// 차트. safety인지 dimentia인지 구별 필요.
    	String searchType = String.valueOf(map.get("searchType"));
    	String returnString = null;
    	//if ("SAFETY".equals(searchType)) {
    	//	this.mService = this.membersService;
    	//	returnString = (String) this.mService.selectRegisterChartBySexAndAge1(map);
    	//} else if ("DIMENTIA".equals(searchType)) {
    	//	this.mService = this.dimentiaMembersService;
    	//	returnString = (String) this.mService.selectRegisterChartBySexAndAge2(map);
    	//}
    	//return returnString;
    	
    	return (String) membersService.selectRegisterChartBySexAndAge1(map);
    }*/
    
    /**
	 * 지역별 차트 데이터 조회
	 * @param searchVO - 조회할 정보가 담긴 MembersDefaultVO
	 * @return "/member/MembersLis"
	 * @exception Exception
	 */
    /*@RequestMapping(value="/admin/selectRegisterChartByCounty.do")
    public  @ResponseBody String selectRegisterChartByCounty(@RequestParam Map<String,Object> map) throws Exception {
    	// 차트. safety인지 dimentia인지 구별 필요.
    	//String searchType = String.valueOf(map.get("searchType"));
    	//if ("SAFETY".equals(searchType)) {
    	//	this.mService = this.membersService;
    	//} else if ("DIMENTIA".equals(searchType)) {
    	//	this.mService = this.dimentiaMembersService;
    	//}
    	
    	//return this.mService.selectRegisterChartByCounty(map);
    	
    	return (String) membersService.selectRegisterChartByCounty(map);
    }*/
    
    /**
	 * 시간대별 차트 데이터 조회
	 * @param searchVO - 조회할 정보가 담긴 MembersDefaultVO
	 * @return "/member/MembersLis"
	 * @exception Exception
	 */
    /*@RequestMapping(value="/admin/selectLogonAndStatusChartByTime.do")
    public  @ResponseBody String selectLogonAndStatusChartByTime(@RequestParam Map<String,Object> map) throws Exception {
    	// 차트. safety인지 dimentia인지 구별 필요.
    	//String searchType = String.valueOf(map.get("searchType"));
    	//if ("SAFETY".equals(searchType)) {
    	//	this.mService = this.membersService;
    	//} else if ("DIMENTIA".equals(searchType)) {
    	//	this.mService = this.dimentiaMembersService;
    	//}
    	
    	//return this.mService.selectLogonAndStatusChartByTime(map);
    	
    	return (String) membersService.selectLogonAndStatusChartByTime(map);
    }*/
    
    /**
	 * 상태별 차트 데이터 조회
	 * @param searchVO - 조회할 정보가 담긴 MembersDefaultVO
	 * @return "/member/MembersLis"
	 * @exception Exception
	 */
    /*@RequestMapping(value="/admin/selectLogonAndSosChart.do")
    public  @ResponseBody String selectLogonAndSosChart(@RequestParam Map<String,Object> map) throws Exception {
    	// 차트. safety인지 dimentia인지 구별 필요.
    	//String searchType = String.valueOf(map.get("searchType"));
    	//if ("SAFETY".equals(searchType)) {
    	//	this.mService = this.membersService;
    	//} else if ("DIMENTIA".equals(searchType)) {
    	//	this.mService = this.dimentiaMembersService;
    	//}
        
    	//return (String) this.mService.selectLogonAndSosChart(map);
    	
    	return (String) membersService.selectLogonAndSosChart(map);
    }*/
    
    /*@RequestMapping(value="/admin/MembersListSearchSafety.do")
    public  @ResponseBody List<?> MembersListSearchSafety(@ModelAttribute("searchVO") MembersVO searchVO, HttpServletRequest request) throws Exception {
    	int status = searchVO.getStatus();
    	String flag = searchVO.getFlag();
    	searchVO.setKey(propertiesService.getString("AES_KEY"));
    	
    	List<EgovMap> list = null;
    	
    	if(flag.equals("map")){
        	int typeCnt = Integer.parseInt(request.getParameter("cnt"));
        	ArrayList<String> typeList = new ArrayList<String>(typeCnt);
        	for(int i = 0; i < typeCnt; i++){
        		typeList.add(request.getParameter("type"+i));
        	}
        	searchVO.setTypeList(typeList);
        	
        	list = (List<EgovMap>) membersService.selectMembersHistoryListFilter1_map(searchVO);
    	}
    	else{
    		if(status == 0)
        		list = (List<EgovMap>) membersService.selectMembersListFilter1(searchVO);
        	else if(status == 1 || status == 2){
        		list = (List<EgovMap>) membersService.selectMembersHistoryListFilter1(searchVO);
        	}else{
        		list = new ArrayList<EgovMap>();
        	}
    	}
		return list;
    }*/
    
    /*@RequestMapping(value="/admin/MembersListSearchDimentia.do")
    public  @ResponseBody List<?> MembersListSearchDimentia(@ModelAttribute("searchVO") MembersVO searchVO, HttpServletRequest request) throws Exception {
    	int status = searchVO.getStatus();
    	String flag = searchVO.getFlag();
    	searchVO.setKey(propertiesService.getString("AES_KEY"));
    	
    	List<EgovMap> list = null;
    	
    	if(flag.equals("map")){
        	int typeCnt = Integer.parseInt(request.getParameter("cnt"));
        	ArrayList<String> typeList = new ArrayList<String>(typeCnt);
        	for(int i = 0; i < typeCnt; i++){
        		typeList.add(request.getParameter("type"+i));
        	}
        	searchVO.setTypeList(typeList);
        	
        	list = (List<EgovMap>)this.dimentiaMembersService.selectMembersHistoryListFilter2(searchVO);
    	}
    	else{
    		if(status == 0)
        		list = (List<EgovMap>)this.dimentiaMembersService.selectMembersListFilter2(searchVO);
        	else if(status == 1 || status == 2){
        		list = (List<EgovMap>)this.dimentiaMembersService.selectMembersHistoryListFilter2(searchVO);
        	}else{
        		list = new ArrayList<EgovMap>();
        	}    		
    	}
		return list;
    }*/
    
    /*@RequestMapping("/admin/excelSearchResultExport.do")
    public ModelAndView excelSearchResultExport(MembersVO searchVO, HttpServletRequest request) throws Exception {
    	//String gbn = request.getParameter("flag");
    	int status = Integer.parseInt(request.getParameter("status"));
    	searchVO.setAddress(URLDecoder.decode(searchVO.getAddress(), "UTF-8"));
    	searchVO.setKey(propertiesService.getString("AES_KEY"));
    	List<?> result = new ArrayList<EgovMap>();
    	
    	//if(gbn.equals("S")){
    		if(status == 0)
    			result = (List<EgovMap>) membersService.excelSelectMembersListFilter1(searchVO);
        	else if(status == 1 || status == 2){
        		result = (List<EgovMap>) membersService.excelSelectMembersHistoryListFilter1(searchVO);
        	}
    	//}
    	//else if(gbn.equals("D")){
    	//	if(status == 0)
    	//		result = (List<EgovMap>)this.dimentiaMembersService.excelSelectMembersListFilter2(searchVO);
        //	else if(status == 1 || status == 2){
        //		result = (List<EgovMap>)this.dimentiaMembersService.excelSelectMembersHistoryListFilter2(searchVO);
        //	}
    	//}
    	
    	List<ExcelHeaderVO> headerList = new ArrayList<ExcelHeaderVO>();
		
		int headerCnt = Integer.parseInt(request.getParameter("headerCnt"));
		
		for(int i = 0; i < headerCnt; i++){
			ExcelHeaderVO vo = new ExcelHeaderVO();
			vo.setHeaderText(request.getParameter("headerText"+i));
			vo.setHeaderField(request.getParameter("headerField"+i));
			vo.setHeaderUse(Boolean.parseBoolean(request.getParameter("headerUse"+i)));
			headerList.add(vo);
		}

		Map<String, Object> map = new HashMap<String, Object>();

		map.put("result", result);
		map.put("headerList", headerList);
		
		return new ModelAndView("searchExcelView", map);
    }*/
    
    /*@RequestMapping(value="/admin/MembersListPopupDimentia.do")
    public  @ResponseBody List<?> MembersListPopupDimentia() throws Exception {
		return (List<EgovMap>) this.dimentiaMembersService.selectMembersListPopup();
    }*/
    
    /**
     * 로그 조회
     * @param searchVO
     * @return
     * @throws Exception
     */
    /*@RequestMapping(value="/admin/LogSearch.do")
    public  @ResponseBody List<?> LogSearch(@ModelAttribute("searchVO") LogVO vo) throws Exception {
		return logService.searchLog(vo);
    }*/
    
    /*@RequestMapping(value="admin/MembersConnectionList.do") //?
    public  @ResponseBody List<?> selectMembersConnectionList(@ModelAttribute("searchVO") MembersVO searchVO) throws Exception {
    	// 차트. safety인지 dimentia인지 구별 필요.
    	String searchType = searchVO.getSearchType();
    	//if ("SAFETY".equals(searchType)) {
    	//	this.mService = this.membersService;
    	//} else if ("DIMENTIA".equals(searchType)) {
    	//	this.mService = this.dimentiaMembersService;
    	//}
    	
    	//List<EgovMap> list = (List<EgovMap>) this.mService.selectMembersConnectionList(searchVO);
    	
    	List<EgovMap> list = (List<EgovMap>) membersService.selectMembersConnectionList(searchVO);
        List<EgovMap> list2 = new ArrayList<EgovMap>();
        for(EgovMap map : list){
        	String address = null;
        	try {
        		address = AESHelper.decryptAES((String)map.get("encryptAdres"), propertiesService.getString("AES_KEY"));
        	} catch (Exception e) {
        		address = "";
        	}
        	if(searchVO.getAddress() != null && address.indexOf(searchVO.getAddress()) == -1 && !searchVO.getAddress().equals("전체"))
        		continue;
        	map.put("address", address);
        	map.remove("encryptAdres");
        	list2.add(map);
        }
		return list2;
    }*/    
    
    /**
     * 지도출력
     */
    @RequestMapping("print/printMap.do")
	public void printMap() {
    	System.out.println("printMap");
    	printService.printMap();
    }
    
    /*@RequestMapping(value="admin/deviceDuplCheck.do")
    public @ResponseBody String deviceDuplCheck(@RequestParam("deviceEui") String deviceEui) {
    	return this.dimentiaMembersService.deviceDuplCheck(deviceEui);
    }*/
    
    /*@RequestMapping(value="admin/deviceDuplCheck2.do")
    public @ResponseBody String deviceDuplCheck2(@ModelAttribute("deviceId") String deviceId) {
    	return this.dimentiaMembersService.deviceDuplCheck(deviceId);
    }*/
    
    /*@RequestMapping(value="admin/getGuData.do")
    public @ResponseBody String getGuData(@RequestParam Map<String,Object> map) {
    	//return this.cityService.selectGuData(map);
    }
    
    @RequestMapping(value="admin/getEmdData.do")
    public @ResponseBody String getEmdData(@RequestParam Map<String,Object> map) {
    	return this.cityService.selectEmdData(map);
    }*/
    
    /**
     * 치매노인, 기기, 보호자 등록
     * @param json
     * @return
     */
    /*@RequestMapping(value="admin/MembersRegisterDimentia.do", method=RequestMethod.POST, consumes="application/json")
    public @ResponseBody String registerDimentia(@ModelAttribute("json") String json) {
    	return this.dimentiaMembersService.registerDimentia(json);
    }*/
    
    /*@RequestMapping(value="admin/MembersUpdateDimentia.do", method=RequestMethod.POST, consumes="application/json")
    public @ResponseBody String updateDimentia(@ModelAttribute("json") String json) {
    	return this.dimentiaMembersService.updateDimentia(json);
    }*/

    /*@RequestMapping(value="/admin/sendMsg.do")
    public  @ResponseBody JSONResult sendMsg(HttpServletRequest request) throws Exception {
        int cnt = Integer.parseInt(request.getParameter("cnt"));
        
        
        ArrayList<String> tmp = new ArrayList<String>(cnt); 
        
        for(int i = 0; i < cnt; i++){
        	tmp.add(request.getParameter("id"+i));
        }
        
        PushHelper pHelper = new PushHelper(this.membersService, this.memberRelationsService);
		
		pHelper.sendPushToUser(tmp, request.getParameter("msg"));
        
		return new JSONResult("OK", "", new HashMap());
    }*/ 

	/*@RequestMapping("/admin/member_off.do")
	public @ResponseBody JSONResult memberOff(MembersVO membersVO) throws Exception {
    	JSONResult jr = null;

    	try{
    		// 임시로 주석처리
    		this.membersService.updateMemberStatus(membersVO);
            
    		jr = new JSONResult("OK", "", new HashMap());
    	}catch(Exception exx){
    		jr = new JSONResult("ERROR", exx.toString(), new HashMap());
    	}

        return jr;
    }*/
	
	/*@RequestMapping(value="/admin/selectDimentiaJoin.do")
    public  @ResponseBody List<?> selectDimentiaJoin(@ModelAttribute("searchVO") MembersVO searchVO) throws Exception {
		searchVO.setKey(propertiesService.getString("AES_KEY"));
		return (List<EgovMap>) this.dimentiaMembersService.selectDimentiaJoin(searchVO);
    }*/
	
	/*@RequestMapping("/admin/excelJoinResultExport.do")
    public ModelAndView excelJoinResultExport(MembersVO searchVO, HttpServletRequest request) throws Exception {
    	searchVO.setKey(propertiesService.getString("AES_KEY"));
    	
    	int chkCnt = Integer.parseInt(request.getParameter("chkCnt"));
		ArrayList<String> idList = new ArrayList<String>(chkCnt);
		for(int i = 0; i < chkCnt; i++){
			idList.add(request.getParameter("chkId"+i));
		}
		searchVO.setIdList(idList);
    	
    	List<?> result = (List<EgovMap>) this.dimentiaMembersService.excelSelectDimentiaJoin(searchVO);
    	List<ExcelHeaderVO> headerList = new ArrayList<ExcelHeaderVO>();
		
		int headerCnt = Integer.parseInt(request.getParameter("headerCnt"));
		
		for(int i = 0; i < headerCnt; i++){
			ExcelHeaderVO vo = new ExcelHeaderVO();
			vo.setHeaderText(request.getParameter("headerText"+i));
			vo.setHeaderField(request.getParameter("headerField"+i));
			vo.setHeaderUse(Boolean.parseBoolean(request.getParameter("headerUse"+i)));
			headerList.add(vo);
		}

		Map<String, Object> map = new HashMap<String, Object>();

		map.put("result", result);
		map.put("headerList", headerList);
		
		return new ModelAndView("searchExcelView", map);
    }*/
	
	@RequestMapping("/admin/uploadImage.do")
    public @ResponseBody String insertImage(final MultipartHttpServletRequest multiRequest, HttpServletRequest request) throws Exception {
		final Map<String, MultipartFile> files = multiRequest.getFileMap();
		
		String _atchFileId = null;
		/*String _atchFileId = request.getParameter("fileAtchFileId");
		if (!files.isEmpty()) {
			if(_atchFileId == null || _atchFileId.equals("")){
				List<FileVO> _result = fileUtil.parseFileInf(files, "dimentia_", 0, "", "");
				_atchFileId = fileMngService.insertFileInfs(_result);
			}else{
				FileVO fvo = new FileVO();
				fvo.setAtchFileId(_atchFileId);
				int _cnt = fileMngService.getMaxFileSN(fvo);
				List<FileVO> _result = fileUtil.parseFileInf(files, "dimentia_", _cnt, _atchFileId, "");
				fileMngService.updateFileInfs(_result);
			}
		}*/
		
		if (!files.isEmpty()) {
			List<FileVO> _result = fileUtil.parseFileInf(files, "dimentia_", 0, "", "");
			_atchFileId = fileMngService.insertFileInfs(_result);
		}
		
		System.out.println("_atchFileId:: "+_atchFileId);
		return _atchFileId;
    }
	
	/*@RequestMapping("/admin/deleteMemberList.do")
	public @ResponseBody Map<String, String> deleteMemberList(HttpServletRequest request) throws Exception {
		Map<String , String> map = new HashMap<String , String>();
		
		int cnt = Integer.parseInt(request.getParameter("cnt"));
    	ArrayList<String> idList = new ArrayList<String>(cnt);
    	
    	for(int i = 0; i < cnt; i++){
    		idList.add(request.getParameter("id"+i));
    	}
    	
    	MembersVO vo = new MembersVO();
    	vo.setIdList(idList);
		
    	this.dimentiaMembersService.deleteMemberList(vo);
		try{
        	map.put("stat", "sucess");
    	}catch(Exception exx){
    		map.put("stat", exx.toString());
    	}
        return map;
	}*/
}
