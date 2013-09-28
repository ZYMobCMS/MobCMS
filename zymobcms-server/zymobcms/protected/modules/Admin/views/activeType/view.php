<?php
$this->breadcrumbs=array(
	'Active Types'=>array('index'),
	$model->id,
);

$this->menu=array(
	array('label'=>'List ActiveType','url'=>array('index')),
	array('label'=>'Create ActiveType','url'=>array('create')),
	array('label'=>'Update ActiveType','url'=>array('update','id'=>$model->id)),
	array('label'=>'Delete ActiveType','url'=>'#','linkOptions'=>array('submit'=>array('delete','id'=>$model->id),'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>'Manage ActiveType','url'=>array('admin')),
);
?>

<h1>View ActiveType #<?php echo $model->id; ?></h1>

<?php $this->widget('bootstrap.widgets.TbDetailView',array(
	'data'=>$model,
	'attributes'=>array(
		'id',
		'type_name',
		'type_point',
		'create_user',
		'create_time',
		'status',
		'relation_table',
<<<<<<< HEAD
		'can_show_detail',
=======
>>>>>>> 9e438a74f5629d8503d3b4d558d27a1975878cdd
	),
)); ?>
