<?php
$this->breadcrumbs=array(
	'Product Comment Supports'=>array('index'),
	$model->id,
);

$this->menu=array(
	array('label'=>'List ProductCommentSupport','url'=>array('index')),
	array('label'=>'Create ProductCommentSupport','url'=>array('create')),
	array('label'=>'Update ProductCommentSupport','url'=>array('update','id'=>$model->id)),
	array('label'=>'Delete ProductCommentSupport','url'=>'#','linkOptions'=>array('submit'=>array('delete','id'=>$model->id),'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>'Manage ProductCommentSupport','url'=>array('admin')),
);
?>

<h1>View ProductCommentSupport #<?php echo $model->id; ?></h1>

<?php $this->widget('bootstrap.widgets.TbDetailView',array(
	'data'=>$model,
	'attributes'=>array(
		'id',
		'comment_id',
		'user_id',
	),
)); ?>
