<?php
$this->breadcrumbs=array(
	'Device Types'=>array('index'),
	$model->name,
);

$this->menu=array(
	array('label'=>'List DeviceType','url'=>array('index')),
	array('label'=>'Create DeviceType','url'=>array('create')),
	array('label'=>'Update DeviceType','url'=>array('update','id'=>$model->id)),
	array('label'=>'Delete DeviceType','url'=>'#','linkOptions'=>array('submit'=>array('delete','id'=>$model->id),'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>'Manage DeviceType','url'=>array('admin')),
);
?>

<h1>View DeviceType #<?php echo $model->id; ?></h1>

<?php $this->widget('bootstrap.widgets.TbDetailView',array(
	'data'=>$model,
	'attributes'=>array(
		'id',
		'name',
		'create_time',
	),
)); ?>
