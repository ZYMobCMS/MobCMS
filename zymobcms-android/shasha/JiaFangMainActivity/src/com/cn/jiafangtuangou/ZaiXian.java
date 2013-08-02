package com.cn.jiafangtuangou;

import android.app.Activity;
import android.os.Bundle;
import android.view.Window;
import android.webkit.WebView;

public class ZaiXian extends Activity {
	 @Override
	protected void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);
		requestWindowFeature(Window.FEATURE_NO_TITLE);//去掉标题栏
		setContentView(R.layout.zaixianneirong);
		 //把本身activity添加到exit_app里面addActivity的数组中
	    Exit_app.getInstance().addActivity(ZaiXian.this);
		WebView web = (WebView) findViewById(R.id.web);
		web.loadUrl("http://www.dapu.com/");
	}
	}