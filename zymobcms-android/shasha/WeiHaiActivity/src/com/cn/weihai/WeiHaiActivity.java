package com.cn.weihai;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import com.cn.weihai.Adapter.MyListAdapter;

import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.os.Parcelable;
import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.support.v4.view.PagerAdapter;
import android.support.v4.view.ViewPager;
import android.support.v4.view.ViewPager.OnPageChangeListener;
import android.view.KeyEvent;
import android.view.Menu;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.Window;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.ListView;

public class WeiHaiActivity extends Activity  {

	 private int[] imageIds;
	    Button  bu1;
	    private List<ImageView> imageViews;
	    private List<View> dots;
	    private ViewPager viewPager;
	    private ListView  listView;
	    private ScheduledExecutorService  scheduledExecutorService;
	    private int currentItem=0;//当前页面
	    

	    OnClickListener click=new OnClickListener() {
			
			@Override
			public void onClick(View v) {
				Intent in;
				switch (currentItem) {
				case   0:
					in=new Intent(WeiHaiActivity.this, ViewPager1.class);
					startActivity(in);
					break;		
				case   1:
					in=new Intent(WeiHaiActivity.this, ViewPager2.class);
					startActivity(in);
					break;		
				case   2:
					in=new Intent(WeiHaiActivity.this, ViewPager3.class);
					startActivity(in);
					break;		
				case   3:
					in=new Intent(WeiHaiActivity.this, ViewPager4.class);
					startActivity(in);
					break;		
				case   4:
					in=new Intent(WeiHaiActivity.this, ViewPager5.class);
					startActivity(in);
					break;		
				}
			}
		};
	    
		@Override
		protected void onCreate(Bundle savedInstanceState) {
			super.onCreate(savedInstanceState);
			requestWindowFeature(Window.FEATURE_NO_TITLE);//去掉标题栏
			setContentView(R.layout.activity_wei_hai);
			 //把本身activity添加到exit_app里面addActivity的数组中
	        Exit_app.getInstance().addActivity(WeiHaiActivity.this);
			//listview加载适配器
			listView=(ListView) findViewById(R.id.lv);
			MyListAdapter myListAdapter=new MyListAdapter(this);
			listView.setAdapter( myListAdapter);
			listView.setOnItemClickListener(new OnItemClickListener() {
				
				
				
				
			@Override
			public void onItemClick(AdapterView<?> parent, View view,
					int position, long id) {
				Intent in;
				// TODO Auto-generated method stub
					switch (position) {
					case 0:
					 in=new Intent(WeiHaiActivity.this, Intent0.class);
				     startActivity(in);
						break;
					case 1:
					in=new Intent(WeiHaiActivity.this, Intent1.class); 
					startActivity(in);
					break;
				   case 2:
					in=new Intent(WeiHaiActivity.this, Intent2.class);
					startActivity(in);
				   break;
				   case 3:
						in=new Intent(WeiHaiActivity.this, Intent3.class);
						startActivity(in);
					break;
					case 4:
						in=new Intent(WeiHaiActivity.this, Intent4.class);
					startActivity(in);
						break;
					case 5:
						in=new Intent(WeiHaiActivity.this, Intent5.class);
					startActivity(in);
						break;
					case 6:
					in=new Intent(WeiHaiActivity.this, Intent6.class);
						startActivity(in);
						break;
					case 7:
						in=new Intent(WeiHaiActivity.this, Intent7.class);
						startActivity(in);
						break;
				
				}
				}
			});
			
			bu1=(Button) findViewById(R.id.bt2);
			
			
			//图片资源
			imageIds=new int[]{R.drawable.a1,R.drawable.a2,
					           R.drawable.a3,R.drawable.a4,R.drawable.a5};
			//滑动的图片
			imageViews=new ArrayList<ImageView>();
			for (int i = 0; i < imageIds.length; i++) {
				ImageView  imageView=new ImageView(this);
				imageView.setImageResource(imageIds[i]);
				
				imageViews.add(imageView);
				imageView.setOnClickListener(click);
				
			}
			//图片所对应的圆点
			dots=new ArrayList<View>();
			dots.add(findViewById(R.id.v_dot0));
			dots.add(findViewById(R.id.v_dot1));
			dots.add(findViewById(R.id.v_dot2));
			dots.add(findViewById(R.id.v_dot3));
			dots.add(findViewById(R.id.v_dot4));
			viewPager=(ViewPager)findViewById(R.id.vp);
			//给viewpager添加数据
			viewPager.setAdapter(new MyViewPager());
//			viewPager.setOn
			//页面改变监听
			viewPager.setOnPageChangeListener(new OnPageChangeListener() {
				private int oldPosition=0;
				@Override
				public void onPageSelected(int arg0) {
					// TODO Auto-generated method stub
					currentItem=arg0;
					//改变圆点
					dots.get(oldPosition).setBackgroundResource(R.drawable.dot_normal);
					dots.get(arg0).setBackgroundResource(R.drawable.dot_focused);
					oldPosition=arg0;
					Intent in;

				
			}
				
				@Override
				public void onPageScrolled(int arg0, float arg1, int arg2) {
					// TODO Auto-generated method stub
					
				}
				
				@Override
				public void onPageScrollStateChanged(int arg0) {
					// TODO Auto-generated method stub
					
				}
			});
			
		}
		
		public void danji(View v){
			Intent in;
			switch (v.getId()) {
			case R.id.bt2:
				in=new Intent(WeiHaiActivity.this,Introduce.class);
				startActivity(in);
				finish();
				break;
			case R.id.bt3:
				in=new Intent(WeiHaiActivity.this, Online.class);
				in.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP); 
				startActivity(in);
				break;
			case R.id.bt4:
				in=new Intent(WeiHaiActivity.this, Phone.class);
				in.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP); 
				startActivity(in);
				break;
			case R.id.bt5:
				in=new Intent(WeiHaiActivity.this, More.class);
				startActivity(in);
				finish();
				break;

			}
		}
	    class MyViewPager extends PagerAdapter{

			@Override
			public int getCount() {
				// TODO Auto-generated method stub
				return imageIds.length;
			}
			//实例化item  
					@Override
			public Object instantiateItem(View arg0, int arg1) {
						//将每个图片加入到ViewPager里
				((ViewPager)arg0).addView(imageViews.get(arg1));
			
				return imageViews.get(arg1);
			
			}

					@Override
			public void destroyItem(View arg0, int arg1, Object arg2) {
					//将每个图片在ViewPager里释放掉
				((ViewPager)arg0).removeView((View)arg2);
			}
			@Override
			public boolean isViewFromObject(View arg0, Object arg1) {
				// TODO Auto-generated method stub
				//view 和object是不是一个对象
				return arg0==arg1;
			}
			@Override
			public void finishUpdate(View arg0) {
				// TODO Auto-generated method stub
				
			}

			@Override
			public void restoreState(Parcelable arg0, ClassLoader arg1) {
				// TODO Auto-generated method stub
				
			}

			@Override
			public Parcelable saveState() {
				// TODO Auto-generated method stub
				return null;
			}

			@Override
			public void startUpdate(View arg0) {
				// TODO Auto-generated method stub
				
			}
	    }
		@Override
		protected void onStart() {
			// TODO Auto-generated method stub
			scheduledExecutorService=Executors.newSingleThreadScheduledExecutor();
			        //通过定时器 来完成 每2秒钟切换一个图片
					//经过指定的时间后，执行所指定的任务
					//scheduleAtFixedRate(command, initialDelay, period, unit)
					//command 所要执行的任务
					//initialDelay 第一次启动时 延迟启动时间 
					//period  每间隔多次时间来重新启动任务
					//unit 时间单位
			scheduledExecutorService.scheduleAtFixedRate(new ViewPagerTask(), 1, 2, TimeUnit.SECONDS);
			super.onStart();
		}
		@Override
		protected void onStop() {
			// TODO Auto-generated method stub
			 //停止图片
			scheduledExecutorService.shutdown();
			super.onStop();	 
		}
		//用来完成图片切换的任务
		private class ViewPagerTask implements Runnable{

			@Override
			public void run() {
				// TODO Auto-generated method stub
				currentItem=(currentItem+1)%imageViews.size();
				handler.obtainMessage().sendToTarget();
			}		
		}
	   private Handler handler=new Handler(){
		   public void handleMessage(Message msg) {
			  //设定viewpager当前页面
			   viewPager.setCurrentItem(currentItem);
		   }
	   };

	   @Override  
	   public boolean onKeyDown(int keyCode, KeyEvent event)  
	   {  
	       if (keyCode == KeyEvent.KEYCODE_BACK )  
	       {  
	           // 创建退出对话框  
	           AlertDialog isExit = new AlertDialog.Builder(this).create();  
	           // 设置对话框标题  
	           isExit.setTitle("系统提示");  
	           // 设置对话框消息  
	           isExit.setMessage("确定要退出吗");  
	           // 添加选择按钮并注册监听  
	           isExit.setButton("确定", listener);  
	           isExit.setButton2("取消", listener);  
	           // 显示对话框  
	           isExit.show();  
	 
	       }  
	         
	       return false;  
	         
	   }  
	   /**监听对话框里面的button点击事件*/  
	   DialogInterface.OnClickListener listener = new DialogInterface.OnClickListener()  
	   {  
	       public void onClick(DialogInterface dialog, int which)  
	       {  
	           switch (which)  
	           {  
	           case AlertDialog.BUTTON_POSITIVE:// "确认"按钮退出程序  
	        		Exit_app.getInstance().exit(); 
	               break;  
	           case AlertDialog.BUTTON_NEGATIVE:// "取消"第二个按钮取消对话框  
	               break;             
	           }  
	       }  
	   };    
	}

