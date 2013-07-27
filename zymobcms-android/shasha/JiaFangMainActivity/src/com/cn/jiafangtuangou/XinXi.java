package com.cn.jiafangtuangou;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.Window;
import android.widget.Button;

public class XinXi extends Activity {
	Button bu4;
	Button bu5;
	Button bu6;
	Button bu7;
	Button bu8;
	Button  bu;
	@Override	
	protected void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);
		requestWindowFeature(Window.FEATURE_NO_TITLE);
		setContentView(R.layout.xinxibangzhu);
		 //把本身activity添加到exit_app里面addActivity的数组中
        Exit_app.getInstance().addActivity(XinXi.this);
		 bu4=(Button) findViewById(R.id.bt1);
		  bu5=(Button) findViewById(R.id.bt2);
		  bu6=(Button) findViewById(R.id.bt3);
		  bu7=(Button) findViewById(R.id.bt4);
		  bu8=(Button) findViewById(R.id.bt5);
		  bu=(Button) findViewById(R.id.gengduo);
		  bu.setOnClickListener(new OnClickListener() {
			
			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
			Intent in=new Intent(XinXi.this, Gengduo.class);
			in.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP); 
			startActivity(in);
			}
		});
	}
	   public void danjigengduo(View v){
		   Intent in;
		   switch (v.getId()) {
		   case R.id.bt1:
				in=new Intent(XinXi.this,JiaFangMainActivity.class ); 
				startActivity(in);
//				finish();
				break;
			case R.id.bt2:
				in=new Intent(XinXi.this,GongSiJianJie.class );
				startActivity(in);
//				finish();
				break;
			case R.id.bt3:
				in=new Intent(XinXi.this,ZaiXian.class );
				startActivity(in);
//				finish();
				break;
			case R.id.bt4:
				in=new Intent(XinXi.this,LianXiFangShi.class ); 
				startActivity(in);
//				finish();
				break;
			case R.id.bt5:
				in=new Intent(XinXi.this,Gengduo.class );
				startActivity(in);
//				finish();
				break;
		}
	   }
}

