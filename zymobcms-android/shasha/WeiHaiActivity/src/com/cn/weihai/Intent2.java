package com.cn.weihai;

import android.app.Activity;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.view.View;
import android.view.Window;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.TextView;

public class Intent2 extends Activity {
	TextView  tv;
	Button fanhui;
    Button zixun;
 @Override
protected void onCreate(Bundle savedInstanceState) {
	// TODO Auto-generated method stub
	super.onCreate(savedInstanceState);
	requestWindowFeature(Window.FEATURE_NO_TITLE);
	setContentView(R.layout.intent2);
	tv=(TextView) findViewById(R.id.text1);
    zixun=(Button) findViewById(R.id.fufanzixun);
    zixun.setOnClickListener(new OnClickListener() {
		
		@Override
		public void onClick(View v) {
			// TODO Auto-generated method stub
			Uri  uri=Uri.parse("smsto:18912294545");
			Intent  intent=new Intent(Intent.ACTION_SENDTO,uri);
			intent.putExtra("sms_body", "THE.SMS  text");
			startActivity(intent);
		}
	});
    //把本身activity添加到exit_app里面addActivity的数组中
    Exit_app.getInstance().addActivity(Intent2.this);
    tv.setText("\t"+"\t"+"\t"+"一般作为中档的包装方法使用, 介"+"\n"
   		        +"\t"+"于内包装与外箱包装之间。 顾名思义,   " +"\n"
   		         +"\t"+" 各种彩盒（8张）, 一般由若干颜色搭配 " +"\n"
   		        +"\t"+" 而成,给人以强烈的视觉感官, 使购买者  " +"\n"
   		        +"\t"+"和使用者对商品的整体外观和颜色等细" +"\n"
   		         +"\t"+"节有一点了解。特别适合于购买前不能" +"\n"
   		      +"\t"+"拆箱的商品。" );
    fanhui=(Button) findViewById(R.id.fufan1);
    fanhui.setOnClickListener(new OnClickListener() {
		
		@Override
		public void onClick(View v) {
			// TODO Auto-generated method stub
			Intent in=new Intent(Intent2.this, WeiHaiActivity.class);
			startActivity(in);
		}
	});
}
public void danjijianjie(View v){
		Intent in;
		switch (v.getId()) {
		case R.id.bt2:
			in=new Intent(Intent2.this, Introduce.class);
			startActivity(in);
			break;
		case R.id.bt3:
			in=new Intent(Intent2.this, Online.class);
			startActivity(in);
			break;
		case R.id.bt4:
			in=new Intent(Intent2.this, Phone.class);
			startActivity(in);
			break;
		case R.id.bt5:
			in=new Intent(Intent2.this, More.class);
			startActivity(in);
			break;

		}
   }
}
