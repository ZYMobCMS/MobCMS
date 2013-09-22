<?php
$this->breadcrumbs=array(
	'Product Tab Types'=>array('index'),
	$model->id=>array('view','id'=>$model->id),
	'Update',
);

$this->menu=array(
	array('label'=>'List ProductTabType','url'=>array('index')),
	array('label'=>'Create ProductTabType','url'=>array('create')),
	array('label'=>'View ProductTabType','url'=>array('view','id'=>$model->id)),
	array('label'=>'Manage ProductTabType','url'=>array('admin')),
);
?>

<h1>Update ProductTabType <?php echo $model->id; ?></h1>

<?php echo $this->renderPartial('_form',array('model'=>$model)); ?>