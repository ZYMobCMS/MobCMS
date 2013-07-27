package com.cn.weihai;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.Window;
import android.widget.Button;

public class More extends Activity {
	Button bu;
	Button bu1;
	Button bu2;
	Button bu4;
	Button bu5;
	Button bu6;
	Button bu7;
@Override
protected void onCreate(Bundle savedInstanceState) {
	// TODO Auto-generated method stub
	super.onCreate(savedInstanceState);
  requestWindowFeature(Window.FEATURE_NO_TITLE);
  setContentView(R.layout.more);
//把本身activity添加到exit_app里面addActivity的数组中
  Exit_app.getInstance().addActivity(More.this);
  bu=(Button) findViewById(R.id.denglu);
  bu1=(Button) findViewById(R.id.zhuce);
  bu2=(Button) findViewById(R.id.xinxi);
  bu4=(Button) findViewById(R.id.bt1);
  bu5=(Button) findViewById(R.id.bt2);
  bu6=(Button) findViewById(R.id.bt3);
  bu7=(Button) findViewById(R.id.bt4);
   }
   public void dianjianniu(View v){
	   Intent in;
	   switch (v.getId()) {
	case R.id.denglu:
		in=new Intent(More.this,Login.class );
		startActivity(in);
		break;
	case R.id.zhuce:
		in=new Intent(More.this,Register.class );
		startActivity(in);
		break;
	case R.id.xinxi:
		in=new Intent(More.this,Message.class );
		startActivity(in);
		break;
	}
	
	}

   public void danjigengduo(View v){
	   Intent in;
	   switch (v.getId()) {
	   case R.id.bt1:
			in=new Intent(More.this,WeiHaiActivity.class );
			startActivity(in);
			break;
		case R.id.bt2:
			in=new Intent(More.this,Introduce.class );
			startActivity(in);
			break;
		case R.id.bt3:
			in=new Intent(More.this,Online.class );
			startActivity(in);
			break;
		case R.id.bt4:
			in=new Intent(More.this,Phone.class );
			startActivity(in);
			break;
	}
   }
}


