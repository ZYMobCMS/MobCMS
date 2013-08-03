package com.cn.weihai;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.Window;
import android.widget.Button;
import android.widget.TextView;

public class Introduce extends Activity {
	TextView  tv;
	Button fuwu;
 @Override
protected void onCreate(Bundle savedInstanceState) {
	// TODO Auto-generated method stub
	super.onCreate(savedInstanceState);
	requestWindowFeature(Window.FEATURE_NO_TITLE);
	setContentView(R.layout.introduce);
	//把本身activity添加到exit_app里面addActivity的数组中
    Exit_app.getInstance().addActivity(Introduce.this);
	tv=(TextView) findViewById(R.id.text);
	tv.setText("\t"+"\t"+"\t"+"公司是以商务彩印、彩色包装、" +"\n"
			 +"\t"+"出版物印刷为主的彩印企业,  主要从"+"\n" 
			+ "\t"+"事高档彩色包装、企业画册、样本、" +"\n"
			+"\t"+ "书刊等业务。公司以“创新无限、诚" +"\n"
			+"\t"+ "信永远”的经营理念, 本着为客户提供" +"\n"
			+"\t"+"精品的态度, 高质高效地为客户服务, " +"\n"
			+ "\t"+"受到了客户的一致认可和广泛赞誉," +"\n"
			+ "\t"+	" 在社会上形成了一批长期稳定的客户" +"\n"
			+ "\t"+"群体, 服务客户达300多家。" );
	fuwu=(Button) findViewById(R.id.fuwu);
}
    Intent in;
   public void danjijianjie(View v){
	   switch (v.getId()) {
	case R.id.bt1:
		in=new Intent(Introduce.this, WeiHaiActivity.class);
		startActivity(in);
		break;
	case R.id.bt3:
		in=new Intent(Introduce.this,Online.class);
		startActivity(in);
		break;
	case R.id.bt4:
		in=new Intent(Introduce.this, Phone.class); 
		startActivity(in);
		break;
	case R.id.bt5:
		in=new Intent(Introduce.this, More.class);
		startActivity(in);
		break;
	}
   }
}

