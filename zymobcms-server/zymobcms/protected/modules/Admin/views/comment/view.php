<?php
$this->breadcrumbs=array(
	'Comments'=>array('index'),
	$model->title,
);

$this->menu=array(
	array('label'=>'List Comment','url'=>array('index')),
	array('label'=>'Create Comment','url'=>array('create')),
	array('label'=>'Update Comment','url'=>array('update','id'=>$model->comment_id)),
	array('label'=>'Delete Comment','url'=>'#','linkOptions'=>array('submit'=>array('delete','id'=>$model->comment_id),'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>'Manage Comment','url'=>array('admin')),
);
?>

<h1>View Comment #<?php echo $model->comment_id; ?></h1>

<?php $this->widget('bootstrap.widgets.TbDetailView',array(
	'data'=>$model,
	'attributes'=>array(
		'comment_id',
		'article_id',
		'content',
		'create_time',
		'create_user',
		'to_users',
		'status',
		'support_count',
		'unsupport_count',
		'title',
	),
)); ?>
