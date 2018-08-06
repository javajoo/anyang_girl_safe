package com.danusys.platform.code.service;

import java.util.ArrayList;

/**
 * @Class Name : CodeVO.java
 * @Description : Code VO class
 * @Modification Information
 *
 * @author 김하울
 * @since 2017-12-13
 * @version 1.0
 * @see
 *  
 *  Copyright (C)  All right reserved.
 */
public class CodeVO {
    /** seq_no */
    private String seqNo;
    private ArrayList<String> seqNoList;
    
    /** code_cd */
    private String codeCd;
    
    /** code_nm */
    private String codeNm;
    
    /** code_group */
    private String codeGroup;
    
    /** cont */
    private String cont;
    
    /** inst_id */
    private String instId;
    
    /** upd_id */
    private String updId;
    
    /** upd_ty_cd */
    private String useTyCd;
    
    /** code_id */
    private String codeId;
    
    /** usvc_grp_cd */
    private String usvcGrpCd;
    
    /** std_evt_yn */
    private String stdEvtYn;
    
    /** sys_cd */
    private String sysCd;
    
    /** all */
    private String all;

    public String getSeqNo() {
        return seqNo;
    }

    public void setSeqNo(String seqNo) {
        this.seqNo = seqNo;
    }

    public ArrayList<String> getSeqNoList() {
        return seqNoList;
    }

    public void setSeqNoList(ArrayList<String> seqNoList) {
        this.seqNoList = seqNoList;
    }

    public String getCodeCd() {
        return codeCd;
    }

    public void setCodeCd(String codeCd) {
        this.codeCd = codeCd;
    }

    public String getCodeNm() {
        return codeNm;
    }

    public void setCodeNm(String codeNm) {
        this.codeNm = codeNm;
    }

    public String getCodeGroup() {
        return codeGroup;
    }

    public void setCodeGroup(String codeGroup) {
        this.codeGroup = codeGroup;
    }

    public String getCont() {
        return cont;
    }

    public void setCont(String cont) {
        this.cont = cont;
    }

    public String getInstId() {
        return instId;
    }

    public void setInstId(String instId) {
        this.instId = instId;
    }

    public String getUpdId() {
        return updId;
    }

	public void setUpdId(String updId) {
        this.updId = updId;
    }
	
	public String getUseTyCd() {
		return useTyCd;
	}

	public void setUseTyCd(String useTyCd) {
		this.useTyCd = useTyCd;
	}

	public String getCodeId() {
		return codeId;
	}

	public void setCodeId(String codeId) {
		this.codeId = codeId;
	}

	public String getUsvcGrpCd() {
		return usvcGrpCd;
	}

	public void setUsvcGrpCd(String usvcGrpCd) {
		this.usvcGrpCd = usvcGrpCd;
	}

	public String getStdEvtYn() {
		return stdEvtYn;
	}

	public void setStdEvtYn(String stdEvtYn) {
		this.stdEvtYn = stdEvtYn;
	}

	public String getSysCd() {
		return sysCd;
	}

	public void setSysCd(String sysCd) {
		this.sysCd = sysCd;
	}

    public String getAll() {
        return all;
    }

    public void setAll(String all) {
        this.all = all;
    }
}
