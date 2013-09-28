<?php
$this->breadcrumbs=array(
	'User Replies'=>array('index'),
	$model->id,
);

$this->menu=array(
	array('label'=>'List UserReply','url'=>array('index')),
	array('label'=>'Create UserReply','url'=>array('create')),
	array('label'=>'Update UserReply','url'=>array('update','id'=>$model->id)),
	array('label'=>'Delete UserReply','url'=>'#','linkOptions'=>array('submit'=>array('delete','id'=>$model->id),'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>'Manage UserReply','url'=>array('admin')),
);
?>

<h1>View UserReply #<?php echo $model->id; ?></h1>

<?php $this->widget('bootstrap.widgets.TbDetailView',array(
	'data'=>$model,
	'attributes'=>array(
		'id',
		'custom_user_id',
		'content',
		'cretate_time',
		'status',
	),
)); ?>
