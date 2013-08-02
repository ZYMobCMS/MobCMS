package com.cn.weihai.Adapter;

import java.util.HashMap;
import java.util.List;

import com.cn.weihai.R;

import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.TextView;

public class MyListAdapter extends BaseAdapter {

	private final int[] image={R.drawable.aa,R.drawable.ab,R.drawable.ac,
			                                R.drawable.ad,R.drawable.ae,R.drawable.af,
			                                R.drawable.ag,R.drawable.ah};
	  private  String[] text={"精美画册","期刊杂志","各种彩盒","热熔封套","小巧纸袋","不干胶贴"
			             ,"唯美油画","超级海报"  };
		private  String[] text1={"画册可以大气磅礴,  可以翔实细腻,","专业的团队打造高端产品, 有好的包","多种色彩   多种选择",
		                              "个性化装订    健康环保", "优质纸袋, 品质高", "专业生产各种不干胶制品, 主要从事",
		                              "油画首选威海印刷网,  为你量身","表面光洁,  明暗对比强烈而"};
		private  String[] text2={"可以缤纷多彩,  可以朴实无华","装, 才有好的开始","舒适从这里开始",
		                               "属于你的好装订 ", "样式多, 小巧精致", "不干胶, 透明不干胶, 条形码不干胶","设计不同风格的油画",
		                               "不失细节,  立体感强"};
	private static   Context  context;
	private static List<HashMap<String, String>>  list;
	public  MyListAdapter(Context context){
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

