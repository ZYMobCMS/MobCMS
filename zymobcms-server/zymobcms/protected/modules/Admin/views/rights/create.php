<?php
/* @var $this RightsController */
/* @var $model Rights */

$this->breadcrumbs=array(
	'Rights'=>array('index'),
	'Create',
);

$this->menu=array(
	array('label'=>'List Rights', 'url'=>array('index')),
	array('label'=>'Manage Rights', 'url'=>array('admin')),
);
?>

<h1>Create Rights</h1>

<?php echo $this->renderPartial('_form', array('model'=>$model)); ?>