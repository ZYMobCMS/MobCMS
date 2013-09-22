<?php
$this->breadcrumbs=array(
	'User Product Favorites'=>array('index'),
	$model->id=>array('view','id'=>$model->id),
	'Update',
);

$this->menu=array(
	array('label'=>'List UserProductFavorite','url'=>array('index')),
	array('label'=>'Create UserProductFavorite','url'=>array('create')),
	array('label'=>'View UserProductFavorite','url'=>array('view','id'=>$model->id)),
	array('label'=>'Manage UserProductFavorite','url'=>array('admin')),
);
?>

<h1>Update UserProductFavorite <?php echo $model->id; ?></h1>

<?php echo $this->renderPartial('_form',array('model'=>$model)); ?>