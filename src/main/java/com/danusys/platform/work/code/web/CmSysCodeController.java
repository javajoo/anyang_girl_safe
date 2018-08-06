package com.danusys.platform.work.code.web;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.danusys.cmm.EgovUserDetailsHelper;
import com.danusys.cmm.util.CommonUtil;
import com.danusys.platform.user.service.LoginVO;
import com.danusys.platform.work.code.service.CmSysCodeService;

import egovframework.rte.fdl.property.EgovPropertyService;

/**
 * @Class Name : CmSysCodeController.java
 * @Description : CmSysCode Controller class
 * @Modification Information
 *
 * @author 이인의
 * @since 2018-05-14
 * @version 1.0
 * @see Copyright (C) All right reserved.
 */

@Controller
public class CmSysCodeController {

	@Resource(name = "cmSysCodeService")
	private CmSysCodeService cmSysCodeService;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	@RequestMapping({ "/com/danusys/platform/work/code/cmcd.do" })
	public String view(HttpServletRequest request,
			HttpServletResponse response, ModelMap model) throws Exception {
		Map<String, Object> args = new HashMap();

		args.put("cdGrpId", "USE_TY");
		args.put("cdTy", "C");
		args.put("orderBy", "ORDER BY CD_ID DESC");

		request.setAttribute("useGrpList", this.cmSysCodeService.grpList(args));

		args.clear();
		args.put("sysCd", "sysCd");
		request.setAttribute("sysNmList", this.cmSysCodeService.grpList(args));

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

		return "wrks/sstm/code/cmcd";
	}

	@RequestMapping({ "/com/danusys/platform/work/code/list.do" })
	@ResponseBody
	public Map<String, Object> list(ModelMap model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Map<String, Object> map = new HashMap();

		String userId = request.getParameter("userId");
		String pageNo = request.getParameter("page");
		String rowsPerPage = request.getParameter("rows");
		String sidx = request.getParameter("sidx");
		String sord = request.getParameter("sord");
		String groupId = request.getParameter("groupId");
		String groupNm = request.getParameter("groupNm");
		String useTyCd = request.getParameter("useTyCd");

		Map<String, String> args = new HashMap();

		args.put("userId", userId);
		args.put("pageNo", pageNo);
		args.put("rowsPerPage", rowsPerPage);
		args.put("sidx", sidx);
		args.put("sord", sord);
		args.put("CD_GRP_ID", groupId);
		args.put("CD_GRP_NM", groupNm);
		args.put("USE_TY_CD", useTyCd);

		List<Map<String, String>> list = this.cmSysCodeService.view(args);

		map.put("rows", list);
		map.put("page", pageNo);

		return map;
	}

	@RequestMapping({ "/com/danusys/platform/work/code/insert.do" })
	@ResponseBody
	public Map<String, Object> insert(ModelMap model,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		LoginVO lgnVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		String sesUserId = lgnVO.getUserId();

		Map<String, Object> map = new HashMap();

		map.put("CD_GRP_ID", request.getParameter("cdGrpId"));
		map.put("CD_NM_KO", request.getParameter("cdNmKo"));
		map.put("SYS_CD", request.getParameter("sysCd"));
		map.put("CD_NM_EN", request.getParameter("cdNmEn"));
		map.put("USE_TY_CD", request.getParameter("useTyCd"));
		map.put("CD_DSCRT", request.getParameter("cdDscrt"));
		map.put("RGS_USER_ID", sesUserId);

		Map<String, Object> mapRet = new HashMap();
		if (!CommonUtil.checkDataFilterObj(map)) {
			mapRet.put("session", Integer.valueOf(0));
			mapRet.put("msg", "특수문자를 포함한 자료는 저장할 수 없습니다.");
			return mapRet;
		}
		try {
			try {
				int insertResult = this.cmSysCodeService.insert(map);
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
			mapRet.put("session", Integer.valueOf(0));
			mapRet.put("msg", "값이 존재하지 않습니다.");
			// logger.error("insert NullPointerException : {}", e.getMessage());
		} catch (Exception e2) {
			mapRet.put("session", Integer.valueOf(0));
			mapRet.put("msg", "알수없는 에러가 발생했습니다.");
			// logger.error("insert Exception : {}", e2.getMessage());
		}
		return mapRet;
	}

	@RequestMapping({ "/com/danusys/platform/work/code/delete.do" })
	@ResponseBody
	public Map<String, Object> delete(ModelMap model,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		LoginVO lgnVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		String sesUserId = lgnVO.getUserId();

		Map<String, Object> map = new HashMap();

		map.put("CD_GRP_ID", request.getParameter("cdGrpIdBk"));
		map.put("UPD_USER_ID", sesUserId);

		int ret = this.cmSysCodeService.delete(map);

		Map<String, Object> mapRet = new HashMap();

		mapRet.put("session", Integer.valueOf(1));
		mapRet.put("msg", "삭제하였습니다.");

		return mapRet;
	}

	@RequestMapping({ "/com/danusys/platform/work/code/update.do" })
	@ResponseBody
	public Map<String, Object> update(ModelMap model,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		LoginVO lgnVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		String sesUserId = lgnVO.getUserId();

		Map<String, Object> map = new HashMap();

		map.put("CD_GRP_ID", request.getParameter("cdGrpId"));
		map.put("CD_NM_KO", request.getParameter("cdNmKo"));
		map.put("SYS_CD", request.getParameter("sysCd"));
		map.put("CD_NM_EN", request.getParameter("cdNmEn"));
		map.put("USE_TY_CD", request.getParameter("useTyCd"));
		map.put("CD_DSCRT", request.getParameter("cdDscrt"));
		map.put("UPD_USER_ID", sesUserId);
		map.put("cdGrpIdBk", request.getParameter("cdGrpIdBk"));

		Map<String, Object> mapRet = new HashMap();
		if (!CommonUtil.checkDataFilterObj(map)) {
			mapRet.put("session", Integer.valueOf(1));
			mapRet.put("msg", "특수문자를 포함한 자료는 저장할 수 없습니다.");
			return mapRet;
		}
		try {
			try {
				int updateResult = this.cmSysCodeService.update(map);
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
			mapRet.put("session", Integer.valueOf(0));
			mapRet.put("msg", "값이 존재하지 않습니다.");
			// logger.error("update NullPointerException : {}", e.getMessage());
		} catch (Exception e2) {
			mapRet.put("session", Integer.valueOf(0));
			mapRet.put("msg", "알수없는 에럭 발생했습니다.");
			// logger.error("update Exception : {}", e2.getMessage());
		}
		return mapRet;
	}

	@RequestMapping({ "/com/danusys/platform/work/code/deleteMulti.do" })
	@ResponseBody
	public Map<String, Object> deleteMulti(ModelMap model,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		LoginVO lgnVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		String sesUserId = lgnVO.getUserId();

		String[] cdGrpIds = request.getParameterValues("cdGrpId");

		List<Map<String, String>> list = new ArrayList();
		for (int i = 0; i < cdGrpIds.length; i++) {
			Map<String, String> mapId = new HashMap();

			mapId.put("CD_GRP_ID", cdGrpIds[i]);
			mapId.put("UPD_USER_ID", sesUserId);

			list.add(mapId);
		}
		Map<String, Object> mapRet = new HashMap();
		try {
			try {
				int ret = this.cmSysCodeService.deleteMulti(list);
			} catch (DataIntegrityViolationException e) {
				// logger.error("Exception deleteMulti : {}", e.getMessage());
			} catch (UncategorizedSQLException e) {
				if (e.getCause().getMessage().indexOf("JDBC-590730") >= 0) {
					mapRet.put("session", Integer.valueOf(0));
					mapRet.put("msg", "처리중 에러가 발생했습니다.");
					return mapRet;
				}
				// logger.error("Exception deleteMulti : {}", e.getMessage());
			} catch (Exception e) {
				// logger.error("Exception deleteMulti : {}", e.getMessage());
			}
			mapRet.put("session", Integer.valueOf(1));
			mapRet.put("msg", "삭제하였습니다.");
		} catch (NullPointerException e) {
			mapRet.put("session", Integer.valueOf(0));
			mapRet.put("msg", "갑이 존재하지 않습니다.");
			// logger.error("deleteMulti NullPointerException : {}",
			// e.getMessage());
		} catch (Exception e2) {
			mapRet.put("session", Integer.valueOf(0));
			mapRet.put("msg", "알수없는 에러가 발생했습니다.");
			// logger.error("deleteMulti Exception : {}", e2.getMessage());
		}
		return mapRet;
	}

	@RequestMapping({ "/com/danusys/platform/work/code/grpList.do" })
	@ResponseBody
	public Map<String, Object> grpList(ModelMap model,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		Map<String, Object> map = new HashMap();

		Map<String, Object> args = new HashMap();

		args.put("cdGrpId", request.getParameter("cdGrpId"));
		args.put("cdTy", "C");
		args.put("orderBy", "ORDER BY CD_ID ASC");

		List<Map<String, String>> list = this.cmSysCodeService.grpList(args);

		map.put("rows", list);

		return map;
	}

	@RequestMapping({ "/com/danusys/platform/work/code/sysList.do" })
	@ResponseBody
	public Map<String, Object> sysList(ModelMap model,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		Map<String, Object> args = new HashMap();

		String usvcGrpCd = request.getParameter("usvcGrpCd");
		args.put("USVC_GRP_CD", usvcGrpCd);

		List<Map<String, String>> list = this.cmSysCodeService.sysList(args);
		Map<String, Object> map = new HashMap();

		map.put("syscd", list);
		return map;
	}

}
