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

public class Intent4 extends Activity {
	TextView  tv;
	Button fanhui;
    Button zixun;
 @Override
protected void onCreate(Bundle savedInstanceState) {
	// TODO Auto-generated method stub
	super.onCreate(savedInstanceState);
	requestWindowFeature(Window.FEATURE_NO_TITLE);
	setContentView(R.layout.intent4);
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
    Exit_app.getInstance().addActivity(Intent4.this);
    tv.setText("\t"+"\t"+"\t"+"专门承揽各种纸袋、 纸盒、纸"+"\n"                           
   		        +"\t"+"箱、吊牌、塑料袋、环保袋等纸塑包" +"\n"   		       
   		        +"\t"+"装制品。自成立以来, 一直以争" +"\n"   		       
   		        +"\t"+"创专业的现代化包装企业为发展目标" +"\n"   		       
   		        +"\t"+"以振兴民族包装行业为己任, 秉承“诚" +"\n"   		       
   		        +"\t"+"信、务实、创新、发展”的经营理念," +"\n"   		       
   		        +"\t"+"多次承接了大规模中、小企业的包装" +"\n"   		       
   		        +"\t"+"业务, 取得了良好的社会、经济效益," +"\n"   		       
   		        +"\t"+"具有自己独有的竞争力及市场潜力。");
    fanhui=(Button) findViewById(R.id.fufan1);
    fanhui.setOnClickListener(new OnClickListener() {
		
		@Override
		public void onClick(View v) {
			// TODO Auto-generated method stub
			Intent in=new Intent(Intent4.this, WeiHaiActivity.class);
			startActivity(in);
		}
	});
}
public void danjijianjie(View v){
		Intent in;
		switch (v.getId()) {
		case R.id.bt2:
			in=new Intent(Intent4.this, Introduce.class);
			startActivity(in);
			break;
		case R.id.bt3:
			in=new Intent(Intent4.this, Online.class);
			startActivity(in);
			break;
		case R.id.bt4:
			in=new Intent(Intent4.this, Phone.class);
			startActivity(in);
			break;
		case R.id.bt5:
			in=new Intent(Intent4.this, More.class);
			startActivity(in);
			break;

		}
   }
}

