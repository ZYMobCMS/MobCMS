<?php
$this->breadcrumbs=array(
	'User Favorites',
);

$this->menu=array(
	array('label'=>'Create UserFavorite','url'=>array('create')),
	array('label'=>'Manage UserFavorite','url'=>array('admin')),
);
?>

<h1>User Favorites</h1>

<?php $this->widget('bootstrap.widgets.TbListView',array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); ?>
