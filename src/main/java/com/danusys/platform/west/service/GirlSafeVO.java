package com.danusys.platform.west.service;

import java.util.ArrayList;

import egovframework.com.cmm.ComDefaultVO;

/**
 * @Class Name : UserVO.java
 * @Description : User VO class
 * @Modification Information
 *
 * @author 배선교
 * @since 2018-
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class GirlSafeVO extends ComDefaultVO{ 
    private static final long serialVersionUID = 1L;
    
    /** seq_no */
    private String seqNo;
    private String key;
    private String name;
    private String age;
    private String phoneNumber;
    private String phoneNumber2;
    private String address;
    private String sensorId;
    private String smartId;
    private String deStatus;
    private String status;
    private String bat;
    private String deBat;
    private String emergency;
    private String pointX;
    private String pointY;
    private String pointZ;
    
    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }
    
    public String getSeqNo() {
        return seqNo;
    }

    public void setSeqNo(String seqNo) {
        this.seqNo = seqNo;
    }
    
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name= name;
    }
    
    public String getAge() {
        return age;
    }

    public void setAge(String age) {
        this.age= age;
    }
    
    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber= phoneNumber;
    }
    
    public String getPhoneNumber2() {
        return phoneNumber2;
    }

    public void setPhoneNumber2(String phoneNumber2) {
        this.phoneNumber2= phoneNumber2;
    }
   
    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address= address;
    }
    
    public String getSensorId() {
        return sensorId;
    }

    public void setSensorId(String sensorId) {
        this.sensorId= sensorId;
    }
    
    public String getSmartId() {
        return smartId;
    }

    public void setSmartId(String smartId) {
        this.smartId= smartId;
    }
    
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status= status;
    }
    
    public String getDeStatus() {
        return deStatus;
    }

    public void setDeStatus(String deStatus) {
        this.deStatus= deStatus;
    }
    
    public String getBat() {
        return bat;
    }

    public void setBat(String bat) {
        this.bat= bat;
    }
    
    public String getDeBat() {
        return deBat;
    }

    public void setDeBat(String deBat) {
        this.deBat= deBat;
    }
  
    public String getEmergency() {
        return emergency;
    }

    public void setEmergency(String emergency) {
        this.emergency= emergency;
    }
    
    public String getPointX() {
        return pointX;
    }

    public void setPointX(String pointX) {
        this.pointX= pointX;
    }
    
    public String getPointY() {
        return pointY;
    }

    public void setPointP(String pointY) {
        this.pointY= pointY;
    }
    
    public String getPointZ() {
        return pointZ;
    }

    public void setPointZ(String pointZ) {
        this.pointZ= pointZ;
    }
    
}
