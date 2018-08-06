/*
 * Copyright 2008-2009 MOPAS(Ministry of Public Administration and Security).
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package egovframework.com.cmm.filter;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.Map;
import java.util.Set;
import java.util.Map.Entry;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

public class SafetyParamFilter implements Filter{

	@SuppressWarnings("unused")
	private FilterConfig config;

	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
    	HttpRequestWithModifiableParameters param = new HttpRequestWithModifiableParameters((HttpServletRequest)request);
    	
    	HttpServletRequest request2 = (HttpServletRequest) request ;
    	String uri = request2.getRequestURI().toString().trim();
    	if (uri.startsWith("/admin/uploadImage.do") || uri.startsWith("/com/danusys/platform/recvNodeInfo.do")) {
    		chain.doFilter(request, response);
			return;
		}
        try {
        	InputStream is = request.getInputStream();        	
        	JSONParser jsonParser = new JSONParser();        	
        	BufferedReader br = new BufferedReader(new InputStreamReader(is, "UTF-8"));        	
        	String result = br.readLine();
        	
        	if(param.getParameter("json") == null || param.getParameter("json").equals(""))
        			param.setParameter("json", result);
        	
        	if(result != null && !result.substring(1, 2).equals("-")) {
        		JSONObject jsonObject = (JSONObject)jsonParser.parse(result);
        	
        		System.out.println(jsonObject.toString());
        		Set<Entry<String, Object>> entrySet  = jsonObject.entrySet();
        	
        		for(Map.Entry<String,Object> entry : entrySet){
        			param.setParameter(entry.getKey(), entry.getValue().toString());
        		}	
        	} else {
        		chain.doFilter(request, response);
        		return;
        	}
        } catch(Exception exx) {
        	exx.printStackTrace();
        }
		chain.doFilter((HttpServletRequest)param, response);
	}

	@Override
	public void init(FilterConfig config) throws ServletException {
		this.config = config;
	}

	@Override
	public void destroy() {

	}
}
