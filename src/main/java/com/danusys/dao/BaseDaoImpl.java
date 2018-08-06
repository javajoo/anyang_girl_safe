package com.danusys.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.danusys.cmm.util.CommonUtil;

/*
//  클래스  명 : BaseDaoImpl (기본 Dao)
//  클래스설명 : BaseDao (기본 Dao) 인터페이스 구현 클래스
*/
@Repository("baseDao")
public class BaseDaoImpl implements BaseDao 
{
    private static final Logger logger = LoggerFactory.getLogger(BaseDaoImpl.class);

 //   protected SqlSession  SqlSession;
//    
//  
//
//    public void setSqlSession(SqlSession sqlSession)
//    {
//    	System.out.println(sqlSession);
//        this.SqlSession = sqlSession;
//    }


    private SqlSession sqlSession;
    
    @Resource(name = "sqlSession")
	public void setSqlSession(SqlSession sqlSession) {
    	this.sqlSession = sqlSession;
	}
    


    
    

    /**
     * FuncName : baseSelectList()
     * FuncDesc : List 조회
     * Param    : sqlid : SQL ID,
     *          : param : SQL Parameter
     * Return   : <T> List<T>
    */
    @Override
    public <T> List<T> baseSelectList(String sqlid, Map<String, Object> param)
    {
//        // Parameter 값 체크 확인
//        System.out.println("--------------- Key Start ---------------");
//        System.out.println("SQL ID = [" + sqlid + "]");
//        for (Map.Entry<String, Object> keyValue : param.entrySet())
//        {
//            System.out.println("Key  =[" + keyValue.getKey() + "]");
//            System.out.println("Value=[" + keyValue.getValue() + "]");
//            System.out.println("---------------------------------");
//        }
//        System.out.println("--------------- Key End ---------------");
    		System.out.println(sqlSession);
//        return SqlSession.selectList(sqlid, param);
    		return sqlSession.selectList(sqlid, param);
    }


    /**
     * FuncName : baseSelectOne()
     * FuncDesc : 단일 조회
     * Param    : sqlid : SQL ID
     *          : param : SQL Parameter
     * Return   : String
    */
    @Override
    public String baseSelectOne(String sqlid, Map<String, Object> param)
    {
//        // Parameter 값 체크 확인
//        System.out.println("--------------- Key Start ---------------");
//        System.out.println("SQL ID = [" + sqlid + "]");
//        for (Map.Entry<String, Object> keyValue : param.entrySet())
//        {
//            System.out.println("Key  =[" + keyValue.getKey() + "]");
//            System.out.println("Value=[" + keyValue.getValue() + "]");
//            System.out.println("---------------------------------");
//        }
//        System.out.println("--------------- Key End ---------------");

        return sqlSession.selectOne(sqlid, param);
    }


    /**
     * FuncName : baseInsertReturnSelectKey()
     * FuncDesc : 등록 (Insert Key 반환)
     * Param    : sqlid : SQL ID
     *          : param : SQL Parameter
     * Return   : String (Insert Key 반환) 
    */
    @Override
    public String baseInsertReturnSelectKey(String sqlid, Map<String, Object> param)
    {
//        // Parameter 값 체크 확인
//        System.out.println("--------------- Key Start ---------------");
//        System.out.println("SQL ID = [" + sqlid + "]");
//        for (Map.Entry<String, Object> keyValue : param.entrySet())
//        {
//            System.out.println("Key  =[" + keyValue.getKey() + "]");
//            System.out.println("Value=[" + keyValue.getValue() + "]");
//            System.out.println("---------------------------------");
//        }
//        System.out.println("--------------- Key End ---------------");

    	sqlSession.insert(sqlid, param);

        return param.get("idKey").toString();
    }


    /**
     * FuncName : baseInsert()
     * FuncDesc : 등록
     * Param    : sqlid : SQL ID
     *          : param : SQL Parameter
     * Return   : int
    */
    @Override
    public int baseInsert(String sqlid, Map<String, Object> param)
    {
        // Parameter 값 체크 확인
//        System.out.println("--------------- Key Start ---------------");
//        System.out.println("SQL ID = [" + sqlid + "]");
//        for (Map.Entry<String, Object> keyValue : param.entrySet())
//        {
//            System.out.println("Key  =[" + keyValue.getKey() + "]");
//            System.out.println("Value=[" + keyValue.getValue() + "]");
//            System.out.println("---------------------------------");
//        }
//        System.out.println("--------------- Key End ---------------");

        return sqlSession.insert(sqlid, param);
    }

    /**
     * FuncName : baseUpdate()
     * FuncDesc : 수정
     * Param    : sqlid : SQL ID
     *          : param : SQL Parameter
     * Return   : int
    */
    @Override
    public int baseUpdate(String sqlid, Map<String, Object> param)
    {
        // Parameter 값 체크 확인
//        System.out.println("--------------- Key Start ---------------");
//        System.out.println("SQL ID = [" + sqlid + "]");
//        for (Map.Entry<String, Object> keyValue : param.entrySet())
//        {
//            System.out.println("Key  =[" + keyValue.getKey() + "]");
//            System.out.println("Value=[" + keyValue.getValue() + "]");
//            System.out.println("---------------------------------");
//        }
//        System.out.println("--------------- Key End ---------------");

        return sqlSession.update(sqlid, param);
    }


    /**
     * FuncName : baseDelete()
     * FuncDesc : 삭제
     * Param    : sqlid : SQL ID
     *          : param : SQL Parameter
     * Return   : int
    */
    @Override
    public int baseDelete(String sqlid, Map<String, Object> param)
    {
        // Parameter 값 체크 확인
//        System.out.println("--------------- Key Start ---------------");
//        System.out.println("SQL ID = [" + sqlid + "]");
//        for (Map.Entry<String, Object> keyValue : param.entrySet())
//        {
//            System.out.println("Key  =[" + keyValue.getKey() + "]");
//            System.out.println("Value=[" + keyValue.getValue() + "]");
//            System.out.println("---------------------------------");
//        }
//        System.out.println("--------------- Key End ---------------");

        return sqlSession.delete(sqlid, param);
    }




}
