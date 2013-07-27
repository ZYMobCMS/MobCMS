<?php
/* @var $this PictureTypeController */
/* @var $model PictureType */

$this->breadcrumbs=array(
	'Picture Types'=>array('index'),
	$model->id=>array('view','id'=>$model->id),
	'Update',
);

$this->menu=array(
	array('label'=>'List PictureType', 'url'=>array('index')),
	array('label'=>'Create PictureType', 'url'=>array('create')),
	array('label'=>'View PictureType', 'url'=>array('view', 'id'=>$model->id)),
	array('label'=>'Manage PictureType', 'url'=>array('admin')),
);
?>

<h1>Update PictureType <?php echo $model->id; ?></h1>

<?php echo $this->renderPartial('_form', array('model'=>$model)); ?>