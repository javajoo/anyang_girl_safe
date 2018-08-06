package com.danusys.platform.sensor.service;

public class GsonDto {
    private int siteno;
    private String type;
    private short  seq;
    private String  hh;
    private double  ou;
    private String search;
     
    public int getSiteno() {
        return siteno;
    }
    public void setSiteno(int siteno) {
        this.siteno = siteno;
    }
    public String getType() {
        return type;
    }
    public void setType(String type) {
        this.type = type;
    }
    public short getSeq() {
        return seq;
    }
    public void setSeq(short seq) {
        this.seq = seq;
    }
    public String getHh() {
        return hh;
    }
    public void setHh(String hh) {
        this.hh = hh;
    }
    public double getOu() {
        return ou;
    }
    public void setOu(double ou) {
        this.ou = ou;
    }
    public String getSearch() {
        return search;
    }
    public void setSearch(String search) {
        this.search = search;
    }
}