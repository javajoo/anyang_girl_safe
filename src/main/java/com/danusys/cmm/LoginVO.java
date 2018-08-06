package com.danusys.cmm;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

public class LoginVO
implements Serializable
{
    private static final long serialVersionUID = -8274004534207618049L;
    private String id;
    private String pwd;
    private String phoneNo;
    private String userId;
    private String password;
    private String userNmKo;
    private String userNmEn;
    private String useTyCd;
    private String moblNo;
    private String email;
    private String ipAdres;
    private String offcTelNo;
    private String rankNm;
    private String deptNm;
    private String insttNm;
    private String chrgWork;
    private String rowPerPage;
    private String remark;
    private String rgsUserId;
    private String rgsDate;
    private String updUserId;
    private String updDate;
    private String ipTyCd;
    private String ipCd;
    private String grpId;
    private String grpNmKo;
    private String authLvlNm;
    private String sysId;
    private String sysCd;
    private String menuSysNm;
    private Map<String, Object> leftMenuMap;
    private List<Map<String, String>> topMenuList;
    
    public String getUserId()
    {
      if (this.userId == null) {
        return "";
      }
      return this.userId;
    }
    
    public void setUserId(String userId)
    {
      this.userId = userId;
    }
    
    public String getPassword()
    {
      return this.password;
    }
    
    public void setPassword(String password)
    {
      this.password = password;
    }
    
    public String getUserNmKo()
    {
      return this.userNmKo;
    }
    
    public void setUserNmKo(String userNmKo)
    {
      this.userNmKo = userNmKo;
    }
    
    public String getUserNmEn()
    {
      return this.userNmEn;
    }
    
    public void setUserNmEn(String userNmEn)
    {
      this.userNmEn = userNmEn;
    }
    
    public String getUseTyCd()
    {
      return this.useTyCd;
    }
    
    public void setUseTyCd(String useTyCd)
    {
      this.useTyCd = useTyCd;
    }
    
    public String getMoblNo()
    {
      return this.moblNo;
    }
    
    public void setMoblNo(String moblNo)
    {
      this.moblNo = moblNo;
    }
    
    public String getEmail()
    {
      return this.email;
    }
    
    public void setEmail(String email)
    {
      this.email = email;
    }
    
    public String getIpAdres()
    {
      return this.ipAdres;
    }
    
    public void setIpAdres(String ipAdres)
    {
      this.ipAdres = ipAdres;
    }
    
    public String getOffcTelNo()
    {
      return this.offcTelNo;
    }
    
    public void setOffcTelNo(String offcTelNo)
    {
      this.offcTelNo = offcTelNo;
    }
    
    public String getRankNm()
    {
      return this.rankNm;
    }
    
    public void setRankNm(String rankNm)
    {
      this.rankNm = rankNm;
    }
    
    public String getDeptNm()
    {
      return this.deptNm;
    }
    
    public void setDeptNm(String deptNm)
    {
      this.deptNm = deptNm;
    }
    
    public String getInsttNm()
    {
      return this.insttNm;
    }
    
    public void setInsttNm(String insttNm)
    {
      this.insttNm = insttNm;
    }
    
    public String getChrgWork()
    {
      return this.chrgWork;
    }
    
    public void setChrgWork(String chrgWork)
    {
      this.chrgWork = chrgWork;
    }
    
    public String getRowPerPage()
    {
      return "10";
    }
    
    public void setRowPerPage(String rowPerPage)
    {
      this.rowPerPage = rowPerPage;
    }
    
    public String getRemark()
    {
      return this.remark;
    }
    
    public void setRemark(String remark)
    {
      this.remark = remark;
    }
    
    public String getRgsUserId()
    {
      return this.rgsUserId;
    }
    
    public void setRgsUserId(String rgsUserId)
    {
      this.rgsUserId = rgsUserId;
    }
    
    public String getRgsDate()
    {
      return this.rgsDate;
    }
    
    public void setRgsDate(String rgsDate)
    {
      this.rgsDate = rgsDate;
    }
    
    public String getUpdUserId()
    {
      return this.updUserId;
    }
    
    public void setUpdUserId(String updUserId)
    {
      this.updUserId = updUserId;
    }
    
    public String getUpdDate()
    {
      return this.updDate;
    }
    
    public void setUpdDate(String updDate)
    {
      this.updDate = updDate;
    }
    
    public String getIpTyCd()
    {
      return this.ipTyCd;
    }
    
    public void setIpTyCd(String ipTyCd)
    {
      this.ipTyCd = ipTyCd;
    }
    
    public String getIpCd()
    {
      return this.ipCd;
    }
    
    public void setIpCd(String ipCd)
    {
      this.ipCd = ipCd;
    }
    
    public String getGrpId()
    {
      return this.grpId;
    }
    
    public void setGrpId(String grpId)
    {
      this.grpId = grpId;
    }
    
    public String getGrpNmKo()
    {
      return this.grpNmKo;
    }
    
    public void setGrpNmKo(String grpNmKo)
    {
      this.grpNmKo = grpNmKo;
    }
    
    public String getAuthLvlNm()
    {
      return this.authLvlNm;
    }
    
    public void setAuthLvlNm(String authLvlNm)
    {
      this.authLvlNm = authLvlNm;
    }
    
    public List<Map<String, String>> getTopMenuList()
    {
      return this.topMenuList;
    }
    
    public void setTopMenuList(List<Map<String, String>> topMenuList)
    {
      this.topMenuList = topMenuList;
    }
    
    public Map<String, Object> getLeftMenuMap()
    {
      return this.leftMenuMap;
    }
    
    public void setLeftMenuMap(Map<String, Object> leftMenuList)
    {
      this.leftMenuMap = leftMenuList;
    }
    
    public String getSysId()
    {
      return this.sysId;
    }
    
    public void setSysId(String sysId)
    {
      this.sysId = sysId;
    }
    
    public String getMenuSysNm()
    {
      return this.menuSysNm;
    }
    
    public void setMenuSysNm(String menuSysNm)
    {
      this.menuSysNm = menuSysNm;
    }
    
    public String getSysCd()
    {
      return this.sysCd;
    }
    
    public void setSysCd(String sysCd)
    {
      this.sysCd = sysCd;
    }
    public String getId() {
        return id;
    }
    
    public void setId(String id) {
        this.id = id;
    }
    
    public String getPwd() {
        return pwd;
    }
    
    public void setPwd(String pwd) {
        this.pwd = pwd;
    }
    
    public String getPhoneNo() {
        return phoneNo;
    }
    
    public void setPhoneNo(String phoneNo) {
        this.phoneNo = phoneNo;
    }

}