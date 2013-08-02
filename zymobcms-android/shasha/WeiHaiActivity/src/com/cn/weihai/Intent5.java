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
    tv.setText("\t"+"\t"+"\t"+"不干胶标贴同传统的标贴相比,"+"\n"
   		        +"\t"+" 具有不用刷胶、不用浆糊、不用蘸水、" +"\n"
   		        +"\t"+"无污染、节省贴标时间等优点, 应用" +"\n"
   		        +"\t"+"范围广, 方便快捷。各类不干胶标贴" +"\n"
   		        +"\t"+"都可应用在一般纸张标贴所不能胜任" +"\n"
   		        +"\t"+"的材料上, 可以这样说, 不干胶标贴是" +"\n"
   		        +"\t"+"一种万能的标贴, 不干胶标贴通常在标" +"\n"
   		        +"\t"+"贴联动机上印刷加工, 多工序一次完成," +"\n"
   		        +"\t"+" 如图文印刷、模切、排废、切张和复" +"\n"
   		        +"\t"+"卷等");
    fanhui=(Button) findViewById(R.id.fufan1);
    fanhui.setOnClickListener(new OnClickListener() {
		
		@Override
		public void onClick(View v) {
			// TODO Auto-generated method stub
			Intent in=new Intent(Intent5.this, WeiHaiActivity.class);
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
