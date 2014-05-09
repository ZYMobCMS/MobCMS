<?php
$this->breadcrumbs=array(
	'Users'=>array('index'),
	$model->id,
);

$this->menu=array(
	array('label'=>'所有用户','url'=>array('index')),
	array('label'=>'添加用户','url'=>array('create')),
	array('label'=>'编辑用户','url'=>array('update','id'=>$model->id)),
	array('label'=>'删除用户','url'=>'#','linkOptions'=>array('submit'=>array('delete','id'=>$model->id),'confirm'=>'你确定要删除这个用户?')),
	array('label'=>'管理用户','url'=>array('admin')),
);
?>

<h1>用户详情 #<?php echo $model->id; ?></h1>

<?php $this->widget('bootstrap.widgets.TbDetailView',array(
	'data'=>array('id'=>$model->id,
                      'title'=>$model->title,
                      'source'=>$model->source,
                      'summary'=>$model->summary,
                      'author'=>$model->author,
                      'content'=>$model->content,
                      'publish_time'=>$model->publish_time,
                      'create_time'=>$model->create_time,
                      'status'=>$model->status,
                      'images'=>$model->images,
                      'update_time'=>$model->update_time,
                      'tab_type_id'=>$model->tab_type_id,
                      'category_id'=>$model->category_id,
                      'links'=>$model->links,
                      'comment_count'=>$model->comment_count,
                      'favorite_count'=>$model->favorite_count,
                      'commentable'=>$model->commentable,
                      'hot_news'=>$model->hot_news,
                      'industry_id'=>$model->industry_id,
                      ),
	'attributes'=>array(
		array('name'=>'id','lable'=>'编号'), 
		array('name'=>'login_name','lable'=>'登陆名'),
		array('name'=>'nick_name','label'=>'昵称'),
		array('name'=>'rigist_time','label'=>'注册时间'),
		array('name'=>'status','label'=>'状态'),
		array('name'=>'user_type_id','label'=>'用户类型'),
		array('name'=>'publish_time','label'=>'发布时间'),
		array('name'=>'msn','label'=>'msn'),
		array('name'=>'qq','label'=>'qq'),
		array('name'=>'email','label'=>'电子邮箱'),
		array('name'=>'phone','label'=>'座机'),
		array('name'=>'mobile','label'=>'手机'),
		array('name'=>'profile','label'=>'签名'),
		array('name'=>'links','label'=>'原文链接'),
		array('name'=>'comment_count','label'=>'评论数'),
		array('name'=>'favorite_count','label'=>'收藏数'),
		array('name'=>'commentable','label'=>'可否评论'),
		array('name'=>'hot_news','label'=>'是否热门'),
		array('name'=>'industry_id','label'=>'行业编号'),
	),
)); ?>
