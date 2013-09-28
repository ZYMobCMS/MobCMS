<?php
$this->breadcrumbs=array(
	'Application Owners'=>array('index'),
	$model->name,
);

$this->menu=array(
	array('label'=>'List ApplicationOwner','url'=>array('index')),
	array('label'=>'Create ApplicationOwner','url'=>array('create')),
	array('label'=>'Update ApplicationOwner','url'=>array('update','id'=>$model->owner_id)),
	array('label'=>'Delete ApplicationOwner','url'=>'#','linkOptions'=>array('submit'=>array('delete','id'=>$model->owner_id),'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>'Manage ApplicationOwner','url'=>array('admin')),
);
?>

<h1>View ApplicationOwner #<?php echo $model->owner_id; ?></h1>

<?php $this->widget('bootstrap.widgets.TbDetailView',array(
	'data'=>$model,
	'attributes'=>array(
		'owner_id',
		'status',
		'name',
		'appId',
		'pem_path',
	),
)); ?>
