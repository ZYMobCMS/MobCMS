package com.cn.jiafangtuangou;

import android.app.Activity;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.Window;
import android.widget.Button;
import android.widget.TextView;

public class Intent1 extends Activity {
	TextView  tv;
	Button fanhui;
	 Button zixun;
 @Override
protected void onCreate(Bundle savedInstanceState) {
	// TODO Auto-generated method stub
	 requestWindowFeature(Window.FEATURE_NO_TITLE);//去掉标题栏
	super.onCreate(savedInstanceState);
     setContentView(R.layout.f2);
     //把本身activity添加到exit_app里面addActivity的数组中
     Exit_app.getInstance().addActivity(Intent1.this);
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
     tv=(TextView) findViewById(R.id.text2);
     tv.setText("\t"+"蓝色"+"\n"
    		        +"\t"+"天空般悠远广阔" +"\n"
    		        +"\t"+"纤云不染" +"\n"
    		        +"\t"+"一望无际的天幕" +"\n"
    		        +"\t"+"可以让心自由的飞翔" +"\n");
fanhui=(Button) findViewById(R.id.fufan2);
fanhui.setOnClickListener(new OnClickListener() {

@Override
public void onClick(View v) {
	// TODO Auto-generated method stub
	Intent in=new Intent(Intent1.this, JiaFangMainActivity.class);
	startActivity(in);
}
});
 }
 public void danjijianjie(View v){
		Intent in;
		switch (v.getId()) {
		case R.id.bt2:
			in=new Intent(Intent1.this, GongSiJianJie.class);
			startActivity(in);
//			finish();
			break;
		case R.id.bt3:
			in=new Intent(Intent1.this, ZaiXian.class);
			startActivity(in);
//			finish();
			break;
		case R.id.bt4:
			in=new Intent(Intent1.this, LianXiFangShi.class);
			startActivity(in);
//			finish();
			break;
		case R.id.bt5:
			in=new Intent(Intent1.this, Gengduo.class);
			startActivity(in);
//			finish();
			break;
		}
		}
}

