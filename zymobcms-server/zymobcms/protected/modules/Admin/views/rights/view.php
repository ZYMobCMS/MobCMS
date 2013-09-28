<?php
$this->breadcrumbs=array(
	'Rights'=>array('index'),
	$model->name,
);

$this->menu=array(
	array('label'=>'List Rights','url'=>array('index')),
	array('label'=>'Create Rights','url'=>array('create')),
	array('label'=>'Update Rights','url'=>array('update','id'=>$model->id)),
	array('label'=>'Delete Rights','url'=>'#','linkOptions'=>array('submit'=>array('delete','id'=>$model->id),'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>'Manage Rights','url'=>array('admin')),
);
?>

<h1>View Rights #<?php echo $model->id; ?></h1>

<?php $this->widget('bootstrap.widgets.TbDetailView',array(
	'data'=>$model,
	'attributes'=>array(
		'id',
		'name',
		'module_id',
		'create_user',
		'create_time',
		'index',
		'icon',
		'is_local_icon',
	),
)); ?>
