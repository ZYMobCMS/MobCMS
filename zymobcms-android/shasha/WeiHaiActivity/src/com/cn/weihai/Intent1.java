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
    tv.setText("\t"+"\t"+"\t"+"为更好的服务于客户, 以让客户少"+"\n"
   		        +"\t"+"绕弯路、少付出、节约更多的时间为" +"\n"
   		        +"\t"+"目标,  我中心精心打造了：“一条龙”、" +"\n"
   		        +"\t"+"“一站式”服务体系,为客户提供定位准" +"\n"
   		        +"\t"+"确、全方位的包装解决方案。"  );
    fanhui=(Button) findViewById(R.id.fufan1);
    fanhui.setOnClickListener(new OnClickListener() {
		
		@Override
		public void onClick(View v) {
			// TODO Auto-generated method stub
			Intent in=new Intent(Intent1.this, WeiHaiActivity.class);
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



