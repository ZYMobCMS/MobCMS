<?php
/* @var $this UserTypeController */
/* @var $model UserType */

$this->breadcrumbs=array(
	'User Types'=>array('index'),
	$model->id=>array('view','id'=>$model->id),
	'Update',
);

$this->menu=array(
	array('label'=>'List UserType', 'url'=>array('index')),
	array('label'=>'Create UserType', 'url'=>array('create')),
	array('label'=>'View UserType', 'url'=>array('view', 'id'=>$model->id)),
	array('label'=>'Manage UserType', 'url'=>array('admin')),
);
?>

<h1>Update UserType <?php echo $model->id; ?></h1>

<?php echo $this->renderPartial('_form', array('model'=>$model)); ?>