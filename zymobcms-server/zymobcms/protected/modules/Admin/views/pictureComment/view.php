<?php
$this->breadcrumbs=array(
	'Picture Comments'=>array('index'),
	$model->title,
);

$this->menu=array(
	array('label'=>'List PictureComment','url'=>array('index')),
	array('label'=>'Create PictureComment','url'=>array('create')),
	array('label'=>'Update PictureComment','url'=>array('update','id'=>$model->comment_id)),
	array('label'=>'Delete PictureComment','url'=>'#','linkOptions'=>array('submit'=>array('delete','id'=>$model->comment_id),'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>'Manage PictureComment','url'=>array('admin')),
);
?>

<h1>View PictureComment #<?php echo $model->comment_id; ?></h1>

<?php $this->widget('bootstrap.widgets.TbDetailView',array(
	'data'=>$model,
	'attributes'=>array(
		'comment_id',
		'picture_id',
		'content',
		'create_time',
		'create_user',
		'to_users',
		'status',
		'support_count',
		'unsupport_count',
		'title',
	),
)); ?>
