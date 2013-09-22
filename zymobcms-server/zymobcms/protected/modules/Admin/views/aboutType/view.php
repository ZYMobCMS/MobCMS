<?php
$this->breadcrumbs=array(
	'About Types'=>array('index'),
	$model->id,
);

$this->menu=array(
	array('label'=>'List AboutType','url'=>array('index')),
	array('label'=>'Create AboutType','url'=>array('create')),
	array('label'=>'Update AboutType','url'=>array('update','id'=>$model->id)),
	array('label'=>'Delete AboutType','url'=>'#','linkOptions'=>array('submit'=>array('delete','id'=>$model->id),'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>'Manage AboutType','url'=>array('admin')),
);
?>

<h1>View AboutType #<?php echo $model->id; ?></h1>

<?php $this->widget('bootstrap.widgets.TbDetailView',array(
	'data'=>$model,
	'attributes'=>array(
		'id',
		'type_name',
	),
)); ?>
