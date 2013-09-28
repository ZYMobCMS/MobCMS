<?php
$this->breadcrumbs=array(
	'User Picture Favorites'=>array('index'),
	$model->id,
);

$this->menu=array(
	array('label'=>'List UserPictureFavorite','url'=>array('index')),
	array('label'=>'Create UserPictureFavorite','url'=>array('create')),
	array('label'=>'Update UserPictureFavorite','url'=>array('update','id'=>$model->id)),
	array('label'=>'Delete UserPictureFavorite','url'=>'#','linkOptions'=>array('submit'=>array('delete','id'=>$model->id),'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>'Manage UserPictureFavorite','url'=>array('admin')),
);
?>

<h1>View UserPictureFavorite #<?php echo $model->id; ?></h1>

<?php $this->widget('bootstrap.widgets.TbDetailView',array(
	'data'=>$model,
	'attributes'=>array(
		'id',
		'user_id',
		'picture_id',
		'add_time',
	),
)); ?>
