package com.danusys.platform.sensor.web;

import java.util.List;
import java.util.Locale;
 




import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
 




import com.danusys.platform.sensor.service.GsonDto;
import com.danusys.platform.sensor.service.impl.GsonDao;
import com.google.gson.Gson;
 
@Controller
public class GsonController {
     
    private static final Logger logger = LoggerFactory.getLogger(GsonController.class);
     
    @Autowired
    GsonDao gsonDao;
     
    @RequestMapping(value = "gsonTest", method = RequestMethod.GET)
    public String gsonTest(Locale locale, Model model) {
         
        return "gsonTest";
    }
     
    @SuppressWarnings("unchecked")
    @RequestMapping(value = "gsonList", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
    public @ResponseBody String gsonList(Locale locale, Model model) {
        Gson gson = new Gson();
         
        List<GsonDto> list = null;
        try {
            list = (List<GsonDto>) gsonDao.getJoblist();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
         
        return gson.toJson(list);
    }
     
}