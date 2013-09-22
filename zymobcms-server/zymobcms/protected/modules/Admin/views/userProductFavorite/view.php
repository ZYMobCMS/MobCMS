<?php
$this->breadcrumbs=array(
	'User Product Favorites'=>array('index'),
	$model->id,
);

$this->menu=array(
	array('label'=>'List UserProductFavorite','url'=>array('index')),
	array('label'=>'Create UserProductFavorite','url'=>array('create')),
	array('label'=>'Update UserProductFavorite','url'=>array('update','id'=>$model->id)),
	array('label'=>'Delete UserProductFavorite','url'=>'#','linkOptions'=>array('submit'=>array('delete','id'=>$model->id),'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>'Manage UserProductFavorite','url'=>array('admin')),
);
?>

<h1>View UserProductFavorite #<?php echo $model->id; ?></h1>

<?php $this->widget('bootstrap.widgets.TbDetailView',array(
	'data'=>$model,
	'attributes'=>array(
		'id',
		'user_id',
		'product_id',
		'add_time',
	),
)); ?>
