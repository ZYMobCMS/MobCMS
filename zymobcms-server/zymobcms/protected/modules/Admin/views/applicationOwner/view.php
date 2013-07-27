<?php
/* @var $this ApplicationOwnerController */
/* @var $model ApplicationOwner */

$this->breadcrumbs=array(
	'Application Owners'=>array('index'),
	$model->owner_id,
);

$this->menu=array(
	array('label'=>'List ApplicationOwner', 'url'=>array('index')),
	array('label'=>'Create ApplicationOwner', 'url'=>array('create')),
	array('label'=>'Update ApplicationOwner', 'url'=>array('update', 'id'=>$model->owner_id)),
	array('label'=>'Delete ApplicationOwner', 'url'=>'#', 'linkOptions'=>array('submit'=>array('delete','id'=>$model->owner_id),'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>'Manage ApplicationOwner', 'url'=>array('admin')),
);
?>

<h1>View ApplicationOwner #<?php echo $model->owner_id; ?></h1>

<?php $this->widget('zii.widgets.CDetailView', array(
	'data'=>$model,
	'attributes'=>array(
		'owner_id',
		'status',
	),
)); ?>
