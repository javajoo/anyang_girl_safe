package com.danusys.typeHandler;

import java.sql.CallableStatement; 
import java.sql.PreparedStatement; 
import java.sql.ResultSet; 
import java.sql.SQLException; 
import java.io.BufferedReader;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.type.BaseTypeHandler;
import org.apache.ibatis.type.JdbcType;
import org.apache.ibatis.type.MappedJdbcTypes;
import org.apache.ibatis.type.NStringTypeHandler;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * @author Clinton Begin 
 */ 

public class NStringTypeHandlerExtend extends BaseTypeHandler<String> { 
 
  @Override 
  public void setNonNullParameter(PreparedStatement ps, int i, String parameter, JdbcType jdbcType) 
      throws SQLException { 
//    ps.setNString(i, ((String) parameter)); 
    ps.setString(i, parameter); 
  } 
 
  @Override 
  public String getNullableResult(ResultSet rs, String columnName) 
      throws SQLException { 
//    return rs.getNString(columnName); 
    return rs.getString(columnName); 
  } 
 
  @Override 
  public String getNullableResult(ResultSet rs, int columnIndex) 
      throws SQLException { 
    return rs.getString(columnIndex); 
  } 
 
  @Override 
  public String getNullableResult(CallableStatement cs, int columnIndex) 
      throws SQLException { 
//    return cs.getNString(columnIndex); 
    return cs.getString(columnIndex); 
  } 
 
}

