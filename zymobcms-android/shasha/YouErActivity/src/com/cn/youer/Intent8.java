package com.cn.youer;

import android.app.Activity;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.view.View;
import android.view.Window;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.TextView;

public class Intent8 extends Activity {
	TextView  tv;
	Button fanhui;
    Button zixun;
 @Override
protected void onCreate(Bundle savedInstanceState) {
	// TODO Auto-generated method stub
	super.onCreate(savedInstanceState);
	requestWindowFeature(Window.FEATURE_NO_TITLE);
	setContentView(R.layout.intent8);
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
    Exit_app.getInstance().addActivity(Intent8.this);
    tv.setText("\t"+"刚出生的小宝宝们都喜欢手舞足蹈的"+"\n"
   		        +"\t"+"做运动的, 小手抓来抓去总是要抓到自" +"\n"
   		        +"\t"+"己的脸, 一不小心就会小小的破相啦," +"\n"
   		        +"\t"+"家人看了都很心疼呢, 小朋友指甲长" +"\n"
   		        +"\t"+"的也特别快,老人家总说月子里不好" +"\n"
   		        +"\t"+"剪指甲的, 虽然说是迷信, 但是为了" +"\n"
   		        +"\t"+"防止小朋友的小脸被抓, 细心的妈妈" +"\n"
   		        +"\t"+"最好选择一款透气的手套给宝宝哦!");
    fanhui=(Button) findViewById(R.id.fufan1);
    fanhui.setOnClickListener(new OnClickListener() {
		
		@Override
		public void onClick(View v) {
			// TODO Auto-generated method stub
			Intent in=new Intent(Intent8.this, YouErActivity.class);
			startActivity(in);
		}
	});
}
public void danjijianjie(View v){
		Intent in;
		switch (v.getId()) {
		case R.id.bt2:
			in=new Intent(Intent8.this, Introduce.class);
			startActivity(in);
			break;
		case R.id.bt3:
			in=new Intent(Intent8.this, Online.class);
			startActivity(in);
			break;
		case R.id.bt4:
			in=new Intent(Intent8.this, Phone.class);
			startActivity(in);
			break;
		case R.id.bt5:
			in=new Intent(Intent8.this, More.class);
			startActivity(in);
			break;

		}
   }
}

