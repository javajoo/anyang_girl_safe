package com.danusys.platform.work.event.web;

import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.jdbc.UncategorizedSQLException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.danusys.cmm.LoginVO;
import com.danusys.cmm.util.CommonUtil;
import com.danusys.platform.vo.AdminVo;
import com.danusys.platform.work.event.service.CmEventService;

import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;

/**
 * @Class Name : CmEventController.java
 * @Description : CmEvent Controller class
 * @Modification Information
 *
 * @author 이인의
 * @since 2018-05-11
 * @version 1.0
 * @see Copyright (C) All right reserved.
 */

@Controller
public class CmEventController {
	
	private static Logger logger = LogManager.getLogger(CmEventController.class);

	@Resource(name = "cmEventService")
	private CmEventService cmEventService;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	/**
	 * CM_EVENT 목록을 조회한다. (pageing)
	 * 
	 * @param searchVO
	 *            - 조회할 정보가 담긴 CmEventDefaultVO
	 * @return "/cmEvent/CmEventList"
	 * @exception Exception
	 */
	@RequestMapping(value = "/com/danusys/platform/work/event/CmEventList.do")
	@ResponseBody
	public Map<String, Object> selectCmEventList(ModelMap model,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String sysCd = request.getParameter("sysCd");
		String usvcGrpCd = request.getParameter("usvcGrpCd");
		String useTyCd = request.getParameter("useTyCd");
		String pageNo = request.getParameter("page");
		String rowsPerPage = request.getParameter("rows");
		String sidx = request.getParameter("sidx");
		String sord = request.getParameter("sord");
		// String evtIconPath =
		// this.propertiesService.getString("Globals.IconUploadDirectory").trim()
		// + "/event";

		Map<String, String> args = new HashMap();
		args.put("sysCd", sysCd);
		args.put("usvcGrpCd", usvcGrpCd);
		args.put("useTyCd", useTyCd);
		args.put("pageNo", pageNo);
		args.put("rowsPerPage", rowsPerPage);
		args.put("sidx", sidx);
		args.put("sord", sord);
		args.put("evtIconPath", "/aaa");
		Map<String, Object> map = new HashMap();
		List<Map<String, String>> resultRows = this.cmEventService
				.selectCmEventList(args);

		map.put("page", pageNo);
		map.put("rows", resultRows);
		return map;
	}

	@RequestMapping({ "/com/danusys/platform/work/event/evtItemList.do" })
	@ResponseBody
	public Map<String, Object> list_item(
			@ModelAttribute("loginVO") LoginVO loginVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model) throws Exception {
		String codeId = request.getParameter("codeId");
		String pageNo = request.getParameter("page");
		String rowsPerPage = request.getParameter("rows");
		String sidx = request.getParameter("sidx");
		String sord = request.getParameter("sord");

		Map<String, String> args = new HashMap();
		args.put("codeId", codeId);
		args.put("pageNo", pageNo);
		args.put("rowsPerPage", rowsPerPage);
		args.put("sidx", sidx);
		args.put("sord", sord);

		Map<String, Object> map = new HashMap();
		List<Map<String, String>> resultRows = this.cmEventService
				.evtItemList(args);

		map.put("page", pageNo);
		map.put("rows", resultRows);

		return map;
	}

	@RequestMapping({ "/com/danusys/platform/work/event/evtItemInfoList.do" })
	@ResponseBody
	public Map<String, Object> list_item_info(
			@ModelAttribute("loginVO") LoginVO loginVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model) throws Exception {
		String codeId = request.getParameter("codeId");
		String pageNo = request.getParameter("page");
		String rowsPerPage = request.getParameter("rows");
		String sidx = request.getParameter("sidx");
		String sord = request.getParameter("sord");

		Map<String, String> args = new HashMap();
		args.put("codeId", codeId);
		args.put("pageNo", pageNo);
		args.put("rowsPerPage", rowsPerPage);
		args.put("sidx", sidx);
		args.put("sord", sord);

		Map<String, Object> map = new HashMap();
		List<Map<String, String>> resultRows = this.cmEventService
				.evtItemInfoList(args);
		map.put("page", pageNo);
		map.put("rows", resultRows);

		return map;
	}

	@RequestMapping({ "/com/danusys/platform/work/event/evtSubList.do" })
	@ResponseBody
	public Map<String, Object> evtSubList(
			@ModelAttribute("loginVO") LoginVO loginVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model) throws Exception {
		Map<String, String> args = new HashMap();
		args.put("codeId",
				EgovStringUtil.isNullToString(request.getParameter("codeId")));

		Map<String, Object> map = new HashMap();
		List<Map<String, String>> resultRows = this.cmEventService
				.evtSubList(args);
		map.put("rows", resultRows);
		return map;
	}

	@RequestMapping({ "/com/danusys/platform/work/event/eventSubDml.do" })
	@ResponseBody
	public Map<String, Object> eventSubDml(ModelMap model,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		AdminVo lgnVO = (AdminVo) request.getSession().getAttribute("admin");
	    String userId = lgnVO.getId();
		String evtId = request.getParameter("codeId");
		String type = request.getParameter("type");

		Map<String, String> args = new HashMap();
		List<Map<String, String>> list = new ArrayList();
		if ("I".equals(type)) {
			args.put("codeId", evtId);
			args.put("evtIdSubCd", URLDecoder.decode(
					request.getParameter("evtIdSubCd"), "utf-8"));
			args.put("evtIdSubNm", URLDecoder.decode(
					request.getParameter("evtIdSubNm"), "utf-8"));
			args.put("wit1", request.getParameter("wit1"));
			args.put("wit2", request.getParameter("wit2"));
			args.put("wit3", request.getParameter("wit3"));
			args.put("useTyCd", request.getParameter("useTyCd"));
			args.put("userId", userId);
		} else {
			String[] evtIdSubCd = request.getParameterValues("evtIdSubCd");
			String[] evtIdSubNm = request.getParameterValues("evtIdSubNm");
			String[] wit1 = request.getParameterValues("wit1");
			String[] wit2 = request.getParameterValues("wit2");
			String[] wit3 = request.getParameterValues("wit3");

			int cnt = evtIdSubCd.length;
			if (cnt > 0) {
				for (int i = 0; i < cnt; i++) {
					Map<String, String> mapItemId = new HashMap();
					mapItemId.put("codeId", evtId);
					mapItemId.put("evtIdSubCd",
							URLDecoder.decode(evtIdSubCd[i], "utf-8"));
					mapItemId.put("evtIdSubNm",
							URLDecoder.decode(evtIdSubNm[i], "utf-8"));
					mapItemId.put("wit1", wit1[i]);
					mapItemId.put("wit2", wit2[i]);
					mapItemId.put("wit3", wit3[i]);

					mapItemId.put("userId", userId);
					list.add(mapItemId);
				}
			}
		}
		String msg = "";
		String dmlType = "";
		Map<String, Object> mapRet = new HashMap();
		try {
			try {
				if ("I".equals(type)) {
					this.cmEventService.insertCmEventSub(args);
					msg = "이벤트세부분류 등록이 실패하였습니다. 다시 시도해 주십시오.";
					dmlType = "Insert";
				} else if ("U".equals(type)) {
					this.cmEventService.updateCmEventSub(list);
					msg = "이벤트세부분류 수정에 실패하였습니다. 다시 시도해 주십시오.";
					dmlType = "Update";
				} else if ("D".equals(type)) {
					this.cmEventService.deleteCmEventSub(list);
					msg = "이벤트세부분류 삭제가 실패하였습니다. 다시 시도해 주십시오.";
					dmlType = "Delete";
				}
			} catch (DataIntegrityViolationException e) {
				logger.error("eventSubDml {} DataIntegrityViolationException : {}",
				dmlType, e.getMessage());
			} catch (UncategorizedSQLException e) {
				if (e.getCause().getMessage().indexOf("JDBC-590730") >= 0) {
					mapRet.put("session", Integer.valueOf(0));
					mapRet.put("msg", msg);
					return mapRet;
				}
				logger.error("eventSubDml {} UncategorizedSQLException : {}",
				dmlType, e.getMessage());
			} catch (Exception e) {
				logger.error("eventSubDml {} Exception : {}", dmlType,
				e.getMessage());
			}
			mapRet.put("session", Integer.valueOf(1));
			mapRet.put("msg", "정상처리 되었습니다.");
		} catch (NullPointerException e) {
			logger.error("eventSubDml {} NullPointerException  : {}",
			dmlType, e.getMessage());
			mapRet.put("session", Integer.valueOf(0));
			mapRet.put("msg", "값이 존재하지 않습니다.");
		} catch (Exception e) {
			logger.error("eventSubDml {} Exception : {}", dmlType,
			e.getMessage());
			mapRet.put("session", Integer.valueOf(0));
			mapRet.put("msg", "알수없는 에러입니다.");
		}
		return mapRet;
	}

	@RequestMapping({ "/com/danusys/platform/work/event/insert_item.do" })
	@ResponseBody
	public Map<String, Object> insertItem(ModelMap model,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		AdminVo lgnVO = (AdminVo) request.getSession().getAttribute("admin");
	    String sesUserId = lgnVO.getId();
		String[] evtItemIds = request.getParameterValues("evtItemId");
		String[] evtIds = request.getParameterValues("codeId");
		int itemCnt = evtItemIds.length;

		List<Map<String, String>> list = new ArrayList();
		if (itemCnt >= 1) {
			for (int i = 0; i < itemCnt; i++) {
				Map<String, String> mapItemId = new HashMap();
				mapItemId.put("codeId", evtIds[i]);
				mapItemId.put("evtItemId", evtItemIds[i]);
				mapItemId.put("userId", sesUserId);
				list.add(mapItemId);
			}
		}
		Map<String, Object> mapRet = new HashMap();
		try {
			try {
				this.cmEventService.insertCmEvtItemInfo(list);
			} catch (DataIntegrityViolationException e) {
				logger.error("insertItem DataIntegrityViolationException : {}",
				e.getMessage());
			} catch (UncategorizedSQLException e) {
				if (e.getCause().getMessage().indexOf("JDBC-590730") >= 0) {
					mapRet.put("session", Integer.valueOf(0));
					mapRet.put("msg", "이벤트항목 등록이 실패하였습니다. 다시 시도해주십시오.");
					return mapRet;
				}
				logger.error("insertItem UncategorizedSQLException : {}",
				e.getMessage());
			} catch (Exception e) {
				logger.error("insertItem Exception : {}", e.getMessage());
			}
			mapRet.put("session", Integer.valueOf(1));
			mapRet.put("msg", "저장하였습니다.");
		} catch (NullPointerException e) {
			logger.error("insertItem NullPointerException  : {}",
			e.getMessage());
			mapRet.put("session", Integer.valueOf(0));
			mapRet.put("msg", "값이 존재하지 않습니다..");
		} catch (Exception e) {
			logger.error("insertItem Exception : {}", e.getMessage());
			mapRet.put("session", Integer.valueOf(0));
			mapRet.put("msg", "알수없는 에러입니다.");
		}
		return mapRet;
	}

	@RequestMapping({ "/com/danusys/platform/work/event/itemDml.do" })
	@ResponseBody
	public Map<String, Object> updateItem(ModelMap model,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		AdminVo lgnVO = (AdminVo) request.getSession().getAttribute("admin");
	    String userId = lgnVO.getId();

		String type = request.getParameter("dmlType");
		String[] evtIds = request.getParameterValues("codeId");
		String[] evtItemIds = request.getParameterValues("evtItemId");
		String[] estYns = request.getParameterValues("estYn");
		int cnt = evtIds.length;

		List<Map<String, String>> list = new ArrayList();
		if (cnt > 0) {
			for (int i = 0; i < cnt; i++) {
				Map<String, String> mapItemId = new HashMap();
				mapItemId.put("codeId", evtIds[i]);
				mapItemId.put("evtItemId", evtItemIds[i]);
				mapItemId.put("estYn", estYns[i]);
				mapItemId.put("userId", userId);
				list.add(mapItemId);
			}
		}
		String msg = "";
		String dmlType = "";
		Map<String, Object> mapRet = new HashMap();
		try {
			try {
				if ("I".equals(type)) {
					this.cmEventService.insertCmEvtItemInfo(list);
					msg = "이벤트세부분류 등록이 실패하였습니다. 다시 싣행 해주십시오.";
					dmlType = "Insert";
				} else if ("U".equals(type)) {
					this.cmEventService.updateCmEvtItemInfo(list);
					msg = "이벤트세부분류 수정에 실패하였습니다. 다시 싣행 싣해주십시오.";
					dmlType = "Update";
				} else if ("D".equals(type)) {
					this.cmEventService.deleteCmEvtItemInfo(list);
					msg = "이벤트세부분류 삭제가 실패하였습니다. 다시 싣행 싣해주십시오.";
					dmlType = "Delete";
				}
			} catch (DataIntegrityViolationException e) {
				logger.error("{} DataIntegrityViolationException : {}",
				dmlType, e.getMessage());
			} catch (UncategorizedSQLException e) {
				if (e.getCause().getMessage().indexOf("JDBC-590730") >= 0) {
					mapRet.put("session", Integer.valueOf(0));
					mapRet.put("msg", msg);
					return mapRet;
				}
				logger.error("{} UncategorizedSQLException : {}", dmlType,
				e.getMessage());
			} catch (Exception e) {
				logger.error("{} Exception : {}", dmlType, e.getMessage());
			}
			mapRet.put("session", Integer.valueOf(1));
			mapRet.put("msg", "저장하였습니다.");
		} catch (NullPointerException e) {
			logger.error("{} NullPointerException  : {}", dmlType,
			e.getMessage());
			mapRet.put("session", Integer.valueOf(0));
			mapRet.put("msg", "갑이 존재하지 않습니다.");
		} catch (Exception e) {
			logger.error("{} Exception  : {}", dmlType, e.getMessage());
			mapRet.put("session", Integer.valueOf(0));
			mapRet.put("msg", "알숭벗는 에러입니다.");
		}
		return mapRet;
	}

	@RequestMapping({ "/com/danusys/platform/work/event/evtBaseDml.do" })
	@ResponseBody
	public Map<String, Object> evtBaseDml(ModelMap model,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		AdminVo lgnVO = (AdminVo) request.getSession().getAttribute("admin");
	    String userId = lgnVO.getId();
		String type = request.getParameter("type");
		String codeId = request.getParameter("codeId");
		int fileCnt = Integer.parseInt(request.getParameter("fileCnt"));
		Map<String, Object> map = new HashMap();
		map.put("codeId", codeId);
		map.put("codeNm",
				URLDecoder.decode(request.getParameter("codeNm"), "utf-8"));
		map.put("sysCd", request.getParameter("sysCd"));
		map.put("usvcGrpCd", request.getParameter("usvcGrpCd"));
		//map.put("srlNo", request.getParameter("srlNo"));
		//map.put("sortOrdr", request.getParameter("sortOrdr"));
		map.put("cont",
				URLDecoder.decode(request.getParameter("cont"), "utf-8"));
		//map.put("urgdgGradCd", request.getParameter("urgdgGradCd"));
		//map.put("evtIconDspYn", request.getParameter("evtIconDspYn"));
		//map.put("evtLcMoveYn", request.getParameter("evtLcMoveYn"));
		//map.put("lightbarOperYn", request.getParameter("lightbarOperYn"));
		//map.put("cmpndEvtYn", request.getParameter("cmpndEvtYn"));
		//map.put("evtAutoTrmsStc", URLDecoder.decode(
		//		request.getParameter("evtAutoTrmsStc"), "utf-8"));
		map.put("useTyCd", request.getParameter("useTyCd"));
		//map.put("autoEndTime", request.getParameter("autoEndTime"));
		map.put("stdEvtYn", request.getParameter("stdEvtYn"));
		map.put("userId", userId);
		Map<String, Object> mapRet = new HashMap();
		if (!CommonUtil.checkDataFilterObj(map)) {
			mapRet.put("session", Integer.valueOf(0));
			mapRet.put("msg", "특수문자를 포함한 자료는 저장할 수 없습니다.");
			return mapRet;
		}
		if (fileCnt > 0) {
			/*
			 * mapRet = eventIconFileUpload(request); if
			 * ("0".equals(mapRet.get("session"))) { return mapRet; }
			 */
		}
		try {
			if ("INSERT".equals(type)) {
				String[] evtItemIds = request.getParameterValues("evtItemId");
				int evtTypeCurrval = this.cmEventService.selectEventTypeCurrval();
				String evtId = codeId + evtTypeCurrval;
				List<Map<String, Object>> list = new ArrayList();
				int itemCnt = evtItemIds.length;
				for (int i = 1; i < itemCnt; i++) {
					Map<String, Object> mapItemId = new HashMap();
					mapItemId.put("codeId", evtId);
					mapItemId.put("evtItemId",
							URLDecoder.decode(evtItemIds[i], "utf-8"));
					mapItemId.put("sysCd", request.getParameter("sysCd"));
					mapItemId.put("usvcGrpCd",
							request.getParameter("usvcGrpCd"));
					mapItemId.put("srlNo", request.getParameter("srlNo"));
					mapItemId.put("sortOrdr", "0");
					mapItemId.put("userId", userId);
					list.add(mapItemId);
				}
				
				this.cmEventService.insertCmEvent(map, list);
			} else if ("UPDATE".equals(type)) {
				this.cmEventService.updateCmEvent(map);
			}
			mapRet.put("session", Integer.valueOf(1));
			mapRet.put("msg", "저장하였습니다.");
		} catch (DataIntegrityViolationException e) {
			logger.error("{} DataIntegrityViolationException : {}", type,
			e.getMessage());
			mapRet.put("session", Integer.valueOf(0));
			mapRet.put("msg", "관리자에게 문의하세요.");
			return mapRet;
		} catch (UncategorizedSQLException e) {
			if (e.getCause().getMessage().indexOf("JDBC-590730") >= 0) {
				logger.error("{} UncategorizedSQLException If : {}", type,
				e.getMessage());
				mapRet.put("msg", "시스템 및 서비스그룹 확인후 등록해주세요.");
			} else {
				logger.error("{} UncategorizedSQLException Else : {}", type,
				e.getMessage());
				mapRet.put("msg", "알수없는 에러 입니다.");
			}
			mapRet.put("session", Integer.valueOf(0));
			return mapRet;
		} catch (Exception e) {
			logger.error("{} Exception : {}", type, e.getMessage());
			mapRet.put("session", Integer.valueOf(0));
			mapRet.put("msg", "알수없는 에러 입니다..");
			return mapRet;
		}
		return mapRet;
	}

	@RequestMapping({ "/com/danusys/platform/work/event/delete.do" })
	@ResponseBody
	public Map<String, Object> delete(ModelMap model,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		AdminVo lgnVO = (AdminVo) request.getSession().getAttribute("admin");
	    String sesUserId = lgnVO.getId();
		String codeId = request.getParameter("codeId");
		Map<String, Object> map = new HashMap();
		map.put("codeId", codeId);
		map.put("userId", sesUserId);
		Map<String, Object> mapRet = new HashMap();
		/*String saveDir = this.propertiesService.getString(
		 		"Globals.fileStorePath").trim()
				+ this.propertiesService.getString(
						"Globals.EventUploadDirectory").trim();
		if ((saveDir == null) || ("".equals(saveDir))) {
			mapRet.put("session", Integer.valueOf(0));
			mapRet.put("msg", "이미지 파일을 저장할 위치 정보가 없습니다.");
			return mapRet;
		}*/
		try {
			try {
				int ret = this.cmEventService.deleteCmEvent(map);
			} catch (DataIntegrityViolationException e) {
				logger.error("delete DataIntegrityViolationException : {}",
				e.getMessage());
			} catch (UncategorizedSQLException e) {
				if (e.getCause().getMessage().indexOf("JDBC-590730") >= 0) {
					mapRet.put("session", Integer.valueOf(0));
					mapRet.put("msg", "삭제처리중 오류가 발생하였습니다. 잠시루 다시 시도해주세요.");
					return mapRet;
				}
				logger.error("delete UncategorizedSQLException : {}",
				e.getMessage());
			} catch (Exception e) {
				logger.error("delete Exception : {}", e.getMessage());
			}
			mapRet.put("session", Integer.valueOf(1));
			mapRet.put("msg", "삭제하였습니다.");
		} catch (NullPointerException e) {
			logger.error("delete NullPointerException  : {}",
			e.getMessage());
			mapRet.put("session", Integer.valueOf(0));
			mapRet.put("msg", "갑이 존재하지 않습니다.");
		} catch (Exception e) {
			logger.error("delete Exception  : {}", e.getMessage());
			mapRet.put("session", Integer.valueOf(0));
			mapRet.put("msg", "알수없는 에러입니다.");
		}
		return mapRet;
	}
}
