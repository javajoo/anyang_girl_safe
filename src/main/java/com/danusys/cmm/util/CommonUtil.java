package com.danusys.cmm.util;

import java.io.UnsupportedEncodingException;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

public class CommonUtil {
	private static int SEQ = 0;

	public static boolean checkDataFilter(Map<String, String> map) {
		for (String key : map.keySet()) {
			String value = (String) map.get(key);
			if (value.indexOf("<") >= 0) {
				return false;
			}
			if (value.indexOf(">") >= 0) {
				return false;
			}
		}
		return true;
	}

	public static boolean checkDataFilterObj(Map<String, Object> map) {
		for (String key : map.keySet()) {
			String value = (String) map.get(key);
			if (value.indexOf("<") >= 0) {
				return false;
			}
			if (value.indexOf(">") >= 0) {
				return false;
			}
		}
		return true;
	}

	public static boolean checkIp(HttpServletRequest request, String ipTyCd,
			String ipCd, String dbIp) {
		boolean bRet = false;

		ipTyCd = ipTyCd.toUpperCase().trim();
		ipCd = ipCd.toUpperCase().trim();
		if (ipCd.equals("AL")) {
			return true;
		}
		String clientIp = request.getHeader("HTTP_X_FORWARDED_FOR");
		if ((clientIp == null) || (clientIp.length() == 0)
				|| (clientIp.toLowerCase().equals("unknown"))) {
			clientIp = request.getHeader("REMOTE_ADDR");
		}
		if ((clientIp == null) || (clientIp.length() == 0)
				|| (clientIp.toLowerCase().equals("unknown"))) {
			clientIp = request.getRemoteAddr();
		}
		if (ipTyCd.equals("IPV4")) {
			if (ipCd.equals("IP")) {
				if (clientIp.equals(dbIp)) {
					return true;
				}
				return false;
			}
			if (!ipCd.equals("DC")) {
				if (ipCd.equals("CC")) {
					dbIp = dbIp.split("\\.")[0] + "." + dbIp.split("\\.")[1]
							+ "." + dbIp.split("\\.")[2];
					String ip = clientIp.split("\\.")[0] + "."
							+ clientIp.split("\\.")[1] + "."
							+ clientIp.split("\\.")[2];
					if (ip.equals(dbIp)) {
						return true;
					}
					return false;
				}
				if (ipCd.equals("BC")) {
					dbIp = dbIp.split("\\.")[0] + "." + dbIp.split("\\.")[1];
					String ip = clientIp.split("\\.")[0] + "."
							+ clientIp.split("\\.")[1];
					if (ip.equals(dbIp)) {
						return true;
					}
					return false;
				}
				if (ipCd.equals("AC")) {
					dbIp = dbIp.split("\\.")[0];
					String ip = clientIp.split("\\.")[0];
					if (ip.equals(dbIp)) {
						return true;
					}
					return false;
				}
			}
		} else {
			if (ipCd.equals("8B")) {
				if (clientIp.equals(dbIp)) {
					return true;
				}
				return false;
			}
			if (ipCd.equals("7B")) {
				dbIp = dbIp.split("\\.")[0] + "." + dbIp.split("\\.")[1] + "."
						+ dbIp.split("\\.")[2] + "." + dbIp.split("\\.")[3]
						+ "." + dbIp.split("\\.")[4] + "."
						+ dbIp.split("\\.")[5] + "." + dbIp.split("\\.")[6];
				String ip = clientIp.split("\\.")[0] + "."
						+ clientIp.split("\\.")[1] + "."
						+ clientIp.split("\\.")[2] + "."
						+ clientIp.split("\\.")[3] + "."
						+ clientIp.split("\\.")[4] + "."
						+ clientIp.split("\\.")[5] + "."
						+ clientIp.split("\\.")[6];
				if (ip.equals(dbIp)) {
					return true;
				}
				return false;
			}
			if (ipCd.equals("6B")) {
				dbIp = dbIp.split("\\.")[0] + "." + dbIp.split("\\.")[1] + "."
						+ dbIp.split("\\.")[2] + "." + dbIp.split("\\.")[3]
						+ "." + dbIp.split("\\.")[4] + "."
						+ dbIp.split("\\.")[5];
				String ip = clientIp.split("\\.")[0] + "."
						+ clientIp.split("\\.")[1] + "."
						+ clientIp.split("\\.")[2] + "."
						+ clientIp.split("\\.")[3] + "."
						+ clientIp.split("\\.")[4] + "."
						+ clientIp.split("\\.")[5];
				if (ip.equals(dbIp)) {
					return true;
				}
				return false;
			}
			if (ipCd.equals("5B")) {
				dbIp = dbIp.split("\\.")[0] + "." + dbIp.split("\\.")[1] + "."
						+ dbIp.split("\\.")[2] + "." + dbIp.split("\\.")[3]
						+ "." + dbIp.split("\\.")[4];
				String ip = clientIp.split("\\.")[0] + "."
						+ clientIp.split("\\.")[1] + "."
						+ clientIp.split("\\.")[2] + "."
						+ clientIp.split("\\.")[3] + "."
						+ clientIp.split("\\.")[4];
				if (ip.equals(dbIp)) {
					return true;
				}
				return false;
			}
			if (ipCd.equals("4B")) {
				dbIp = dbIp.split("\\.")[0] + "." + dbIp.split("\\.")[1] + "."
						+ dbIp.split("\\.")[2] + "." + dbIp.split("\\.")[3];
				String ip = clientIp.split("\\.")[0] + "."
						+ clientIp.split("\\.")[1] + "."
						+ clientIp.split("\\.")[2] + "."
						+ clientIp.split("\\.")[3];
				if (ip.equals(dbIp)) {
					return true;
				}
				return false;
			}
			if (ipCd.equals("3B")) {
				dbIp = dbIp.split("\\.")[0] + "." + dbIp.split("\\.")[1] + "."
						+ dbIp.split("\\.")[2];
				String ip = clientIp.split("\\.")[0] + "."
						+ clientIp.split("\\.")[1] + "."
						+ clientIp.split("\\.")[2];
				if (ip.equals(dbIp)) {
					return true;
				}
				return false;
			}
			if (ipCd.equals("2B")) {
				dbIp = dbIp.split("\\.")[0] + "." + dbIp.split("\\.")[1];
				String ip = clientIp.split("\\.")[0] + "."
						+ clientIp.split("\\.")[1];
				if (ip.equals(dbIp)) {
					return true;
				}
				return false;
			}
			if (ipCd.equals("1B")) {
				dbIp = dbIp.split("\\.")[0];
				String ip = clientIp.split("\\.")[0];
				if (ip.equals(dbIp)) {
					return true;
				}
				return false;
			}
		}
		return bRet;
	}

	public static Map<String, String> checkCar(String carNo) {
		boolean bRet = false;

		Map<String, String> map = new HashMap();

		char[] charArray = carNo.toCharArray();
		for (int j = 0; j < charArray.length; j++) {
			if (((charArray[j] >= 'A') && (charArray[j] <= 'Z'))
					|| ((charArray[j] >= 'a') && (charArray[j] <= 'z'))) {
				map.put("msg", "������ ��������������.(����)");
				map.put("ret", "false");
				map.put("retCode", "01");
				return map;
			}
		}
		for (int i = 0; i < carNo.length(); i++) {
			if ("~`!@#$%^&*=+\\|[](){};:'<.,>/?_".indexOf(carNo.substring(i,
					i + 1)) >= 0) {
				map.put("msg", "������ ��������������.(��������)");
				map.put("ret", "false");
				map.put("retCode", "02");
				return map;
			}
		}
		if (carNo.split("-").length > 2) {
			map.put("msg", "������ ��������������.('-'���� ����)");
			map.put("ret", "false");
			map.put("retCode", "03");
			return map;
		}
		int han_check = 0;
		int num_check = 0;
		if (carNo.matches(".*[��-����-����-�R]+.*")) {
			han_check = 1;
		}
		int cnt = 0;
		String num_validate = "/^[0-9]*$/";
		if (carNo.indexOf("-") >= 0) {
			for (int j = 0; j < carNo.split("-").length; j++) {
				String num = carNo.split("-")[j];
				cnt = 0;
				charArray = num.toCharArray();
				for (int i = 0; i < charArray.length; i++) {
					if ((charArray[i] >= '0') && (charArray[i] <= '9')) {
						num_check = 1;
						cnt++;
					} else {
						cnt = 0;
					}
				}
				if (cnt != 3) {
					map.put("msg",
							"������ ��������������.('-'����, ������ ���� ���� ����)");
					map.put("ret", "false");
					map.put("retCode", "04");
					return map;
				}
			}
		} else {
			charArray = carNo.toCharArray();
			for (int i = 0; i < charArray.length; i++) {
				if ((charArray[i] >= '0') && (charArray[i] <= '9')) {
					num_check = 1;
					cnt++;
				} else {
					cnt = 0;
				}
			}
			if (cnt != 4) {
				map.put("msg",
						"������ ��������������.('-'����, ������ ���� ���� ����)");
				map.put("ret", "false");
				map.put("retCode", "05");
				return map;
			}
		}
		if ((han_check != 1) || (num_check != 1)) {
			map.put("msg", "���������� ����, ������ ������ ���������� ������.");
			map.put("ret", "false");
			map.put("retCode", "06");
			return map;
		}
		map.put("msg", "");
		map.put("ret", "true");
		return map;
	}

	final int HANGUL_UNICODE_START = 44032;
	final int HANGUL_UNICODE_END = 55215;

	static enum SYLLABLE_HANGUL {
		FULL_HANGUL, PART_HANGUL, NOT_HANGUL;
	}

	public SYLLABLE_HANGUL IsHangul(String text) {
		int text_count = text.length();

		int is_hangul_count = 0;
		for (int i = 0; i < text_count; i++) {
			char syllable = text.charAt(i);
			if ((44032 <= syllable) && (syllable <= 55215)) {
				is_hangul_count++;
			}
		}
		SYLLABLE_HANGUL is_syllable_hangul;
		if (is_hangul_count == text_count) {
			is_syllable_hangul = SYLLABLE_HANGUL.FULL_HANGUL;
		} else {
			// SYLLABLE_HANGUL is_syllable_hangul;
			if (is_hangul_count == 0) {
				is_syllable_hangul = SYLLABLE_HANGUL.NOT_HANGUL;
			} else {
				is_syllable_hangul = SYLLABLE_HANGUL.PART_HANGUL;
			}
		}
		return is_syllable_hangul;
	}

	public static boolean match(String input, String regexp) {
		Matcher matcher = Pattern.compile(regexp).matcher(input);
		String[] results = new String[matcher.groupCount() + 1];

		return matcher.find();
	}

	public static String isNullToString(Object object) {
		String string = "";
		if (object != null) {
			string = object.toString().trim();
		}
		return string;
	}

	public static String isNullToDefaultVal(Object object, String args) {
		String string = "";
		if (object != null) {
			string = object.toString().trim();
		} else {
			string = args;
		}
		return string;
	}

	public static String getCurrentYmd() {
		GregorianCalendar calendar = new GregorianCalendar();
		StringBuffer rtnStr = new StringBuffer();

		rtnStr.append(checkByte(Integer.toString(calendar.get(1)), 4, "0"));
		rtnStr.append(checkByte(Integer.toString(calendar.get(2) + 1), 2, "0"));
		rtnStr.append(checkByte(Integer.toString(calendar.get(5)), 2, "0"));

		return rtnStr.toString();
	}

	public static String getCurrentTime14() {
		GregorianCalendar calendar = new GregorianCalendar();
		StringBuffer rtnStr = new StringBuffer();

		rtnStr.append(checkByte(Integer.toString(calendar.get(1)), 4, "0"));
		rtnStr.append(checkByte(Integer.toString(calendar.get(2) + 1), 2, "0"));
		rtnStr.append(checkByte(Integer.toString(calendar.get(5)), 2, "0"));
		rtnStr.append(checkByte(Integer.toString(calendar.get(11)), 2, "0"));
		rtnStr.append(checkByte(Integer.toString(calendar.get(12)), 2, "0"));
		rtnStr.append(checkByte(Integer.toString(calendar.get(13)), 2, "0"));

		return rtnStr.toString();
	}

	public static String getCurrentTime17() {
		GregorianCalendar calendar = new GregorianCalendar();
		StringBuffer rtnStr = new StringBuffer();

		rtnStr.append(checkByte(Integer.toString(calendar.get(1)), 4, "0"));
		rtnStr.append(checkByte(Integer.toString(calendar.get(2) + 1), 2, "0"));
		rtnStr.append(checkByte(Integer.toString(calendar.get(5)), 2, "0"));
		rtnStr.append(checkByte(Integer.toString(calendar.get(11)), 2, "0"));
		rtnStr.append(checkByte(Integer.toString(calendar.get(12)), 2, "0"));
		rtnStr.append(checkByte(Integer.toString(calendar.get(13)), 2, "0"));
		rtnStr.append(checkByte(Integer.toString(calendar.get(14)), 3, "0"));

		return rtnStr.toString();
	}

	public static String checkByte(String source, int digit, String fillString) {
		String rtnStr = "";
		if (source.length() < digit) {
			for (int i = 0; i < digit - source.length(); i++) {
				rtnStr = rtnStr + fillString;
			}
		}
		rtnStr = rtnStr + source;

		return rtnStr;
	}

	public static String nullChk(String str) {
		if (str == null) {
			return "";
		}
		if (str.equals("null")) {
			return "";
		}
		if (str.equals("NULL")) {
			return "";
		}
		return str;
	}

	public static boolean strToBoolean(String paramStr) {
		boolean result = false;
		if ((paramStr.equals("Y")) || (paramStr.equals("y"))) {
			result = true;
		}
		return result;
	}

	public static String setPad(String str, int padLen, String padChar,
			String padFlag) {
		if (str == null) {
			str = "";
		}
		if (padFlag.equals("L")) {
			while (str.length() < padLen) {
				str = padChar + str;
			}
		} else if (padFlag.equals("R")) {
			while (str.length() < padLen) {
				str = str + padChar;
			}
		}
		return str;
	}

	public static String toHan(String str) throws UnsupportedEncodingException {
		if (str == null) {
			return null;
		}
		return new String(str.getBytes("ISO-8859-1"), "euc-kr");
	}

	public static boolean isAlpha(String str) {
		if ((str == null) || ("".equals(str))) {
			return false;
		}
		for (int i = 0; i < str.length(); i++) {
			if ((str.charAt(i) < 'A') && (str.charAt(i) != ' ')) {
				return false;
			}
		}
		return true;
	}

	public static boolean isNumeric(String str) {
		if ((str == null) || ("".equals(str))) {
			return false;
		}
		for (int i = 0; i < str.length(); i++) {
			if ((str.charAt(i) < '0') || (str.charAt(i) > '9')) {
				return false;
			}
		}
		return true;
	}

	public static String unescape(String str) {
		String rtnStr = new String();
		char[] arrInp = str.toCharArray();
		int cnt = arrInp.length;
		for (int i = 0; i < cnt; i++) {
			if (arrInp[i] == '%') {
				String hex;
				if (arrInp[(i + 1)] == 'u') {
					hex = str.substring(i + 2, i + 6);
					i += 5;
				} else {
					hex = str.substring(i + 1, i + 3);
					i += 2;
				}
				try {
					rtnStr = rtnStr
							+ new String(Character.toChars(Integer.parseInt(
									hex, 16)));
				} catch (NumberFormatException e) {
					rtnStr = rtnStr + "%";
					i -= (hex.length() > 2 ? 5 : 2);
				}
			} else {
				rtnStr = rtnStr + arrInp[i];
			}
		}
		return rtnStr;
	}

	public static String getUniqueID(String prefix) {
		String rtnStr = "";
		rtnStr = prefix + "_" + getCurrentTime14() + getNextSequenceValue();

		return rtnStr;
	}

	public static String getUniqueID() {
		String rtnStr = "";
		rtnStr = getCurrentTime17() + getNextSequenceValue();
		return rtnStr;
	}

	public static String getRandomValue(int length) {
		String rtnStr = "";
		Random rand = new Random(System.currentTimeMillis());

		int ranVal = Math.abs(rand.nextInt());
		int ranVal2 = Math.abs(rand.nextInt());
		int ranVal3 = ranVal + ranVal2;
		String ranStr = Integer.toString(ranVal3);
		rtnStr = ranStr.substring(ranStr.length() - length);

		return rtnStr;
	}

	public static String getCurrentTime8() {
		GregorianCalendar calendar = new GregorianCalendar();
		StringBuffer rtnStr = new StringBuffer();

		rtnStr.append(checkByte(Integer.toString(calendar.get(1)), 4, "0"));
		rtnStr.append(checkByte(Integer.toString(calendar.get(2) + 1), 2, "0"));
		rtnStr.append(checkByte(Integer.toString(calendar.get(5)), 2, "0"));
		return rtnStr.toString();
	}

	public static String removeInvalidXMLCharacters(String s) {
		StringBuilder out = new StringBuilder();

		int i = 0;
		while (i < s.length()) {
			int codePoint = s.codePointAt(i);
			if ((codePoint == 9) || (codePoint == 10) || (codePoint == 13)
					|| (codePoint == 56353)
					|| ((codePoint >= 32) && (codePoint <= 55295))
					|| ((codePoint >= 57344) && (codePoint <= 65533))
					|| ((codePoint >= 65536) && (codePoint <= 1114111))) {
				out.append(Character.toChars(codePoint));
			}
			i += Character.charCount(codePoint);
		}
		return out.toString();
	}

	public static String getNextSequenceValue() {
		String rtnStr = Integer.toString(SEQ);
		if (999 == SEQ) {
			SEQ = 0;
		}
		if (1 == rtnStr.length()) {
			rtnStr = "00" + rtnStr;
		} else if (2 == rtnStr.length()) {
			rtnStr = "0" + rtnStr;
		}
		SEQ += 1;
		return rtnStr;
	}

	public static String getReXSSFilter(String value) {
		value = value.replaceAll("&amp;", "&");

		value = value.replaceAll("&#35;", "#");

		value = value.replaceAll("&#59;", ";");

		value = value.replaceAll("&#92;", "\\\\");

		value = value.replaceAll("&lt;", "<");

		value = value.replaceAll("&gt;", ">");

		value = value.replaceAll("&#40;", "(");

		value = value.replaceAll("&#41;", ")");

		value = value.replaceAll("&#39;", "'");

		value = value.replaceAll("#40;", "(");

		value = value.replaceAll("#40;", "(");

		value = value.replaceAll("&quot;", "\"");

		value = value.replaceAll("&#36;", "\\$");

		value = value.replaceAll("&#42;", "*");

		value = value.replaceAll("&#43;", "+");

		value = value.replaceAll("&#124;", "|");

		value = value.replaceAll("&#46;", "\\.");

		value = value.replaceAll("&#63;", "\\?");

		value = value.replaceAll("&#91;", "\\[");

		value = value.replaceAll("&#93;", "\\]");

		value = value.replaceAll("&#94;", "\\^");

		value = value.replaceAll("&#123;", "\\{");

		value = value.replaceAll("&#125;", "\\}");

		value = value.replaceAll("&#33;", "!");

		value = value.replaceAll("&#37;", "%");

		value = value.replaceAll("&#44;", ",");

		value = value.replaceAll("&#45;", "-");

		value = value.replaceAll("&#47;", "/");

		value = value.replaceAll("&#58;", ":");

		value = value.replaceAll("&#61;", "=");

		value = value.replaceAll("&#64;", "@");

		value = value.replaceAll("&#95;", "_");

		value = value.replaceAll("&#96;", "`");

		value = value.replaceAll("&#126;", "~");

		return value;
	}

	public static String getClientIp(HttpServletRequest request) {
		// http헤더를 읽어와 프록시 서버, L4, 캐싱 서버, http서버용 WAS connector등으로 구성된 환경에서
		// 클라이언트 IP를 문제없이 얻어오기
		// http헤더는 프록시 서버, L4, 캐싱서버 등 제품별로 헤더정보가 다를 수 있으므로 만약 아래에 기입되지 않은 별도의
		// 헤더를 사용하는 제품이 있다면 헤더 정보를 추가 등록하여 문제를 피할 수 있음
		String ip = request.getHeader("X-Forwarded-For");

		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_CLIENT_IP");
		}
		// 만약 모든 헤더정보들이 없다면 (웹서버 환경이 프록시 등의 환경으로 구축되지 않았다면 직접 클라이언트 IP 정보를 불러옴
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}

		return ip;
	}

	public static Map<String, Object> ListToMap(List<Map<String, Object>> a) {

		Map<String, Object> map1 = new HashMap<String, Object>();
		int index = 0;
		for (Map<String, Object> map : a) {
			System.out.println("index >> " + index);
			for (Map.Entry<String, Object> entry : map.entrySet()) {
				String key = entry.getKey();
				Object value = entry.getValue();
				map.put(key, value);
				map1.put(key, value);
			}
			index++;
		}

		return map1;

	}

	public static String convertPathForOs(String path) {
		String os = System.getProperty("os.name").toLowerCase();

		if (os.indexOf("win") >= 0) {
			path = path.replaceAll("\\\\", "//");
		} else {
			path = path.replaceAll("//", "/");
		}

		return path;
	}

	public static String getUuid() {
		return UUID.randomUUID().toString().replaceAll("-", "");
	}
  
  public static String getHomePath() {
		String os = System.getProperty("os.name").toLowerCase();
		String userHome = System.getProperty("user.home");
  	String path = "";
  	
		if (os.indexOf("win") >= 0) {
			userHome = userHome.replaceAll("\\\\", "//");
			path = userHome + "\\/girl_safe_user_picture\\";
		} else {
			path = userHome + "/girl_safe_user_picture/";
		}
		
		return path;
	}
}
