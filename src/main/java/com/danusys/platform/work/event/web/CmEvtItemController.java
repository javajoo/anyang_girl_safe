package com.danusys.platform.work.event.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.jdbc.UncategorizedSQLException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.danusys.cmm.EgovUserDetailsHelper;
import com.danusys.cmm.util.CommonUtil;
import com.danusys.platform.user.service.LoginVO;
import com.danusys.platform.vo.AdminVo;
import com.danusys.platform.work.code.service.CmSysCodeService;
import com.danusys.platform.work.event.service.CmEvtItemService;

import egovframework.rte.fdl.property.EgovPropertyService;

/**
 * @Class Name : CmEvtItemController.java
 * @Description : CmEvtItem Controller class
 * @Modification Information
 *
 * @author 이인의
 * @since 2018-05-15
 * @version 1.0
 * @see Copyright (C) All right reserved.
 */

@Controller
public class CmEvtItemController {

	@Resource(name = "cmEvtItemService")
	private CmEvtItemService cmEvtItemService;

	@Resource(name = "cmSysCodeService")
	private CmSysCodeService cmSysCodeService;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	@RequestMapping({ "/com/danusys/platform/work/event/item.do" })
	public String view(@ModelAttribute("loginVO") LoginVO loginVO,
			HttpServletRequest request, HttpServletResponse response,
			ModelMap model) throws Exception {
		Map<String, Object> args = new HashMap();

		args.clear();
		args.put("cdGrpId", "PAGE_ROWS");
		args.put("cdTy", "C");
		args.put("orderBy", "ORDER BY CD_ID ASC");

		request.setAttribute("rowPerPageList",
				this.cmSysCodeService.grpList(args));

		LoginVO lgnVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		request.setAttribute(
				"rowPerPageSession",
				(lgnVO.getRowPerPage() == null)
						|| (lgnVO.getRowPerPage().equals("")) ? "15" : lgnVO
						.getRowPerPage());

		return "wrks/sstm/evnt/item";
	}

	@RequestMapping({ "/com/danusys/platform/work/event/item/list.do" })
	@ResponseBody
	public Map<String, Object> list(ModelMap model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Map<String, Object> map = new HashMap();

		String userId = request.getParameter("userId");
		String pageNo = request.getParameter("page");
		String rowsPerPage = request.getParameter("rows");
		String sidx = request.getParameter("sidx");
		String sord = request.getParameter("sord");
		String evtItemId = request.getParameter("evtItemId");
		String evtItemNm = request.getParameter("evtItemNm");

		Map<String, String> args = new HashMap();

		args.put("userId", userId);
		args.put("pageNo", pageNo);
		args.put("rowsPerPage", rowsPerPage);
		args.put("sidx", sidx);
		args.put("sord", sord);
		args.put("EVT_ITEM_ID", evtItemId);
		args.put("EVT_ITEM_NM", evtItemNm);

		List<Map<String, String>> list = this.cmEvtItemService.view(args);

		map.put("rows", list);

		map.put("page", pageNo);

		return map;
	}

	@RequestMapping({ "/com/danusys/platform/work/event/item/insert.do" })
	@ResponseBody
	public Map<String, Object> insert(ModelMap model,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		AdminVo lgnVO = (AdminVo) request.getSession().getAttribute("admin");
	    String sesUserId = lgnVO.getId();
		Map<String, Object> map = new HashMap();

		map.put("EVT_ITEM_ID", request.getParameter("evtItemId"));
		map.put("EVT_ITEM_NM", request.getParameter("evtItemNm"));
		map.put("CD_GRP_ID", request.getParameter("cdGrpId"));
		map.put("SORT_ORDR", request.getParameter("sortOrdr"));
		map.put("ITEM_GRP", request.getParameter("itemGrp"));
		map.put("RGS_USER_ID", sesUserId);
		map.put("UPD_USER_ID", sesUserId);

		Map<String, Object> mapRet = new HashMap();
		if (!CommonUtil.checkDataFilterObj(map)) {
			mapRet.put("session", Integer.valueOf(1));
			mapRet.put("msg", "특수문자를 포함한 자료는 저장할 수 없습니다.");
			return mapRet;
		}
		try {
			try {
				int insertResult = this.cmEvtItemService.insert(map);
			} catch (DataIntegrityViolationException e) {
				if (e.getRootCause().getMessage()
						.indexOf("UNIQUE constraint violation") >= 0) {
					mapRet.put("session", Integer.valueOf(0));
					mapRet.put("msg", "이미 등록된 코드입니다.");
					return mapRet;
				}
				// logger.error("Exception insert : {}", e.getMessage());
			} catch (UncategorizedSQLException e) {
				if (e.getCause().getMessage().indexOf("JDBC-590730") >= 0) {
					mapRet.put("session", Integer.valueOf(0));
					mapRet.put("msg", "이미 등록된 코드입니다.");
					return mapRet;
				}
				// logger.error("Exception insert : {}", e.getMessage());
			} catch (Exception e) {
				// logger.error("Exception insert : {}", e.getMessage());
			}
			mapRet.put("session", Integer.valueOf(1));
			mapRet.put("msg", "저장하였습니다.");
		} catch (NullPointerException e) {
			// logger.error("insert NullPointerException  : {}",
			// e.getMessage());
			mapRet.put("session", Integer.valueOf(0));
			mapRet.put("msg", "값이 존재하지 않습니다.");
		} catch (Exception e) {
			// logger.error("insert Exception  : {}", e.getMessage());
			mapRet.put("session", Integer.valueOf(0));
			mapRet.put("msg", "알수없는 에러가 발생했습니다");
		}
		return mapRet;
	}

	@RequestMapping({ "/com/danusys/platform/work/event/item/update.do" })
	@ResponseBody
	public Map<String, Object> update(ModelMap model,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		AdminVo lgnVO = (AdminVo) request.getSession().getAttribute("admin");
	    String sesUserId = lgnVO.getId();

		Map<String, Object> map = new HashMap();

		map.put("EVT_ITEM_ID", request.getParameter("evtItemId"));
		map.put("EVT_ITEM_NM", request.getParameter("evtItemNm"));
		map.put("CD_GRP_ID", request.getParameter("cdGrpId"));
		map.put("SORT_ORDR", request.getParameter("sortOrdr"));
		map.put("ITEM_GRP", request.getParameter("itemGrp"));
		map.put("UPD_USER_ID", sesUserId);
		map.put("evtItemIdBk", request.getParameter("evtItemIdBk"));

		Map<String, Object> mapRet = new HashMap();
		if (!CommonUtil.checkDataFilterObj(map)) {
			mapRet.put("session", Integer.valueOf(1));
			mapRet.put("msg", "특수문자를 포함한 자료는 저장할 수 없습니다.");
			return mapRet;
		}
		try {
			try {
				int updateResult = this.cmEvtItemService.update(map);
			} catch (DataIntegrityViolationException e) {
				// logger.error("Exception update : {}", e.getMessage());
			} catch (UncategorizedSQLException e) {
				if (e.getCause().getMessage().indexOf("JDBC-590730") >= 0) {
					mapRet.put("session", Integer.valueOf(0));
					mapRet.put("msg", "이미 등록된 코드입니다.");
					return mapRet;
				}
				// logger.error("Exception update : {}", e.getMessage());
			} catch (Exception e) {
				// logger.error("Exception update : {}", e.getMessage());
			}
			mapRet.put("session", Integer.valueOf(1));
			mapRet.put("msg", "저장하였습니다.");
		} catch (NullPointerException e) {
			// logger.error("update NullPointerException  : {}",
			// e.getMessage());
			mapRet.put("session", Integer.valueOf(0));
			mapRet.put("msg", "값이 존재하지 않습니다.");
		} catch (Exception e) {
			// logger.error("update Exception  : {}", e.getMessage());
			mapRet.put("session", Integer.valueOf(0));
			mapRet.put("msg", "알수없는 에러가 발생했습니다.");
		}
		return mapRet;
	}

	@RequestMapping({ "/com/danusys/platform/work/event/item/delete.do" })
	@ResponseBody
	public Map<String, Object> delete(ModelMap model,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		Map<String, Object> map = new HashMap();

		map.put("EVT_ITEM_ID", request.getParameter("evtItemIdBk"));

		int result = this.cmEvtItemService.delete(map);

		Map<String, Object> mapRet = new HashMap();
		if (result > 0) {
			mapRet.put("session", Integer.valueOf(1));
			mapRet.put("msg", "삭제하였습니다.");
		} else {
			mapRet.put("session", Integer.valueOf(2));
			mapRet.put("msg", "삭제실패");
		}
		return mapRet;
	}

	@RequestMapping({ "/com/danusys/platform/work/event/item/deleteMulti.do" })
	@ResponseBody
	public Map<String, Object> deleteMulti(ModelMap model,
			HttpServletRequest request, HttpServletResponse response) {
		String[] evtItemId = request.getParameterValues("evtItemId");

		List<Map<String, String>> list = new ArrayList();
		for (int i = 0; i < evtItemId.length; i++) {
			Map<String, String> mapId = new HashMap();
			mapId.put("EVT_ITEM_ID", evtItemId[i]);

			list.add(mapId);
		}
		Map<String, Object> mapRet = new HashMap();
		try {
			try {
				int ret = this.cmEvtItemService.deleteMulti(list);
			} catch (DataIntegrityViolationException e) {
				//logger.error("Exception deleteMulti : {}", e.getMessage());
			} catch (UncategorizedSQLException e) {
				if (e.getCause().getMessage().indexOf("JDBC-590730") >= 0) {
					mapRet.put("session", Integer.valueOf(0));
					mapRet.put("msg", "처리중 에러가 발생했습니다.");
					return mapRet;
				}
				//logger.error("Exception deleteMulti : {}", e.getMessage());
			} catch (Exception e) {
				//logger.error("Exception deleteMulti : {}", e.getMessage());
			}
			mapRet.put("session", Integer.valueOf(1));
			mapRet.put("msg", "삭제하였습니다.");
		} catch (NullPointerException e) {
			//logger.error("deleteMulti NullPointerException  : {}",
					e.getMessage();
			mapRet.put("session", Integer.valueOf(0));
			mapRet.put("msg", "값이 존재하지 않습니다.");
		} catch (Exception e) {
			//logger.error("deleteMulti Exception  : {}", e.getMessage());
			mapRet.put("session", Integer.valueOf(0));
			mapRet.put("msg", "알수없는 에러가 발생했습니다.");
		}
		return mapRet;
	}
}
