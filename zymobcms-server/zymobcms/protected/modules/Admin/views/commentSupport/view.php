<?php
$this->breadcrumbs=array(
	'Comment Supports'=>array('index'),
	$model->id,
);

$this->menu=array(
	array('label'=>'List CommentSupport','url'=>array('index')),
	array('label'=>'Create CommentSupport','url'=>array('create')),
	array('label'=>'Update CommentSupport','url'=>array('update','id'=>$model->id)),
	array('label'=>'Delete CommentSupport','url'=>'#','linkOptions'=>array('submit'=>array('delete','id'=>$model->id),'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>'Manage CommentSupport','url'=>array('admin')),
);
?>

<h1>View CommentSupport #<?php echo $model->id; ?></h1>

<?php $this->widget('bootstrap.widgets.TbDetailView',array(
	'data'=>$model,
	'attributes'=>array(
		'id',
		'comment_id',
		'user_id',
	),
)); ?>
