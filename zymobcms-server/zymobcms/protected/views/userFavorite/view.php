<?php
$this->breadcrumbs=array(
	'User Favorites'=>array('index'),
	$model->id,
);

$this->menu=array(
	array('label'=>'List UserFavorite','url'=>array('index')),
	array('label'=>'Create UserFavorite','url'=>array('create')),
	array('label'=>'Update UserFavorite','url'=>array('update','id'=>$model->id)),
	array('label'=>'Delete UserFavorite','url'=>'#','linkOptions'=>array('submit'=>array('delete','id'=>$model->id),'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>'Manage UserFavorite','url'=>array('admin')),
);
?>

<h1>View UserFavorite #<?php echo $model->id; ?></h1>

<?php $this->widget('bootstrap.widgets.TbDetailView',array(
	'data'=>$model,
	'attributes'=>array(
		'id',
		'user_id',
		'article_id',
		'add_time',
	),
)); ?>
