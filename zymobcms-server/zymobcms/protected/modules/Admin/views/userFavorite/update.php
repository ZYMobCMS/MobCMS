<?php
/* @var $this UserFavoriteController */
/* @var $model UserFavorite */

$this->breadcrumbs=array(
	'User Favorites'=>array('index'),
	$model->id=>array('view','id'=>$model->id),
	'Update',
);

$this->menu=array(
	array('label'=>'List UserFavorite', 'url'=>array('index')),
	array('label'=>'Create UserFavorite', 'url'=>array('create')),
	array('label'=>'View UserFavorite', 'url'=>array('view', 'id'=>$model->id)),
	array('label'=>'Manage UserFavorite', 'url'=>array('admin')),
);
?>

<h1>Update UserFavorite <?php echo $model->id; ?></h1>

<?php echo $this->renderPartial('_form', array('model'=>$model)); ?>