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

public class Intent0 extends Activity {
	TextView  tv;
	Button fanhui;
    Button zixun;
 @Override
protected void onCreate(Bundle savedInstanceState) {
	// TODO Auto-generated method stub
	 requestWindowFeature(Window.FEATURE_NO_TITLE);//去掉标题栏
	super.onCreate(savedInstanceState);
     setContentView(R.layout.f1);
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
     Exit_app.getInstance().addActivity(Intent0.this);
     tv.setText("\t"+"简单的纯色系"+"\n"
    		        +"\t"+"就像标点一样根植于生活的每个篇章" +"\n"
    		        +"\t"+"没有繁华似锦的强烈" +"\n"
    		        +"\t"+"独有自己的一番风味" +"\n"
    		        +"\t"+"随着时间的延展" +"\n"
    		        +"\t"+"纯色系赋予了床品生命力" +"\n"
    		        +"\t"+"拥入纯色床品柔软的怀抱" +"\n"
    		        +"\t"+"让纯天然的棉料亲吻我们的肌肤");
     fanhui=(Button) findViewById(R.id.fufan1);
     fanhui.setOnClickListener(new OnClickListener() {
		
		@Override
		public void onClick(View v) {
			// TODO Auto-generated method stub
			Intent in=new Intent(Intent0.this, JiaFangMainActivity.class);
			startActivity(in);
//			finish();
		}
	});
 }
 public void danjijianjie(View v){
		Intent in;
		switch (v.getId()) {
		case R.id.bt2:
			in=new Intent(Intent0.this, GongSiJianJie.class);
			startActivity(in);
//			finish();
			break;
		case R.id.bt3:
			in=new Intent(Intent0.this, ZaiXian.class);
			startActivity(in);
//			finish();
			break;
		case R.id.bt4:
			in=new Intent(Intent0.this, LianXiFangShi.class);
			startActivity(in);
//			finish();
			break;
		case R.id.bt5:
			in=new Intent(Intent0.this, Gengduo.class);
			startActivity(in);
//			finish();
			break;

		}
    }
}