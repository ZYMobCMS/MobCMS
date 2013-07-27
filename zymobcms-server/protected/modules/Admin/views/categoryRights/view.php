<?php
/* @var $this CategoryRightsController */
/* @var $model CategoryRights */

$this->breadcrumbs=array(
	'Category Rights'=>array('index'),
	$model->id,
);

$this->menu=array(
	array('label'=>'List CategoryRights', 'url'=>array('index')),
	array('label'=>'Create CategoryRights', 'url'=>array('create')),
	array('label'=>'Update CategoryRights', 'url'=>array('update', 'id'=>$model->id)),
	array('label'=>'Delete CategoryRights', 'url'=>'#', 'linkOptions'=>array('submit'=>array('delete','id'=>$model->id),'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>'Manage CategoryRights', 'url'=>array('admin')),
);
?>

<h1>View CategoryRights #<?php echo $model->id; ?></h1>

<?php $this->widget('zii.widgets.CDetailView', array(
	'data'=>$model,
	'attributes'=>array(
		'id',
		'category_id',
		'tab_type_id',
		'update_time',
	),
)); ?>
