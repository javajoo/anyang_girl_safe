package com.danusys.platform.sensor.web;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Timer;
import java.util.TimerTask;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

import com.danusys.platform.sensor.service.ItemsService;
import com.danusys.platform.sensor.service.ItemsVO;
import com.danusys.platform.sensor.service.LastsService;
import com.danusys.platform.sensor.service.LastsVO;
import com.danusys.platform.sensor.service.OutOfRangeSensorVO;
import com.danusys.platform.west.service.EventService;
import com.danusys.platform.west.service.EventVO;
import com.danusys.platform.west.service.FacilityService;
import com.danusys.platform.west.service.IotSensorHistoryService;
import com.danusys.platform.west.service.IotSensorHistoryVO;
import com.ibm.icu.text.SimpleDateFormat;

/**
 * @Class Name : LastsController.java
 * @Description : Lasts Controller class
 * @Modification Information
 *
 * @author jun02v@danusys.com
 * @since 2018-01-16
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
@SessionAttributes(types=LastsVO.class)
public class LastsController {

    @Resource(name = "lastsService")
    private LastsService lastsService;
    
    @Resource(name = "eventService")
    private EventService eventService;
	
	@Resource(name = "iotSensorHistoryService")
	private IotSensorHistoryService iotSensorHistoryService;
	
	@Resource(name = "facilityService")
    private FacilityService facilityService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
    
    protected LastsVO lastsVO;
    protected List<LastsVO> lastsList;	// 센서 값 리스트.
    protected List<OutOfRangeSensorVO> curOutRangeList;		// 현재 임계 범위가 넘어갔던 센서 값 리스트.
    protected List<OutOfRangeSensorVO> pastOutRangeList;	// 1분 전 임계 범위가 넘어갔던 센서 값 리스트.
    
    
    /*public LastsController(LastsService lastsService) {
		super();
		this.lastsService = lastsService;
		CurSensorJob job = new CurSensorJob();
		Timer sensorScheduler = new Timer(true);
		sensorScheduler.scheduleAtFixedRate(job, 0, 10000);
		
	}*/
    
    /* IoT센서모니터링 - 모니터링 리스트조회 */
    @RequestMapping("/lasts/selectLasts.do")
    public @ResponseBody Map<String, Object> selectLasts(LastsVO lastsVO) throws Exception {
    	Map<String, Object> map = new HashMap<String, Object>();
    	List<LastsVO> list2 = new ArrayList<LastsVO>();
    	
    	if(!(lastsVO.getSearch() == "")){
    	    for(LastsVO vo : (List<LastsVO>)lastsList){
                if( vo.getName().contains(lastsVO.getSearch())){
                    list2.add(vo);
                }
            }
    	    map.put("rows", list2);
    	}
    	else {
    	    map.put("rows", lastsList);
    	}
        return map;
    }
    
    /* IoT센서모니터링 - 이벤트 히스토리 리스트조회 */
    @RequestMapping("/lasts/getIotEventHistory.do")
    public @ResponseBody Map<String, Object> getIotEventHistory(IotSensorHistoryVO vo) throws Exception {
        
        /** EgovPropertyService.sample */
        vo.setPageUnit(propertiesService.getInt("pageUnit"));
        vo.setPageIndex(vo.getPage());
        
        /** pageing */
        PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(vo.getPageIndex());
        paginationInfo.setRecordCountPerPage(vo.getPageSize());
        paginationInfo.setPageSize(vo.getPageSize());
        
        vo.setFirstIndex(paginationInfo.getFirstRecordIndex());
        vo.setLastIndex(paginationInfo.getLastRecordIndex());
        vo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
        
        List<IotSensorHistoryVO> iotSensorHistoryVO = iotSensorHistoryService.selectIotSensorHistory(vo);
        int totCnt = iotSensorHistoryService.selectIotSensorHistoryTotCnt(vo);
        paginationInfo.setTotalRecordCount(totCnt);
        
    	Map<String, Object> map = new HashMap<String, Object>();
    	//List<IotSensorHistoryVO> searchHistoryList = new ArrayList<IotSensorHistoryVO>();
    	
    	map.put("rows", iotSensorHistoryVO);
    	map.put("total", totCnt);
    	
        return map;
    }

	class CurSensorJob extends TimerTask {
		
		public void run() {
			try {
				System.out.println("run~! get sensor value!");
				lastsList = lastsService.selectLasts(lastsVO);	//현재 센서 값 리스트를 가져옴(Lasts 테이블).
				curOutRangeList = lastsService.selectOutOfRange(); // 현재 임계범위를 벗어나는 센서리스트를 DB에서 가져옴.
				//System.out.println(lastsList);
				//System.out.println(curOutRangeList);
				boolean continueFlag = false;	// 1분전 데이터와 비교해서 임계범위가 계속 넘어가 있는지 확인하는 flag.
				
				for (OutOfRangeSensorVO rVo : curOutRangeList) {
					if (pastOutRangeList != null) {
						for (OutOfRangeSensorVO rVo2 : pastOutRangeList) {
							if ((rVo.getType().equals(rVo2.getType())) && (rVo.getSiteno() == rVo2.getSiteno())) {	// 1분전 데이터와 비교, siteno와 센서타입이 같으면 넘어가도록 만든다.
								continueFlag = true;
								continue;
							}
						}
					}
					if (continueFlag) {	// 임계 범위가 넘어가 있으면, 다음 for 문을 돈다.
						System.out.println("continue! "+rVo.getSiteno()+", "+rVo.getType()+", sensor type:"+rVo.getType());
						continueFlag = false;
						continue;
					}
					
					EventVO eVO = makeEventVO(rVo);
					System.out.println("eventService: "+eventService);
					eventService.insertEvent(eVO);
					IotSensorHistoryVO iVO = makeIotHistoryVO(rVo);
					iotSensorHistoryService.insertIotSensorHistory(iVO);
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				pastOutRangeList = curOutRangeList;
			}
		}

		private EventVO makeEventVO(OutOfRangeSensorVO rVo) {
			EventVO vo = new EventVO();
			Date now = new Date();
			//Date eventDate = new Date(lVo.getDate()*1000);
			
			vo.setEventNo(rVo.getSiteno()+"_"+rVo.getType()+"_"+new SimpleDateFormat("HHmmss").format(now));
			vo.setEventType("EVENT_TYPE_6");
			//vo.setEventDe(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(eventDate));vo.setEventDe(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(eventDate));
			vo.setEventDe(rVo.getDate());
			vo.setState("EVENT_STATE_1");
			vo.setLatitude(Double.toString(rVo.getLatitude()));
			vo.setLongitude(Double.toString(rVo.getLongitude()));
			vo.setAcceptType("ACCEPT_TYPE_1");
			vo.setAcceptId("SYSTEM");
			vo.setKey(propertiesService.getString("AES_KEY"));
			if (rVo.getValue() > rVo.getHi()) {
				vo.setAcceptCont(rVo.getName()+" 에서 "+rVo.getType()+" 센서가 기준치 보다 초과 되었습니다.(현재 값 :"+rVo.getValue()+", 기준범위:"+rVo.getLo()+"~"+rVo.getHi()+")");
			} else if (rVo.getValue() < rVo.getLo()) {
				vo.setAcceptCont(rVo.getName()+" 에서 "+rVo.getType()+" 센서가 기준치 보다 미달 되었습니다.(현재 값 :"+rVo.getValue()+", 기준범위:"+rVo.getLo()+"~"+rVo.getHi()+")");
			}
			vo.setFacilityId(rVo.getSiteno()+"");
			vo.setInstId("admin");
			return vo;
		}
		
		private IotSensorHistoryVO makeIotHistoryVO(OutOfRangeSensorVO rVo) {
			IotSensorHistoryVO vo = new IotSensorHistoryVO();
			//String eventDate = new Date((int)lVo.getDate()*1000);
			
			vo.setName(rVo.getName());
			vo.setType(rVo.getType());
			vo.setValue(Double.toString(rVo.getValue()));
			vo.setThresholdLo(Double.toString(rVo.getLo()));
			vo.setThresholdHi(Double.toString(rVo.getHi()));
			vo.setDate(rVo.getDate());
			vo.setSiteNo(rVo.getSiteno());
			vo.setLatitude(rVo.getLatitude());
			vo.setLongitude(rVo.getLongitude());
			vo.setUnit(rVo.getUnit());
			return vo;
		}
	}
}