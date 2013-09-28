<?php
$this->breadcrumbs=array(
	'Product Tab Types'=>array('index'),
	$model->id,
);

$this->menu=array(
	array('label'=>'List ProductTabType','url'=>array('index')),
	array('label'=>'Create ProductTabType','url'=>array('create')),
	array('label'=>'Update ProductTabType','url'=>array('update','id'=>$model->id)),
	array('label'=>'Delete ProductTabType','url'=>'#','linkOptions'=>array('submit'=>array('delete','id'=>$model->id),'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>'Manage ProductTabType','url'=>array('admin')),
);
?>

<h1>View ProductTabType #<?php echo $model->id; ?></h1>

<?php $this->widget('bootstrap.widgets.TbDetailView',array(
	'data'=>$model,
	'attributes'=>array(
		'id',
		'type_name',
		'create_time',
		'create_user',
		'category_id',
		'icon',
		'is_local_icon',
	),
)); ?>
