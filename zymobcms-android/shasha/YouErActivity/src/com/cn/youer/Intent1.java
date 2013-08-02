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

public class Intent1 extends Activity {
	TextView  tv;
	Button fanhui;
    Button zixun;
 @Override
protected void onCreate(Bundle savedInstanceState) {
	// TODO Auto-generated method stub
	super.onCreate(savedInstanceState);
	requestWindowFeature(Window.FEATURE_NO_TITLE);
	setContentView(R.layout.intent1);
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
    Exit_app.getInstance().addActivity(Intent1.this);
    tv.setText("\t"+"幼儿床多数使用纯天然松木制作而成"+"\n"
   		        +"\t"+"且打磨光滑, 手感极佳。油漆环保无危" +"\n"
   		        +"\t"+"害。给孩子的都是最好的." +"\n"
   		        +"\t"+"不易脏、不易滋生细菌、木材不易腐" +"\n"
   		        +"\t"+"朽、不易磨损、有光泽、很好看！" );
    fanhui=(Button) findViewById(R.id.fufan1);
    fanhui.setOnClickListener(new OnClickListener() {
		
		@Override
		public void onClick(View v) {
			// TODO Auto-generated method stub
			Intent in=new Intent(Intent1.this, YouErActivity.class);
			startActivity(in);
		}
	});
}
public void danjijianjie(View v){
		Intent in;
		switch (v.getId()) {
		case R.id.bt2:
			in=new Intent(Intent1.this, Introduce.class);
			startActivity(in);
			break;
		case R.id.bt3:
			in=new Intent(Intent1.this, Online.class);
			startActivity(in);
			break;
		case R.id.bt4:
			in=new Intent(Intent1.this, Phone.class);
			startActivity(in);
			break;
		case R.id.bt5:
			in=new Intent(Intent1.this, More.class);
			startActivity(in);
			break;

		}
   }
}

