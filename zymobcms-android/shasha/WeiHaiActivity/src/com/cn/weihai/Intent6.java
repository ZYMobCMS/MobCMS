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

public class Intent6 extends Activity {
	TextView  tv;
	Button fanhui;
    Button zixun;
 @Override
protected void onCreate(Bundle savedInstanceState) {
	// TODO Auto-generated method stub
	super.onCreate(savedInstanceState);
	requestWindowFeature(Window.FEATURE_NO_TITLE);
	setContentView(R.layout.intent6);
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
    Exit_app.getInstance().addActivity(Intent6.this);
    tv.setText("\t"+"\t"+"\t"+"是以用快干性的植物油调和颜料,"+"\n"
   		        +"\t"+" 在画布亚麻布, 纸张或木板上进行制作" +"\n"
   		        +"\t"+"的一个画种。作画时使用的稀释剂为挥" +"\n"
   		        +"\t"+"发性的松节油和干性的亚麻仁油等。画" +"\n"
   		        +"\t"+"面所附者的颜料有较强的硬度,当画面干" +"\n"
   		        +"\t"+"燥后, 能长期保持光泽。凭借颜料的遮" +"\n"
   		        +"\t"+"盖力和透明性能较充分地表现描绘对象," +"\n"
   		        +"\t"+" 色彩丰富, 立体质感强。油画是西洋画" +"\n"
   		        +"\t"+"的主要画种之一。" );
    fanhui=(Button) findViewById(R.id.fufan1);
    fanhui.setOnClickListener(new OnClickListener() {
		
		@Override
		public void onClick(View v) {
			// TODO Auto-generated method stub
			Intent in=new Intent(Intent6.this, WeiHaiActivity.class);
			startActivity(in);
		}
	});
}
public void danjijianjie(View v){
		Intent in;
		switch (v.getId()) {
		case R.id.bt2:
			in=new Intent(Intent6.this, Introduce.class);
			startActivity(in);
			break;
		case R.id.bt3:
			in=new Intent(Intent6.this, Online.class);
			startActivity(in);
			break;
		case R.id.bt4:
			in=new Intent(Intent6.this, Phone.class);
			startActivity(in);
			break;
		case R.id.bt5:
			in=new Intent(Intent6.this, More.class);
			startActivity(in);
			break;

		}
   }
}
