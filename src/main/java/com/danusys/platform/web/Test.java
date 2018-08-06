package com.danusys.platform.web;

import com.danusys.platform.helper.HttpHelper;

public class Test {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		HttpHelper.getInstance().sendHttpRequest(args[0], null, args[1], null);
	}

}
