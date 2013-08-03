package com.cn.youer;

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
	tv.setText("\t"+"\t"+"\t"+"婴儿用品秉承“一切为了孩子的" +"\n"
			 +"\t"+"健康, 一切为了孩子的快乐,一切为了"+"\n" 
			+ "\t"+"孩子的成长”的宗旨, 在市场上不断" +"\n"
			+"\t"+ "深入发展,得到了广大妈妈们的信赖" +"\n"
			+"\t"+ "与好评。我们一直以温馨、专业、" +"\n"
			+"\t"+"亲切的婴儿服务, 实现梦想; 以执着" +"\n"
			+ "\t"+"、合作、利他的精神, 不断创造佳" +"\n"
			+ "\t"+	"绩;同时我们也将一如既往于公司" +"\n"
			+ "\t"+"品牌的发展地专注, 帮助中国宝宝" +"\n"
			+ "\t"+"和全球儿童快乐、健康的成长!");
	fuwu=(Button) findViewById(R.id.fuwu);
}
    Intent in;
   public void danjijianjie(View v){
	   switch (v.getId()) {
	case R.id.bt1:
		in=new Intent(Introduce.this, YouErActivity.class);
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

