<?php
$this->breadcrumbs=array(
	'User Actives'=>array('index'),
	$model->id,
);

$this->menu=array(
	array('label'=>'List UserActive','url'=>array('index')),
	array('label'=>'Create UserActive','url'=>array('create')),
	array('label'=>'Update UserActive','url'=>array('update','id'=>$model->id)),
	array('label'=>'Delete UserActive','url'=>'#','linkOptions'=>array('submit'=>array('delete','id'=>$model->id),'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>'Manage UserActive','url'=>array('admin')),
);
?>

<h1>View UserActive #<?php echo $model->id; ?></h1>

<?php $this->widget('bootstrap.widgets.TbDetailView',array(
	'data'=>$model,
	'attributes'=>array(
		'id',
		'relation_id',
		'relation_table',
		'content',
		'create_time',
		'status',
		'create_user',
		'active_type_id',
		'relation_images',
		'refer_user',
		'create_login_name',
		'create_nick_name',
		'relation_title',
	),
)); ?>
