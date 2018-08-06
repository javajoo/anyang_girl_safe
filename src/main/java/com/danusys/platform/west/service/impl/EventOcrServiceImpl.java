package com.danusys.platform.west.service.impl;

import java.util.List;
import java.util.regex.PatternSyntaxException;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.danusys.cmm.util.CommonUtil;
import com.danusys.cmm.util.EventUtil;
import com.danusys.platform.west.service.EventOcrService;
import com.danusys.platform.west.service.EventOcrVO;
import com.danusys.platform.west.service.EventVO;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service("eventOcrService")
public class EventOcrServiceImpl extends EgovAbstractServiceImpl implements EventOcrService {
	static Logger logger = LoggerFactory.getLogger(EventOcrServiceImpl.class);
	
	private static String delimeter1E = "\036";
	private static String delimeter1F = "\037";
	
	@Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
	
	@Resource(name = "eventOcrDAO")
	EventOcrDAO eventOcrDAO;
	
	@Resource(name = "eventDAO")
	EventDAO eventDAO;

	public int isExistEvent(EventOcrVO vo) throws Exception {
		return this.eventOcrDAO.isExistEvent(vo);
	}

	public EgovMap selectEvent(EventOcrVO vo) throws Exception {
		return this.eventOcrDAO.selectEvent(vo);
	}

	public int selectUnfinishedEventListTotCnt(EventOcrVO vo) throws Exception {
		return this.eventOcrDAO.selectUnfinishedEventListTotCnt(vo);
	}

	public List<EgovMap> selectUnfinishedEventList(EventOcrVO vo) throws Exception {
		return this.eventOcrDAO.selectUnfinishedEventList(vo);
	}

	public List selectEventKindList(EventOcrVO vo) throws Exception {
		return this.eventOcrDAO.selectEventKindList(vo);
	}

	public List selectUsvcGrpList() throws Exception {
		return this.eventOcrDAO.selectUsvcGrpList();
	}

	public List selectEventGrpList() throws Exception {
		return this.eventOcrDAO.selectEventGrpList();
	}

	public List<EgovMap> selectEventAction(EventOcrVO vo) throws Exception {
		return this.eventOcrDAO.selectEventAction(vo);
	}

	public List<EgovMap> selectEventItem(EventOcrVO vo) throws Exception {
		return this.eventOcrDAO.selectEventItem(vo);
	}

	public List<EgovMap> selectEventImage(EventOcrVO vo) throws Exception {
		return this.eventOcrDAO.selectEventImage(vo);
	}

	public int hasAuthorityEvent(EventOcrVO vo) throws Exception {
		return this.eventOcrDAO.hasAuthorityEvent(vo);
	}

	public EgovMap selectVtalkTelNo(EventOcrVO vo) throws Exception {
		return this.eventOcrDAO.selectVtalkTelNo(vo);
	}

	public List<EgovMap> selectCarLcInfoList(EventOcrVO vo) throws Exception {
		return this.eventOcrDAO.selectCarLcInfoList(vo);
	}

	public int selectCarLcInfoListTotCnt(EventOcrVO vo) throws Exception {
		return this.eventOcrDAO.selectCarLcInfoListTotCnt(vo);
	}

	public List<EgovMap> selectCar119LcInfoList(EventOcrVO vo) throws Exception {
		return this.eventOcrDAO.selectCar119LcInfoList(vo);
	}

	public int selectCar119LcInfoListTotCnt(EventOcrVO vo) throws Exception {
		return this.eventOcrDAO.selectCar119LcInfoListTotCnt(vo);
	}

	public List<EgovMap> selectCar119LcDtlList(EventOcrVO vo) throws Exception {
		return this.eventOcrDAO.selectCar119LcDtlList(vo);
	}

	public int insertEvtOcr(EventOcrVO paramEventOcrVO) throws Exception {
		return this.eventOcrDAO.insertEvtOcr(paramEventOcrVO);
	}

	public int updateEvtOcr(EventOcrVO paramEventOcrVO) throws Exception {
		return this.eventOcrDAO.updateEvtOcr(paramEventOcrVO);
	}

	public int insertCmEvtOcrAction(EgovMap paramEgovMap) throws Exception {
		return this.eventOcrDAO.insertCmEvtOcrAction(paramEgovMap);
	}

	public int updatePrgrsEvtOcr(String paramString) throws Exception {
		return this.eventOcrDAO.updatePrgrsEvtOcr(paramString);
	}
	
	public int insertData(EventOcrVO event, String fclt_update_yn)
			throws Exception {
		String link_yn_112 = "N";
		String fclt_st_update_yn = "N";
		try {
			if (fclt_update_yn.matches(".*112.*")) {
				link_yn_112 = "Y";
			}
			if (fclt_update_yn.matches(".*fclt.*")) {
				fclt_st_update_yn = "Y";
			}
		} catch (PatternSyntaxException e) {
			logger.debug(" ==== PatternSyntaxException  ==== {}",
					e.getMessage());
		}
		String occur_fclt_id = "";
		String img_url = "";
		String image_send_ty_cd = "";
		String car_num = "";

		String apc_nm = "";
		String apc_tel_no = "";

		String trouble_gb_cd = "";
		String daepo_yn = "0";
		String evt_prgrs_cd = event.getEvtPrgrsCd();
		String evt_ocr_no = event.getEvtOcrNo();
		String evt_id = event.getEvtId();

		String evt_place = event.getEvtPlace();
		String sys_cd = event.getSysCd();
		String actionCd = event.getActionCd();
		String action_ymd_hms = event.getActionYmd();
		String evt_grad_cd = event.getEvtGradCd();
		String evt_ocr_ymd_hms = event.getEvtOcrYmdHms();

		String insert_chk = evt_prgrs_cd;
		if ("30".equals(insert_chk)) {
			insert_chk = "10";
		}
		int item_cnt;
		String[] itemArr;
		if ("10".equals(insert_chk)) {
			eventOcrDAO.insertEvtOcr(event);
			EventVO eventVO = EventUtil.eventOcrVOToEventVO(event);
			eventVO.setKey(propertiesService.getString("AES_KEY"));
			eventDAO.insertEvent(eventVO);
			logger.debug(" ==== insertEvtOcr ok ====" + evt_ocr_no);

			item_cnt = Integer.parseInt(event.getItemCnt());
			logger.debug(" ==== insertEvtOcr 항목수 ====" + event.getItemCnt());
			itemArr = event.getItemArr().split(delimeter1F, item_cnt * 2);
			EgovMap itemMap = new EgovMap();
			int itemCnt = itemArr.length;
			String val;
			for (int i = 0; i < itemCnt; i++) {
				if (("".equals(itemArr[i])) || (itemArr[i] == null)) {
					break;
				}
				String id = itemArr[i];
				i++;
				val = itemArr[i];
				itemMap.put("evtOcrNo", evt_ocr_no);
				itemMap.put("evtItemId", id);
				itemMap.put("evtOcrItemDtl", val);
				eventOcrDAO.insertEvtOcrItem(itemMap);
				if ("OCCUR_FCLT_ID".equals(id)) {
					occur_fclt_id = val;
				} else if ("IMAGE_URL".equals(id)) {
					img_url = val;
				} else if ("IMAGE_SEND_TY_CD".equals(id)) {
					image_send_ty_cd = val;
				} else if ("CAR_NUM".equals(id)) {
					car_num = val;
				} else if ("APPLICANT_NM".equals(id)) {
					apc_nm = val;
				} else if ("APPLICANT_TELNO".equals(id)) {
					apc_tel_no = val;
				}
			}
			EgovMap areaMap = new EgovMap();
			areaMap.put("evtOcrNo", evt_ocr_no);
			areaMap.put("areaCd", event.getAreaCd());
			eventOcrDAO.insertEvtOcrArea(areaMap);

			EgovMap mapRst = null;
			if (occur_fclt_id.length() > 0) {
				mapRst = eventOcrDAO.selectFcltPoint(occur_fclt_id);
				if (mapRst != null) {
					occur_fclt_id = mapRst.get("fcltId").toString();
				}
			}
			if ((("0".equals(event.getPointX())) || (event.getPointX() == null))
					&& (mapRst != null)) {
				if ((("EBSCP110".equals(evt_id)) && (evt_place.length() < 1))
						|| ("MTS".equals(sys_cd)) || ("LPR".equals(sys_cd))) {
					mapRst.put("evtOcrNo", evt_ocr_no);
					mapRst.put("evtPlace", mapRst.get("fcltLblNm").toString());
					eventOcrDAO.updateEvtOcrBuga(mapRst);
				} else {
					mapRst.put("evtOcrNo", evt_ocr_no);
					eventOcrDAO.updateEvtOcrXYZ(mapRst);
				}
			}
			if ((occur_fclt_id.length() > 0) || (img_url.length() > 0)) {
				EgovMap map2 = new EgovMap();
				map2.put("evtOcrNo", evt_ocr_no);
				map2.put("imgUrl", img_url);
				map2.put("ocrFcltId", occur_fclt_id);
				map2.put("apcNm", apc_nm);
				map2.put("apcTelNo", apc_tel_no);
				int r = eventOcrDAO.updateEvtOcrOther(map2);
				logger.debug(
						" ==== 시설물아이디/이미지URL UPDATE >>>> updateEvtOcrOther ==== image_send_ty_cd : {}, img_url : {}",
						image_send_ty_cd, img_url);
			}
		} else if ("40".equals(insert_chk) || "50".equals(insert_chk)) {
			EventVO eventVO = EventUtil.eventOcrVOToEventVO(event);
			eventVO.setKey(propertiesService.getString("AES_KEY"));
			eventDAO.insertEventUpd(eventVO);
		} else {
			eventOcrDAO.updateEvtOcr(event);
			EventVO eventVO = EventUtil.eventOcrVOToEventVO(event);
			eventVO.setKey(propertiesService.getString("AES_KEY"));
			eventDAO.insertEventEnd(eventVO);
			
			logger.debug(" ==== updateEvtOcr ok >>>>  {}", evt_ocr_no);
		}
		if (("Y".equals(fclt_st_update_yn)) && ("FCLFT101".equals(evt_id))) {
			if ("10".equals(insert_chk)) {
				if (occur_fclt_id.length() > 0) {
					item_cnt = eventOcrDAO
							.updateFacilitySttus1(occur_fclt_id);
				}
			} else if (("90".equals(evt_prgrs_cd))
					|| ("91".equals(evt_prgrs_cd))) {
				String bf_fclt_id = eventOcrDAO
						.selectEvtOctFcltId(evt_ocr_no);
				eventOcrDAO.updateFacilitySttus0(bf_fclt_id);
			}
		}
		EgovMap hisMap = new EgovMap();
		hisMap.put("evtOcrNo", evt_ocr_no);
		hisMap.put("evtPrgrsCd", evt_prgrs_cd);
		hisMap.put("actionUserId", event.getUserId());
		hisMap.put("actionUserNm", event.getUserNm());
		hisMap.put("actionYmdHms", event.getActionYmd());
		hisMap.put("actionConts", event.getActionVal());
		hisMap.put("updUserId", event.getUserId());
		if ("10".equals(evt_prgrs_cd)) {
			if (("".equals(event.getUserId())) || (event.getUserId() == null)) {
				hisMap.put("actionUserId", "SYSTEM");
				hisMap.put("updUserId", "SYSTEM");
			}
			if (("".equals(event.getUserNm())) || (event.getUserNm() == null)) {
				hisMap.put("actionUserNm", "SYSTEM");
			}
			if (("".equals(event.getActionYmd()))
					|| (event.getActionYmd() == null)) {
				hisMap.put("actionYmdHms", event.getEvtOcrYmdHms());
			}
			if (("".equals(event.getActionVal()))
					|| (event.getActionVal() == null)) {
				hisMap.put("actionConts", event.getEvtDtl());
			}
		}
		int seq_no = eventOcrDAO.insertCmEvtOcrAction(hisMap);
		logger.debug(" ==== insertCmEvtOcrAction SeqNo = {},{}",
				Integer.valueOf(seq_no), hisMap.get("seqNo"));
		if (("LPR".equals(sys_cd)) && ("91".equals(evt_prgrs_cd))
				&& ("01".equals(actionCd))) {
			logger.debug(
					" ==== 동일차량번호 체크 >> 시스템코드 = {}, 진행코드 = {}, 조치내용 = {}",
					new Object[] { sys_cd, evt_prgrs_cd, actionCd });

			String carNum = eventOcrDAO.selectCarNumEvtOcr(evt_ocr_no);

			int cnt = 0;
			List updlist = null;
			updlist = eventOcrDAO.selectPrgrsUpdateList(carNum);
			cnt = updlist.size();

			EgovMap tmpMap = new EgovMap();
			for (int i = 0; i < cnt; i++) {
				tmpMap = (EgovMap) updlist.get(i);
				eventOcrDAO.updatePrgrsEvtOcr(tmpMap.get("evtOcrNo")
						.toString());
				eventOcrDAO.updateStepCdVhcleOcr(tmpMap.get("evtOcrNo")
						.toString());

				EgovMap hMap = new EgovMap();
				hMap.put("evtOcrNo", evt_ocr_no);
				hMap.put("evtPrgrsCd", "92");
				hMap.put("actionUserId", "SYSTEM");
				hMap.put("actionUserNm", "SYSTEM");
				hMap.put("actionYmdHms", action_ymd_hms);
				hMap.put("actionConts", "동일번호자동처리");
				hMap.put("updUserId", "SYSTEM");
				eventOcrDAO.insertCmEvtOcrAction(hMap);
			}
		} else if ((("WLISF110".equals(evt_id)) || ("STLSF110".equals(evt_id)))
				&& ("10".equals(evt_prgrs_cd))) {
			int cntIdNo = 0;
			List updlistIdNo = null;
			updlistIdNo = eventOcrDAO
					.selectPrgrsUpdateListIdNo(evt_ocr_no);
			cntIdNo = updlistIdNo.size();

			EgovMap tmpMap = new EgovMap();
			for (int i = 0; i < cntIdNo; i++) {
				tmpMap = (EgovMap) updlistIdNo.get(i);
				eventOcrDAO.updatePrgrsEvtOcr(tmpMap.get("evtOcrNo")
						.toString());

				EgovMap hMap = new EgovMap();
				hMap.put("evtOcrNo", evt_ocr_no);
				hMap.put("evtPrgrsCd", "92");
				hMap.put("actionUserId", "SYSTEM");
				hMap.put("actionUserNm", "SYSTEM");
				hMap.put("actionYmdHms", action_ymd_hms);
				hMap.put("actionConts", "동일고유번호자동처리");
				hMap.put("updUserId", "SYSTEM");
				eventOcrDAO.insertCmEvtOcrAction(hMap);
			}
		}
		/*if (("20".equals(evt_prgrs_cd)) || ("30".equals(evt_prgrs_cd))) {
			EgovMap todoMap = new EgovMap();
			todoMap.put("workId", evt_ocr_no);
			todoMap.put("workTitle", event.getEvtNm());
			todoMap.put("workReqYmdHms", event.getRceptYmdHms());
			todoMap.put("workReqUserId", event.getRceptUserId());
			todoMap.put("workReqUserNm", event.getRceptUserNm());
			todoMap.put("workRpsbUserId", event.getRceptUserId());
			todoMap.put("workRpsbUserNm", event.getRceptUserNm());
			todoMap.put("workSttusTyCd", "P");
			todoMap.put("workTyCd", "SITUATION");

			eventOcrDAO.insertUwTodoMng(todoMap);
		}*/
		/*if (("90".equals(evt_prgrs_cd)) || ("91".equals(evt_prgrs_cd))
				|| ("92".equals(evt_prgrs_cd))) {
			EgovMap todoMap = new EgovMap();
			todoMap.put("workId", evt_ocr_no);
			todoMap.put("workSttusTyCd", "C");
			eventOcrDAO.updateUwTodoMng(todoMap);
		}*/
		if (("LPR".equals(sys_cd))
				&& (("90".equals(evt_prgrs_cd)) || ("91".equals(evt_prgrs_cd))
						|| ("92".equals(evt_prgrs_cd)) || ("20"
							.equals(evt_prgrs_cd)))) {
			EgovMap cMap = new EgovMap();
			cMap.put("evt_ocr_no", evt_ocr_no);
			if ("92".equals(evt_prgrs_cd)) {
				cMap.put("event_step_cd", "90");
			} else {
				cMap.put("event_step_cd", evt_prgrs_cd);
			}
			cMap.put("userId", event.getUserId());
			cMap.put("EVENT_STEP_RESON_CD", event.getActionCd());
			cMap.put("ETC_RSN", event.getActionEtc());

			eventOcrDAO.updateUcIntrstVhcleOcr(cMap);
			logger.debug(
					" ==== 관심차량발생 상태정보 update >>>> UcIntrstVhcleOcr : {}",
					evt_ocr_no);
		}
		if ("90".equals(evt_grad_cd)) {
			String evtid_sys_cd = evt_id.substring(0, 3);
			if ("LPR".equals(evtid_sys_cd)) {
				if ("LPRUM104".equals(evt_id)) {
					trouble_gb_cd = "05";
					daepo_yn = "1";
				} else {
					trouble_gb_cd = "03";
					daepo_yn = "0";
				}
				EgovMap cMap = new EgovMap();
				cMap.put("evt_ocr_no", evt_ocr_no);
				cMap.put("event_send_dt", evt_ocr_ymd_hms.substring(0, 8));
				cMap.put("event_send_tm", evt_ocr_ymd_hms.substring(8, 14));
				cMap.put("trouble_gb_cd", trouble_gb_cd);
				cMap.put("cctv_no", occur_fclt_id);
				cMap.put("lpr_seq", evt_ocr_no);
				cMap.put("event_step_cd", evt_prgrs_cd);
				cMap.put("event_step_reson_cd", "00");
				cMap.put("car_license_no", car_num);
				cMap.put("car_img_file_nm", img_url);
				cMap.put("unpaid_cnt", Integer.valueOf(1));
				cMap.put("unpaid_amt", Integer.valueOf(1500000));
				cMap.put("tax_send_yn", "N");
				cMap.put("fine_send_yn", "N");
				cMap.put("pol_send_yn", "N");
				cMap.put("entrust_yn", "1");
				cMap.put("daepo_yn", daepo_yn);
				cMap.put("regr_id", "SYSTEM");
				cMap.put("updr_id", "SYSTEM");
				cMap.put("approve_user_id", "SYSTEM");
				cMap.put("updr_id", "SYSTEM");
				if (("10".equals(evt_prgrs_cd)) || ("30".equals(evt_prgrs_cd))) {
					eventOcrDAO.insertUcIntrstVhcleOcr(cMap);
				} else {
					eventOcrDAO.updateUcIntrstVhcleOcr(cMap);
				}
				logger.debug(" ==== 관심차량발생 등록/수정 >>>> UcIntrstVhcleOcr");
			}
		}
		if (("Y".equals(link_yn_112)) && ("10".equals(insert_chk))) {
			logger.debug(" ==== 112연계처리 >>>> ocr_no:{}", evt_ocr_no);
			EgovMap map112 = eventOcrDAO
					.select112Event(evt_ocr_no);
			if (map112 != null) {
				map112.put("mtmdaPrcsState", "요청");
				map112.put("mtmdaPrcsTyCd", "10");
				map112.put("prcsTyYmdHms", CommonUtil.getCurrentTime14());
				map112.put("receptYmd", CommonUtil.getCurrentTime8());
				map112.put("rgsUserId", "SYSTEM");
				if ((map112.get("evtSubTit") == null)
						|| ("".equals(map112.get("evtSubTit")))) {
					map112.put("title", map112.get("evtNm"));
				} else {
					map112.put("title", map112.get("evtSubTit"));
				}
				int r112 = eventOcrDAO.insert112info(map112);

				map112.put("imgTyCd", "0");
				map112.put("seqNo", Integer.valueOf(0));
				r112 = eventOcrDAO.insert112image(map112);
			}
		}
		return 0;
	}

	public int selectEvtOctCount2(EgovMap map) throws Exception {
		int r = eventOcrDAO.selectEvtOctCount2(map);
		return r;
	}

	public int selectEvtOctCount(String id) throws Exception {
		int r = eventOcrDAO.selectEvtOctCount(id);
		return r;
	}

	public EgovMap selectEvtNm(EgovMap map) throws Exception {
		EgovMap r = eventOcrDAO.selectEvtNm(map);
		return r;
	}

	public EgovMap selectFcltInfo(String id) throws Exception {
		EgovMap r = eventOcrDAO.selectFcltPoint(id);
		return r;
	}

	/*public List<EgovMap> selectReportList(CommonVO vo) throws Exception {
		return this.eventOcrDAO.selectReportList(vo);
	}

	public int selectReportListTotCnt(CommonVO vo) throws Exception {
		return this.eventOcrDAO.selectReportListTotCnt(vo);
	}*/
}
