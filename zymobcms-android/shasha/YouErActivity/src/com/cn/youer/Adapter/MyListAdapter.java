package com.cn.youer.Adapter;

import java.util.HashMap;
import java.util.List;
import com.cn.youer.R;
import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.TextView;

public class MyListAdapter extends BaseAdapter {

	private final int[] image={R.drawable.aa,R.drawable.ab,R.drawable.ac,
			                                R.drawable.ad,R.drawable.ae,R.drawable.af,
			                                R.drawable.ag,R.drawable.ah,R.drawable.ai,
			                                R.drawable.aj};
	  private  String[] text={"幼儿衣服","幼儿床","幼儿尿布","幼儿肚兜","幼儿餐具","幼儿奶粉"
			             ,"幼儿润肤露","幼儿爽肤粉","幼儿手套脚套","幼儿奶瓶"  };
		private  String[] text1={"质地高端   手感丝滑","打磨光滑, 手感极佳","柔软, 吸水性强",
		                              "透气吸水, 越细越软", "感温硅胶, 光滑无瑕疵", "体能, 智能, 动能, 养能",
		                              "精心设计的配方， 安全保湿因子","生产过程通过一系列严格的测试",
		                              "卫生安全, 舒适, 手感好","无毒, 无味, 不含双酚A"};
		private  String[] text2={"无甲醛的细腻好服饰","油漆环保无危害, 给孩子的都....","价格优惠, 手感好, 宝宝穿着....",
		                               "全方位呵护宝宝的小法宝 ", "人体工学设计, 质地轻巧, 宝....", "给宝宝一份精致的爱","一经涂抹, 就会快速融化",
		                               "喝经验....","给宝宝用上护手套, 就不会被....","喝奶顺畅, 口感极佳！"};
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

