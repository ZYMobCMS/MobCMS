package com.cn.jiafangtuangou;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;

import com.cn.Adapter.myLianXiList;

import android.app.Activity;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.os.Environment;
import android.view.View;
import android.view.Window;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.ListView;

public class LianXiFangShi  extends Activity{
	ArrayList< HashMap<String, String>> mylist;
	ListView list_lianxi;
  @Override
protected void onCreate(Bundle savedInstanceState) {
	// TODO Auto-generated method stub
	super.onCreate(savedInstanceState);
	requestWindowFeature(Window.FEATURE_NO_TITLE);//去掉标题栏
	requestWindowFeature(Window.FEATURE_NO_TITLE);
	setContentView(R.layout.lianxi);
	 //把本身activity添加到exit_app里面addActivity的数组中
    Exit_app.getInstance().addActivity(LianXiFangShi.this);
	list_lianxi=(ListView) findViewById(R.id.lianxilist);
	mylist=new ArrayList<HashMap<String,String>>();
	myLianXiList adapter=new  myLianXiList(mylist,this);
	
	HashMap<String, String> hashmap01 = new HashMap<String, String>();
	hashmap01.put("list_text", "邮箱：18912294545@qq.cm");
	HashMap<String, String> hashmap02 = new HashMap<String, String>();
	hashmap02.put("list_text", "联系人：汪总");
	HashMap<String, String> hashmap03 = new HashMap<String, String>();
	hashmap03.put("list_text", "联系电话：18912294545");
	HashMap<String, String> hashmap04 = new HashMap<String, String>();
	hashmap04.put("list_text", "通讯地址：江苏省 徐州市丰县凤城镇锦绣水" +
			"岸小区13栋103室");
	mylist.add(hashmap01);
	mylist.add(hashmap02);
	mylist.add(hashmap03);
	mylist.add(hashmap04);
	list_lianxi.setAdapter(adapter);
	
	list_lianxi.setOnItemClickListener(new OnItemClickListener() {

		@Override
		public void onItemClick(AdapterView<?> parent, View view,
				int position, long id) {
			// TODO Auto-generated method stub
			switch (position) {
			case 0:
				Uri uri = Uri.parse("mailto:18912294545@qq.com");
				Intent in = new Intent(Intent.ACTION_SENDTO,uri);
				in.putExtra(Intent.EXTRA_SUBJECT, "邮件标题");
				in.putExtra(Intent.EXTRA_STREAM,Uri.parse("file:///"+Environment.getExternalStorageDirectory()+ File.separator + "附件目录"));
				LianXiFangShi.this.startActivity(in);				

				break;
							
			case 2:
				Uri uri_phone = Uri.parse("tel:18912294545");
				Intent intent_phone = new Intent(Intent.ACTION_DIAL, uri_phone);
				startActivity(intent_phone);
				break;
						
			case 3:					
				Intent intent = new Intent("android.intent.action.VIEW",
						android.net.Uri.parse("androidamap://showTraffic?sourceApplication=softname&poiid=BGVIS1&lat=34.702894&lon=116.6459154127&level=10&dev=0"));
				intent.setPackage("com.autonavi.minimap");
				startActivity(intent);

				break;
			}
		}
	});
}
  Intent in;
  public void danjilianxi(View v){
	   switch (v.getId()) {
	case R.id.bt1:
		in=new Intent(LianXiFangShi.this, JiaFangMainActivity.class);
		startActivity(in);
//		finish();
		break;
	case R.id.bt2:
		in=new Intent(LianXiFangShi.this, GongSiJianJie.class);
		startActivity(in);
//		finish();
		break;
	case R.id.bt3:
		in=new Intent(LianXiFangShi.this, ZaiXian.class);
		startActivity(in);
//		finish();
		break;
	case R.id.bt5:
		in=new Intent(LianXiFangShi.this, Gengduo.class);
		startActivity(in);
//		finish();
		break;
	   }
	}
}
