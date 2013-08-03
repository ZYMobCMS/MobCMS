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
    tv.setText("\t"+"含有珍珠精华, 建立珍珠般坚固的3"+"\n"
   		        +"\t"+"阶段皮肤防御系统, 令宝宝肌肤如珍" +"\n"
   		        +"\t"+"珠般滑嫩润泽;" +"\n"
   		        +"\t"+"天然植物淀粉, 有效祛痱, 驱除异味," +"\n"
   		        +"\t"+"同时让宝宝远离蚊叮, 皮肤刺痒的烦" +"\n"
   		        +"\t"+"恼;" +"\n"
   		        +"\t"+"细腻幼滑粉质经严格高温消毒处理," +"\n"
   		        +"\t"+"气味清新, 辅以独特亲自亲子配方"+"\n"
   		        +"\t"+"更能有效均衡肌肤水分, 维持独特"+"\n"
                +"\t"+"天然酸碱平衡, 令宝宝肌肤倍感爽"+"\n"
                +"\t"+"滑舒适, 使用倍感安心!");
    fanhui=(Button) findViewById(R.id.fufan1);
    fanhui.setOnClickListener(new OnClickListener() {
		
		@Override
		public void onClick(View v) {
			// TODO Auto-generated method stub
			Intent in=new Intent(Intent7.this, YouErActivity.class);
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
