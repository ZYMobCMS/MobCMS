<?php
$this->breadcrumbs=array(
	'Device Types'=>array('index'),
	$model->name=>array('view','id'=>$model->id),
	'Update',
);

$this->menu=array(
	array('label'=>'List DeviceType','url'=>array('index')),
	array('label'=>'Create DeviceType','url'=>array('create')),
	array('label'=>'View DeviceType','url'=>array('view','id'=>$model->id)),
	array('label'=>'Manage DeviceType','url'=>array('admin')),
);
?>

<h1>Update DeviceType <?php echo $model->id; ?></h1>

<?php echo $this->renderPartial('_form',array('model'=>$model)); ?>