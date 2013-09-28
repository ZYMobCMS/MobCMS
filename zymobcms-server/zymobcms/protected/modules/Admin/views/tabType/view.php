<?php
$this->breadcrumbs=array(
	'Tab Types'=>array('index'),
	$model->name,
);

$this->menu=array(
	array('label'=>'List TabType','url'=>array('index')),
	array('label'=>'Create TabType','url'=>array('create')),
	array('label'=>'Update TabType','url'=>array('update','id'=>$model->id)),
	array('label'=>'Delete TabType','url'=>'#','linkOptions'=>array('submit'=>array('delete','id'=>$model->id),'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>'Manage TabType','url'=>array('admin')),
);
?>

<h1>View TabType #<?php echo $model->id; ?></h1>

<?php $this->widget('bootstrap.widgets.TbDetailView',array(
	'data'=>$model,
	'attributes'=>array(
		'id',
		'name',
		'create_user',
		'status',
		'create_time',
		'category_id',
		'icon',
		'is_local_icon',
	),
)); ?>
