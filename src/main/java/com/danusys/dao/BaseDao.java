package com.danusys.dao;

import java.util.List;
import java.util.Map;

/*
//  인터페이스  명 : BaseDao (기본 Dao)
//  인터페이스설명 : BaseDao (기본 Dao) 인터페이스
*/
public interface BaseDao
{
    // List 조회
    public <T> List<T> baseSelectList(String sqlid, Map<String, Object> param);

    // 단건 조회
    public String baseSelectOne(String sqlid, Map<String, Object> param);

    // 등록 (Insert Key 반환)
    public String baseInsertReturnSelectKey(String sqlid, Map<String, Object> param);

    // 등록
    public int baseInsert(String sqlid, Map<String, Object> param);

    // 수정
    public int baseUpdate(String sqlid, Map<String, Object> param);

    // 삭제
    public int baseDelete(String sqlid, Map<String, Object> param);



}
