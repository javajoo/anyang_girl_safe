package com.danusys.platform.sensor.web;

import java.io.Reader;
import java.io.StringWriter;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONException;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

import com.danusys.platform.gis.service.CctvTreeVO;
import com.danusys.platform.sensor.service.DatasService;
import com.danusys.platform.sensor.service.DatasVO;
import com.danusys.platform.sensor.service.GsonDto;
import com.danusys.platform.sensor.service.OutOfRangeSensorVO;
import com.danusys.platform.web.JSONResult;
import com.google.gson.JsonElement;
import com.ibatis.sqlmap.client.SqlMapClient;

/**
 * @Class Name : DatasController.java
 * @Description : Datas Controller class
 * @Modification Information
 *
 * @author 김동식
 * @since 2018-01-18
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */

@Controller
@SessionAttributes(types=GsonDto.class)
public class DatasController {
    private static final Logger LOGGER = LoggerFactory.getLogger(DatasController.class);
    
    @Resource(name = "datasService")
    private DatasService datasService;
    
    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
    protected DatasVO DatasVO;
    protected List<DatasVO> datasList;
    protected List<?> list;
    
  
   
    /*@RequestMapping("/datas/selectDatas.do")
    public @ModelAttribute("datasVO")
    DatasVO selectDatas(
            DatasVO datasVO,
            @ModelAttribute("searchVO") DatasDefaultVO searchVO) throws Exception {
        return datasService.selectDatas(datasVO);
    }*/
 
    @RequestMapping("/lasts/selectDatas.do")
    public @ResponseBody Map<String, Object> selectDatasList(DatasVO datasVO) throws Exception {
        Map<String, Object> map = new HashMap<String, Object>();
        List<DatasVO> list2 = new ArrayList<DatasVO>();
        
        if(!(datasVO.getSearch() == "")){
            for(DatasVO vo : (List<DatasVO>)datasList){
                //if( vo.getSiteno().(datasVO.getSearch() ){
                    list2.add(vo);
                //}
            }
            map.put("rows", list2);
        }
        else {
            map.put("rows", datasList);
        }
        return map;
    }
    
    /* IoT센서모니터링 - 모니터링 차트리스트조회 */
    /*@RequestMapping(value="/datas/selectDatasMT.do")
    public @ResponseBody List<?> selectDatas(GsonDto vo, HttpServletRequest request) throws Exception {
        LOGGER.info( "\n\n\n\n\n\n@@test1 ......................." );
        //List<?> list2 = (List<?>) datasService.selectDatasMT();
      
        //Map<?,?> list2 = (Map<?,?>) datasService.selectDatasMT();
        
        SqlMapClient smc = null;
        Map<?, ?> list3 =  smc.queryForMap("datasDAO.selectDatas_T", null, "hh", "ou");
        Iterator<?> keySet = list3.keySet().iterator();
        while(keySet.hasNext()){
            String key = (String)keySet.next();
            GsonDto user = (GsonDto)list3.get(key);
            System.out.println(key + "========================="+user);
            
        }
        //List<DatasVO> placeList = new ArrayList<>();
        
        JSONObject obj = new JSONObject(); 
        json.put("data1", list.get(0));
        json.put("data2", list.get(0));
        return json;
   
        JSONArray listTitle = new JSONArray();
        JSONArray listOu = new JSONArray();
        List<?> list2 = datasService.selectDatas(vo);
        listTitle.add("0");
        listTitle.add("1");
        listTitle.add("2");
        listTitle.add("3");
        listTitle.add("4");
        listTitle.add("5");
        listTitle.add("6");
        listTitle.add("7");
        listTitle.add("8");
        listTitle.add("9");
        listTitle.add("10");
        listTitle.add("11");
        listTitle.add("12");
        listTitle.add("13");
        listTitle.add("14");
        listTitle.add("15");
        listTitle.add("16");
        listTitle.add("17");
        listTitle.add("18");
        listTitle.add("19");
        listTitle.add("20");
        listTitle.add("21");
        listTitle.add("22");
        listTitle.add("23");
        obj.put("x", listTitle);
        //for (DatasVO v : datasService.selectDatas(vo)) {
        System.out.println("@@test ============================================= ");
        Iterator<?> iterator = list2.iterator();
        while (iterator.hasNext()) {
            listOu.add(iterator.next());
            System.out.println(iterator.next());
        }
        obj.put("aaa", list2.get(0));
        //obj.put("악취농도", list2);
        //System.out.println("@@test "+vo.getSiteno()+", "+vo.getOu()+", val:"+vo.getDate());
        JSONArray obj = new JSONArray();
        JSONObject jsonObject = (JSONObject) list2;
        JSONArray msg = (JSONArray) jsonObject.get("ou");
        Iterator<String> itr = msg.iterator();
        while (itr.hasNext()){
            System.out.println(itr.next());
            obj.add(itr.next());
        }
        return obj;
        
       
        JSONArray obj = new JSONArray();
        try {
            obj.add(list2);//배열을 넣음
        } catch (JSONException e) {
            e.printStackTrace();
        }
        //list.add("foo"); list.add(new Integer(100));
        //list.add(new Double(1000.21)); list.add(new Boolean(true)); list.add(null); 
        
        //return list2;
    
    }*/
    

    //@RequestMapping(value = "/datas/selectList.do", method = RequestMethod.GET, produces = "application/json")
/*    @RequestMapping(value = "/datas/selectList.do")
    public @ResponseBody List<?> selectDatas(DatasVO vo) throws Exception {
        LOGGER.info( "\n\n\n\n\n\n@@test2 ......................." );
        List<?> list2 = datasService.selectDatas(vo);
        Map<String, Object> paramMap = new HashMap<String, Object>();
        paramMap.put("data1", list2);
        //MAP의 KEY값을 이용하여 VALUE값 가져오기
        for (String mapkey : paramMap.keySet()){
            System.out.println("Key:"+mapkey+", Value:"+paramMap.get(mapkey));
        }
        return list2;
  
    }*/
    @RequestMapping("/datas/selectDatasMT.do")
    public @ResponseBody List<?> selectDatasM(DatasVO vo) throws Exception {
        return this.datasService.selectDatas(vo);
    }
    @RequestMapping("/datas/selectDatasHT.do")
    public @ResponseBody List<?> selectDatasH(DatasVO vo) throws Exception {
        return this.datasService.selectDatas(vo);
    }
    @RequestMapping("/datas/selectDatasMS.do")
    public @ResponseBody List<?> selectDatasMS(DatasVO vo) throws Exception {
        return this.datasService.selectDatasMS(vo);
    }
    @RequestMapping("/datas/selectDatasHS.do")
    public @ResponseBody List<?> selectDatasHS(DatasVO vo) throws Exception {
        return this.datasService.selectDatasHS(vo);
    }
}
