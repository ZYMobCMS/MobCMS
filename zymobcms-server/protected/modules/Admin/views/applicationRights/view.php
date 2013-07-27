<?php
/* @var $this ApplicationRightsController */
/* @var $model ApplicationRights */

$this->breadcrumbs=array(
	'Application Rights'=>array('index'),
	$model->user_id,
);

$this->menu=array(
	array('label'=>'List ApplicationRights', 'url'=>array('index')),
	array('label'=>'Create ApplicationRights', 'url'=>array('create')),
	array('label'=>'Update ApplicationRights', 'url'=>array('update', 'id'=>$model->user_id)),
	array('label'=>'Delete ApplicationRights', 'url'=>'#', 'linkOptions'=>array('submit'=>array('delete','id'=>$model->user_id),'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>'Manage ApplicationRights', 'url'=>array('admin')),
);
?>

<h1>View ApplicationRights #<?php echo $model->user_id; ?></h1>

<?php $this->widget('zii.widgets.CDetailView', array(
	'data'=>$model,
	'attributes'=>array(
		'category_right',
		'topic_right',
		'user_center_right',
		'picture_right',
		'user_id',
		'user_type_id',
	),
)); ?>
