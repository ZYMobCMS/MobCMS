<?php
/* @var $this UserFavoriteController */
/* @var $model UserFavorite */

$this->breadcrumbs=array(
	'User Favorites'=>array('index'),
	'Create',
);

$this->menu=array(
	array('label'=>'List UserFavorite', 'url'=>array('index')),
	array('label'=>'Manage UserFavorite', 'url'=>array('admin')),
);
?>

<h1>Create UserFavorite</h1>

<?php echo $this->renderPartial('_form', array('model'=>$model)); ?>