<?php
$this->breadcrumbs=array(
	'User Actives'=>array('index'),
	$model->id=>array('view','id'=>$model->id),
	'Update',
);

$this->menu=array(
	array('label'=>'List UserActive','url'=>array('index')),
	array('label'=>'Create UserActive','url'=>array('create')),
	array('label'=>'View UserActive','url'=>array('view','id'=>$model->id)),
	array('label'=>'Manage UserActive','url'=>array('admin')),
);
?>

<h1>Update UserActive <?php echo $model->id; ?></h1>

<?php echo $this->renderPartial('_form',array('model'=>$model)); ?>