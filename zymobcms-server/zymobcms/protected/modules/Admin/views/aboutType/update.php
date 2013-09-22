<?php
$this->breadcrumbs=array(
	'About Types'=>array('index'),
	$model->id=>array('view','id'=>$model->id),
	'Update',
);

$this->menu=array(
	array('label'=>'List AboutType','url'=>array('index')),
	array('label'=>'Create AboutType','url'=>array('create')),
	array('label'=>'View AboutType','url'=>array('view','id'=>$model->id)),
	array('label'=>'Manage AboutType','url'=>array('admin')),
);
?>

<h1>Update AboutType <?php echo $model->id; ?></h1>

<?php echo $this->renderPartial('_form',array('model'=>$model)); ?>