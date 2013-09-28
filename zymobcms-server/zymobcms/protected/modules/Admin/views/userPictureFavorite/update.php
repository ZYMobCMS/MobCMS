<?php
$this->breadcrumbs=array(
	'User Picture Favorites'=>array('index'),
	$model->id=>array('view','id'=>$model->id),
	'Update',
);

$this->menu=array(
	array('label'=>'List UserPictureFavorite','url'=>array('index')),
	array('label'=>'Create UserPictureFavorite','url'=>array('create')),
	array('label'=>'View UserPictureFavorite','url'=>array('view','id'=>$model->id)),
	array('label'=>'Manage UserPictureFavorite','url'=>array('admin')),
);
?>

<h1>Update UserPictureFavorite <?php echo $model->id; ?></h1>

<?php echo $this->renderPartial('_form',array('model'=>$model)); ?>