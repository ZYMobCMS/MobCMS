<?php
/* @var $this PictureTypeController */
/* @var $model PictureType */

$this->breadcrumbs=array(
	'Picture Types'=>array('index'),
	$model->id,
);

$this->menu=array(
	array('label'=>'List PictureType', 'url'=>array('index')),
	array('label'=>'Create PictureType', 'url'=>array('create')),
	array('label'=>'Update PictureType', 'url'=>array('update', 'id'=>$model->id)),
	array('label'=>'Delete PictureType', 'url'=>'#', 'linkOptions'=>array('submit'=>array('delete','id'=>$model->id),'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>'Manage PictureType', 'url'=>array('admin')),
);
?>

<h1>View PictureType #<?php echo $model->id; ?></h1>

<?php $this->widget('zii.widgets.CDetailView', array(
	'data'=>$model,
	'attributes'=>array(
		'id',
		'type_name',
		'create_user',
		'add_time',
		'status',
	),
)); ?>
