package com.cn.jiafangtuangou;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.Window;
import android.widget.Button;
import android.widget.TextView;

public class GongSiJianJie extends Activity {
	TextView  tv;
	Button fuwu;
@Override
protected void onCreate(Bundle savedInstanceState) {
	// TODO Auto-generated method stub
	super.onCreate(savedInstanceState);
	requestWindowFeature(Window.FEATURE_NO_TITLE);//去掉标题栏
	setContentView(R.layout.gongsijianjie);
	 //把本身activity添加到exit_app里面addActivity的数组中
    Exit_app.getInstance().addActivity(GongSiJianJie.this);
	tv=(TextView) findViewById(R.id.text);
	tv.setText("\t"+"\t"+"\t"+"家纺团每天团购一次，为消费者" +"\n"
			 +"\t"+"精选价美物廉的家纺，让消费者享受"+"\n" 
			+ "\t"+"超低折扣的优质服务。如果您是消费" +"\n"
			+"\t"+ "者,家纺团每天帮您推荐一款时尚家纺" +"\n"
			+"\t"+ "产品,家纺团同时还致力于帮您发现家" +"\n"
			+ "\t"+"纺团最舒适，最环保的家纺产品");
	fuwu=(Button) findViewById(R.id.fuwu);
}
    Intent in;
   public void danjijianjie(View v){
	   switch (v.getId()) {
	case R.id.bt1:
		in=new Intent(GongSiJianJie.this, JiaFangMainActivity.class);
		startActivity(in);
//		finish();
		break;
	case R.id.bt3:
		in=new Intent(GongSiJianJie.this, ZaiXian.class);
		startActivity(in);
//		finish();
		break;
	case R.id.bt4:
		in=new Intent(GongSiJianJie.this, LianXiFangShi.class); 
		startActivity(in);
//		finish();
		break;
	case R.id.bt5:
		in=new Intent(GongSiJianJie.this, Gengduo.class);
		startActivity(in);
//		finish();
		break;
	}
   }
}
