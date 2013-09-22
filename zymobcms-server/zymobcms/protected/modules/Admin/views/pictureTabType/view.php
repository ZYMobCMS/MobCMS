<?php
$this->breadcrumbs=array(
	'Picture Tab Types'=>array('index'),
	$model->id,
);

$this->menu=array(
	array('label'=>'List PictureTabType','url'=>array('index')),
	array('label'=>'Create PictureTabType','url'=>array('create')),
	array('label'=>'Update PictureTabType','url'=>array('update','id'=>$model->id)),
	array('label'=>'Delete PictureTabType','url'=>'#','linkOptions'=>array('submit'=>array('delete','id'=>$model->id),'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>'Manage PictureTabType','url'=>array('admin')),
);
?>

<h1>View PictureTabType #<?php echo $model->id; ?></h1>

<?php $this->widget('bootstrap.widgets.TbDetailView',array(
	'data'=>$model,
	'attributes'=>array(
		'id',
		'type_name',
		'create_time',
		'create_user',
		'category_id',
	),
)); ?>
