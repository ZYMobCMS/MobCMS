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

public class Intent7 extends Activity {
	TextView  tv;
	Button fanhui;
    Button zixun;
 @Override
protected void onCreate(Bundle savedInstanceState) {
	// TODO Auto-generated method stub
	super.onCreate(savedInstanceState);
	requestWindowFeature(Window.FEATURE_NO_TITLE);
	setContentView(R.layout.intent7);
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
    Exit_app.getInstance().addActivity(Intent7.this);
    tv.setText("\t"+"\t"+"\t"+"海报制作是众人皆知的广告"+"\n"
   		        +"\t"+"宣传手段, 无论是企业宣传某种商" +"\n"
   		        +"\t"+"品, 还是社团策划某种活动,在准备" +"\n"
   		        +"\t"+"阶段都会向众人张贴一张相关的海" +"\n"
   		        +"\t"+"报。相对于简单的宣传单页而言, 海" +"\n"
   		        +"\t"+"报所承载的信息量比较大,因而受到"+"\n"
   		        +"\t"+"人们的追捧。");
    fanhui=(Button) findViewById(R.id.fufan1);
    fanhui.setOnClickListener(new OnClickListener() {
		
		@Override
		public void onClick(View v) {
			// TODO Auto-generated method stub
			Intent in=new Intent(Intent7.this, WeiHaiActivity.class);
			startActivity(in);
		}
	});
}
public void danjijianjie(View v){
		Intent in;
		switch (v.getId()) {
		case R.id.bt2:
			in=new Intent(Intent7.this, Introduce.class);
			startActivity(in);
			break;
		case R.id.bt3:
			in=new Intent(Intent7.this, Online.class);
			startActivity(in);
			break;
		case R.id.bt4:
			in=new Intent(Intent7.this, Phone.class);
			startActivity(in);
			break;
		case R.id.bt5:
			in=new Intent(Intent7.this, More.class);
			startActivity(in);
			break;

		}
   }
}
