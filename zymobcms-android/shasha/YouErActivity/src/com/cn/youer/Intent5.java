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

public class Intent5 extends Activity {
	TextView  tv;
	Button fanhui;
    Button zixun;
 @Override
protected void onCreate(Bundle savedInstanceState) {
	// TODO Auto-generated method stub
	super.onCreate(savedInstanceState);
	requestWindowFeature(Window.FEATURE_NO_TITLE);
	setContentView(R.layout.intent5);
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
    Exit_app.getInstance().addActivity(Intent5.this);
    tv.setText("\t"+"在宝宝一岁前, 所有加糖或加入人工"+"\n"
   		        +"\t"+"甘味的食物都要尽量少吃。因为过度" +"\n"
   		        +"\t"+"加工过的糖类, 不含维他命, 矿物质" +"\n"
   		        +"\t"+"或蛋白质, 会使宝宝的胃口受到影响," +"\n"
   		        +"\t"+"吃了糖, 什么也不想吃了, 妨碍到吃" +"\n"
   		        +"\t"+"健康的食物。所以选择奶粉方面最" +"\n"
   		        +"\t"+"好是原味的, 口感清淡的!");
    fanhui=(Button) findViewById(R.id.fufan1);
    fanhui.setOnClickListener(new OnClickListener() {
		
		@Override
		public void onClick(View v) {
			// TODO Auto-generated method stub
			Intent in=new Intent(Intent5.this, YouErActivity.class);
			startActivity(in);
		}
	});
}
public void danjijianjie(View v){
		Intent in;
		switch (v.getId()) {
		case R.id.bt2:
			in=new Intent(Intent5.this, Introduce.class);
			startActivity(in);
			break;
		case R.id.bt3:
			in=new Intent(Intent5.this, Online.class);
			startActivity(in);
			break;
		case R.id.bt4:
			in=new Intent(Intent5.this, Phone.class);
			startActivity(in);
			break;
		case R.id.bt5:
			in=new Intent(Intent5.this, More.class);
			startActivity(in);
			break;

		}
   }
}
