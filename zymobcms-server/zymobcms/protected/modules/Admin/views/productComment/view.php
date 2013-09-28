<?php
$this->breadcrumbs=array(
	'Product Comments'=>array('index'),
	$model->title,
);

$this->menu=array(
	array('label'=>'List ProductComment','url'=>array('index')),
	array('label'=>'Create ProductComment','url'=>array('create')),
	array('label'=>'Update ProductComment','url'=>array('update','id'=>$model->comment_id)),
	array('label'=>'Delete ProductComment','url'=>'#','linkOptions'=>array('submit'=>array('delete','id'=>$model->comment_id),'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>'Manage ProductComment','url'=>array('admin')),
);
?>

<h1>View ProductComment #<?php echo $model->comment_id; ?></h1>

<?php $this->widget('bootstrap.widgets.TbDetailView',array(
	'data'=>$model,
	'attributes'=>array(
		'comment_id',
		'product_id',
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
