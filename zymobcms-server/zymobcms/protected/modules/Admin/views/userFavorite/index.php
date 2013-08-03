<?php
/* @var $this UserFavoriteController */
/* @var $dataProvider CActiveDataProvider */

$this->breadcrumbs=array(
	'User Favorites',
);

$this->menu=array(
	array('label'=>'Create UserFavorite', 'url'=>array('create')),
	array('label'=>'Manage UserFavorite', 'url'=>array('admin')),
);
?>

<h1>User Favorites</h1>

<?php $this->widget('zii.widgets.CListView', array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); ?>
