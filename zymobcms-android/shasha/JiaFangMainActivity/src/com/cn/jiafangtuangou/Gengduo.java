package com.cn.jiafangtuangou;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;

import com.cn.Adapter.myLianXiList;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.os.Environment;
import android.view.View;
import android.view.Window;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.Button;
import android.widget.ListView;

public class Gengduo extends Activity {
	Button bu;
	Button bu1;
	Button bu2;
	Button bu3;
	Button bu4;
	Button bu5;
	Button bu6;
	Button bu7;
   @Override
protected void onCreate(Bundle savedInstanceState) {
	// TODO Auto-generated method stub
	super.onCreate(savedInstanceState);
	requestWindowFeature(Window.FEATURE_NO_TITLE);
  setContentView(R.layout.gengduo);
  //把本身activity添加到exit_app里面addActivity的数组中
  Exit_app.getInstance().addActivity(Gengduo.this);
  bu=(Button) findViewById(R.id.denglu);
  bu1=(Button) findViewById(R.id.zhuce);
  bu2=(Button) findViewById(R.id.xinxi);
  bu3=(Button) findViewById(R.id.tuichu);
  bu4=(Button) findViewById(R.id.bt1);
  bu5=(Button) findViewById(R.id.bt2);
  bu6=(Button) findViewById(R.id.bt3);
  bu7=(Button) findViewById(R.id.bt4);
   }
   public void dianjianniu(View v){
	   Intent in;
	   switch (v.getId()) {
	case R.id.denglu:
		in=new Intent(Gengduo.this,DengLu.class );
		startActivity(in);
//		finish();
		break;
	case R.id.zhuce:
		in=new Intent(Gengduo.this,ZhuCe.class );
		startActivity(in);
//		finish();
		break;
	case R.id.xinxi:
		in=new Intent(Gengduo.this,XinXi.class );
		startActivity(in);
//		finish();
		break;
	case R.id.tuichu:
		AlertDialog.Builder exit_alter = new AlertDialog.Builder(Gengduo.this);
		exit_alter.setMessage("是否退出应用").setPositiveButton("是", new DialogInterface.OnClickListener() {
			@Override
			public void onClick(DialogInterface dialog, int which) {
				// TODO Auto-generated method stub
				Exit_app.getInstance().exit(); 
			}
		}).setNegativeButton("否", null).show();
		break;
	}
	
	}

   public void danjigengduo(View v){
	   Intent in;
	   switch (v.getId()) {
	   case R.id.bt1:
			in=new Intent(Gengduo.this,JiaFangMainActivity.class );
			startActivity(in);
//			finish();
			break;
		case R.id.bt2:
			in=new Intent(Gengduo.this,GongSiJianJie.class );
			startActivity(in);
//			finish();
			break;
		case R.id.bt3:
			in=new Intent(Gengduo.this,ZaiXian.class );
			startActivity(in);
//			finish();
			break;
		case R.id.bt4:
			in=new Intent(Gengduo.this,LianXiFangShi.class );
			startActivity(in);
//			finish();
			break;
	}
   }
}
