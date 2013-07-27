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

public class Intent3 extends Activity {
	TextView  tv;
	Button fanhui;
    Button zixun;
 @Override
protected void onCreate(Bundle savedInstanceState) {
	// TODO Auto-generated method stub
	super.onCreate(savedInstanceState);
	requestWindowFeature(Window.FEATURE_NO_TITLE);
	setContentView(R.layout.intent3);
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
    Exit_app.getInstance().addActivity(Intent3.this);
    tv.setText("\t"+"\t"+"\t"+"\t"+"引进瑞典的热熔封套技术, 研"+"\n"
   		        +"\t"+"\t"+"制开发热熔封套生产线,将进口产" +"\n"
   		        +"\t"+"\t"+"品国产化，在生产过程中, 我们所" +"\n"
   		        +"\t"+"\t"+"选用的纸张、透片以及胶条都是" +"\n"
   		        +"\t"+"\t"+"无毒无味的具有环保证书的材料, " +"\n"
   		        +"\t"+"\t"+"沿袭了瑞典封套绿色环保的特点,  " +"\n"
   		        +"\t"+"\t"+"因为在国内生产,  也大大降低了各" +"\n"
   		        +"\t"+"\t"+"个环节的成本,并将这些优惠归还客" +"\n"
   		        +"\t"+"\t"+"户,使我们的客户使用到价格经济,  " +"\n"
   		        +"\t"+"\t"+"质量一流的系列热熔封套产品。");
    fanhui=(Button) findViewById(R.id.fufan1);
    fanhui.setOnClickListener(new OnClickListener() {
		
		@Override
		public void onClick(View v) {
			// TODO Auto-generated method stub
			Intent in=new Intent(Intent3.this, WeiHaiActivity.class);
			startActivity(in);
		}
	});
}
public void danjijianjie(View v){
		Intent in;
		switch (v.getId()) {
		case R.id.bt2:
			in=new Intent(Intent3.this, Introduce.class);
			startActivity(in);
			break;
		case R.id.bt3:
			in=new Intent(Intent3.this, Online.class);
			startActivity(in);
			break;
		case R.id.bt4:
			in=new Intent(Intent3.this, Phone.class);
			startActivity(in);
			break;
		case R.id.bt5:
			in=new Intent(Intent3.this, More.class);
			startActivity(in);
			break;

		}
   }
}
