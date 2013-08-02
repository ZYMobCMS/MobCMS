<?php
/* @var $this PictureTypeController */
/* @var $model PictureType */

$this->breadcrumbs=array(
	'Picture Types'=>array('index'),
	'Create',
);

$this->menu=array(
	array('label'=>'List PictureType', 'url'=>array('index')),
	array('label'=>'Manage PictureType', 'url'=>array('admin')),
);
?>

<h1>Create PictureType</h1>

<?php echo $this->renderPartial('_form', array('model'=>$model)); ?>