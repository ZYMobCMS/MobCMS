<?php
/* @var $this RightsController */
/* @var $model Rights */

$this->breadcrumbs=array(
	'Rights'=>array('index'),
	$model->name=>array('view','id'=>$model->id),
	'Update',
);

$this->menu=array(
	array('label'=>'List Rights', 'url'=>array('index')),
	array('label'=>'Create Rights', 'url'=>array('create')),
	array('label'=>'View Rights', 'url'=>array('view', 'id'=>$model->id)),
	array('label'=>'Manage Rights', 'url'=>array('admin')),
);
?>

<h1>Update Rights <?php echo $model->id; ?></h1>

<?php echo $this->renderPartial('_form', array('model'=>$model)); ?>