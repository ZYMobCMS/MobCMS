<?php
/* @var $this TabTypeController */
/* @var $model TabType */

$this->breadcrumbs=array(
	'Tab Types'=>array('index'),
	$model->name=>array('view','id'=>$model->id),
	'Update',
);

$this->menu=array(
	array('label'=>'List TabType', 'url'=>array('index')),
	array('label'=>'Create TabType', 'url'=>array('create')),
	array('label'=>'View TabType', 'url'=>array('view', 'id'=>$model->id)),
	array('label'=>'Manage TabType', 'url'=>array('admin')),
);
?>

<h1>Update TabType <?php echo $model->id; ?></h1>

<?php echo $this->renderPartial('_form', array('model'=>$model)); ?>