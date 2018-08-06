<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
 
<head>
  <script src="/js/jquery.min.js"></script>
  <!-- <script src="http://code.jquery.com/jquery-latest.js"></script> -->
</head>
 
<script>
$.getJSON("http://localhost:8080/datas/selectDatasMT.do",
  function(data) {
      //alert(jQuery.stringify(data));
	  $('#after').append($.stringify(data["data1"]));
  });
 
jQuery.extend({
    stringify  : function stringify(obj) {
        /* if ("JSON" in window) {
            return JSON.stringify(obj);
        } */
        
        var t = typeof (obj);
        if (t != "object" || obj === null) {
            // simple data type
            if (t == "string") obj = '"' + obj + '"';
            
            return String(obj);
        } else {
            // recurse array or object
            var n, v, jsonHH = [], jsonOU = [], arr = (obj && obj.constructor == Array);
            var to = ['"x"', '"악취농도(ppm)"'];
            Object.val = function (obj) {
                var vals = [];
                for( var key in obj ) {
                    if ( obj.hasOwnProperty(key) ) {
                        vals.push(Object.keys((obj[key])));
                    }
                }
                return vals;
                
            }
            for (n in obj) {
            	v = obj[n];
                t = typeof(v);
                if (obj.hasOwnProperty(n)) {
                	if (t == "string") {
                        v = '"' + v + '"';
                    } else if (t == "object" && v !== null){
                        //v = jQuery.stringify(v);
                    }
                	
                }
            }
            for (n in obj) {
            	//console.log(obj[n]);
            	jsonHH.push((arr ? '"' : '"' ) + obj[n]['hh'] + (arr ? '"' : '"' ));
            	jsonOU.push((arr ? "" : '"' ) + obj[n]['ou'] + (arr ? "" : '"' ));

            }
            return " { " + String(to[0]) + " : " + (arr ? "[" : "{") + String(jsonHH) + (arr ? "]" : "}") + 
            ", " + String(to[1]) + " : " + (arr ? "[" : "{") + String(jsonOU) + (arr ? "]" : "}")+" } ";
        }
    }
});


</script>
<body>
<div id="before"></div>
<div id="after"></div>
</body>

