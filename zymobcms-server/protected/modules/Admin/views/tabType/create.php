<?php
/* @var $this TabTypeController */
/* @var $model TabType */

$this->breadcrumbs=array(
	'Tab Types'=>array('index'),
	'Create',
);

$this->menu=array(
	array('label'=>'List TabType', 'url'=>array('index')),
	array('label'=>'Manage TabType', 'url'=>array('admin')),
);
?>

<h1>Create TabType</h1>

<?php echo $this->renderPartial('_form', array('model'=>$model)); ?>