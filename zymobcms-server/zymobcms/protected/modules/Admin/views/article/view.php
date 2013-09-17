<?php
/* @var $this ArticleController */
/* @var $model Article */

$this->breadcrumbs=array(
	'Articles'=>array('index'),
	$model->title,
);

$this->menu=array(
	array('label'=>'List Article', 'url'=>array('index')),
	array('label'=>'Create Article', 'url'=>array('create')),
	array('label'=>'Update Article', 'url'=>array('update', 'id'=>$model->id)),
	array('label'=>'Delete Article', 'url'=>'#', 'linkOptions'=>array('submit'=>array('delete','id'=>$model->id),'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>'Manage Article', 'url'=>array('admin')),
);
?>

<h1>View Article #<?php echo $model->id; ?></h1>

<?php $this->widget('bootstrap.widgets.TbDetailView', array(
	'type'=>array('striped','bordered'),
	'data'=>array('id'=>$model->id,'title'=>$model->title,'source'=>$model->source,'summary'=>$model->summary,
	'author'=>$model->author,'content'=>$model->content,'publish_time'=>$model->publish_time,'create_time'=>$model->create_time,
	'images'=>$model->images,'links'=>$model->links,'comment_count'=>$model->comment_count,'favorite_count'=>$model->favorite_count,
	'commentable'=>$model->commentable,'hot_news'=>$model->hot_news,'status'=>$model->status
	),
	'attributes'=>array(
		array('name'=>'id','label'=>'编号'), 
		array('name'=>'title','label'=>'标题'),
		array('name'=>'source','label'=>'来源'),
		array('name'=>'summary','label'=>'概要'),
		array('name'=>'author','label'=>'作者'),
		array('name'=>'content','label'=>'内容'),
		array('name'=>'publish_time','label'=>'时间'),
		array('name'=>'create_time','label'=>'添加时间'),
		array('name'=>'status','label'=>'状态'),
		array('name'=>'images','label'=>'图片'),
		array('name'=>'links','label'=>'原文链接'),
		array('name'=>'comment_count','label'=>'评论数'),
		array('name'=>'favorite_count','label'=>'收藏数'),
		array('name'=>'commentable','label'=>'可否评论'),
		array('name'=>'hot_news','label'=>'热门新闻'),
	),
)); ?>
