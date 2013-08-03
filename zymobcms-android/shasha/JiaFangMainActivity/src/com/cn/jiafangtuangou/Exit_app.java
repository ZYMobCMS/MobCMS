package com.cn.jiafangtuangou;

import java.util.ArrayList;
import java.util.List;

import android.app.Activity;
import android.app.Application;

public class Exit_app extends Application {
	 //定义数组用来存放打开的activity
		private  List<Activity>  shuzu=new ArrayList<Activity>();
		//定义变量存放exit_app对象
		private static Exit_app instance=null;
		//私有构造为了避免外界直接使用new来实例化对象
//		private Exit_app(){};
		
		//用来创建exit_app对象--序列化
		public synchronized  static Exit_app  getInstance(){
			if(instance==null){
				instance=new Exit_app();
			}
			return instance;		
		}
		//把每个activity存到数组中
		public void addActivity(Activity activity){
			shuzu.add(activity);
		}
		
		  public void exit(){
			  //遍历数组
			  for(Activity  activity:shuzu){
				  if(instance!=null){
					  activity.finish();
				  }
			  }
		  }
	}

