<?php
$this->breadcrumbs=array(
	'Active Types'=>array('index'),
	$model->id=>array('view','id'=>$model->id),
	'Update',
);

$this->menu=array(
	array('label'=>'List ActiveType','url'=>array('index')),
	array('label'=>'Create ActiveType','url'=>array('create')),
	array('label'=>'View ActiveType','url'=>array('view','id'=>$model->id)),
	array('label'=>'Manage ActiveType','url'=>array('admin')),
);
?>

<h1>Update ActiveType <?php echo $model->id; ?></h1>

<?php echo $this->renderPartial('_form',array('model'=>$model)); ?>