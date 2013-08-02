package com.cn.weihai;


import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.Window;
import android.widget.Button;
import android.widget.EditText;

public class Register extends Activity {
	Button bu4;
	Button bu5;
	Button bu6;
	Button bu7;
	Button bu8;
	Button  bu;
	Button zhuce;
	public SharedPreferences sp;
	Register rgister;
	EditText  yonghuming;
	EditText  mima;
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);
		requestWindowFeature(Window.FEATURE_NO_TITLE);
		setContentView(R.layout.register);
		 //把本身activity添加到exit_app里面addActivity的数组中
        Exit_app.getInstance().addActivity(Register.this);
		 bu4=(Button) findViewById(R.id.bt1);
		  bu5=(Button) findViewById(R.id.bt2);
		  bu6=(Button) findViewById(R.id.bt3);
		  bu7=(Button) findViewById(R.id.bt4);
		  bu7=(Button) findViewById(R.id.bt5);
		  bu=(Button) findViewById(R.id.gengduo);
		  yonghuming=(EditText) findViewById(R.id.yonghuming);
		  mima=(EditText) findViewById(R.id.shezhimima);
		  bu.setOnClickListener(new OnClickListener() {
			
			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				Intent in=new Intent(Register.this, More.class);
				startActivity(in);
			}
		});
		  zhuce=(Button) findViewById(R.id.zhuce);
		  sp=this.getSharedPreferences("user", Context.MODE_PRIVATE);
		  zhuce.setOnClickListener(new OnClickListener() {
			
			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub				
                 SharedPreferences.Editor editor=sp.edit();
                 editor.putString("name", yonghuming.getText().toString().trim());
                 editor.putString("pass", mima.getText().toString().trim());
                 editor.commit();
                 Intent in=new Intent(Register.this, More.class);
                 startActivity(in);
			}
		}) ;                                                                       			
			    }  
			   
	   public void danjigengduo(View v){
		   Intent in;
		   switch (v.getId()) {
		   case R.id.bt1:
				in=new Intent(Register.this,WeiHaiActivity.class );
				startActivity(in);
				break;
			case R.id.bt2:
				in=new Intent(Register.this,Introduce.class );
				startActivity(in);
				break;
			case R.id.bt3:
				in=new Intent(Register.this,Online.class );
				startActivity(in);
				break;
			case R.id.bt4:
				in=new Intent(Register.this,Phone.class );
				startActivity(in);
				break;
			case R.id.bt5:
				in=new Intent(Register.this,More.class );
				startActivity(in);
				break;
		}
	   }
}



