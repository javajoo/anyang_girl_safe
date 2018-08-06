package com.danusys.platform.sensor.service.impl;

import org.springframework.stereotype.Repository;

import com.danusys.platform.sensor.service.GsonDto;
 
@Repository
public class GsonDao extends EgovComSensorDAO{
      
    public GsonDto getJoblist() throws Exception {
        return (GsonDto) select("datasDAO.selectDatas_T");
    }
}