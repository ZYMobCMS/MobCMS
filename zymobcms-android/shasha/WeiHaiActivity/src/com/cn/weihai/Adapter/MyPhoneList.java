package com.cn.weihai.Adapter;

import java.util.ArrayList;
import java.util.HashMap;

import com.cn.weihai.R;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.TextView;

public class MyPhoneList extends BaseAdapter {
	ArrayList<HashMap<String, String>> arraylist = new ArrayList<HashMap<String,String>>();
	ArrayList<View> view = new ArrayList<View>();
	Context context;
    public   MyPhoneList  ( ArrayList<HashMap<String, String>> arraylist, Context context){
		this.arraylist = arraylist;
		this.context = context;
   }

    @Override
	public int getCount() {
		// TODO Auto-generated method stub
		return arraylist.size();
	}

	@Override
	public Object getItem(int position) {
		// TODO Auto-generated method stub
		return arraylist.get(position);
	}

	@Override
	public long getItemId(int position) {
		// TODO Auto-generated method stub
		return position;
	}

	@Override
	public View getView(int position, View convertView, ViewGroup parent) {
		// TODO Auto-generated method stub
		ViewHolder  hodler=null;
		if (convertView==null) {
			hodler=new ViewHolder();
			convertView=LayoutInflater.from(context).inflate(R.layout.phoneitem, null);
		    hodler.tv=(TextView) convertView.findViewById(R.id.list_text);
		    hodler.iv=(ImageView) convertView.findViewById(R.id.list_image);
		    convertView.setTag(hodler);
		    view.add(convertView);
		}else{
			hodler=(ViewHolder) convertView.getTag();
		}
		hodler.tv.setText((CharSequence)arraylist.get(position).get("list_text"));
		return convertView;
	}
   class  ViewHolder{
	   TextView  tv;
	   ImageView  iv;
   }
}
