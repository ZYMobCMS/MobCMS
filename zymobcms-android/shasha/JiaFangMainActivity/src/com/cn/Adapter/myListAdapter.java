package com.cn.Adapter;

import java.util.HashMap;
import java.util.List;

import com.cn.jiafangtuangou.R;

import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.TextView;

public class myListAdapter extends BaseAdapter {
	private final int[] image={R.drawable.sc,R.drawable.sb,R.drawable.sn,
            R.drawable.sm,R.drawable.sx,R.drawable.sz,
            R.drawable.xzha};
	  private  String[] text={"床品","被子/被芯","内衣/内裤","毛巾/浴巾","拖鞋/袜子","枕头/枕芯","收纳/杂货"};
		private  String[] text1={"质地高端   手感丝滑","面料细腻柔软  贴身透气","多种色彩  多种选择",
		                              "天然绵柔  健康环保", "防滑耐磨  彰显高档品质", "纯棉布料  精致缝纫","全天然纤维制造  立体感强"};
		private  String[] text2={"无甲醛的细腻好床品","无荧光增白剂的天然面料","舒适从这里开始",
		                               "属于你的好毛巾", "人体工学设计", "保留本源色泽","保留本源色泽"};
	private static   Context  context;
	private static List<HashMap<String, String>>  list;
	public  myListAdapter(Context context){
//		this.list=list;
		this.context=context;
	}
	@Override
	public int getCount() {
		// TODO Auto-generated method stub
		return text.length;
	}

	@Override
	public Object getItem(int position) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public long getItemId(int position) {
		// TODO Auto-generated method stub
		return 0;
	}
    
	@Override
	public View getView(int position, View convertView, ViewGroup parent) {
		View view = View.inflate(context, R.layout.itemlist, null);
		ImageView iv = (ImageView) view.findViewById(R.id.ivlist);
		TextView tv = (TextView) view.findViewById(R.id.item1);
		TextView tv1= (TextView) view.findViewById(R.id.item2);
		TextView tv2 = (TextView) view.findViewById(R.id.item3);
		tv.setText(text[position]);
		tv1.setText(text1[position]);
		tv2.setText(text2[position]);
		iv.setImageResource(image[position]);	
		return view;
	
	}

}

