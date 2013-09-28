<?php
$this->breadcrumbs=array(
	'User Picture Favorites',
);

$this->menu=array(
	array('label'=>'Create UserPictureFavorite','url'=>array('create')),
	array('label'=>'Manage UserPictureFavorite','url'=>array('admin')),
);
?>

<h1>User Picture Favorites</h1>

<?php $this->widget('bootstrap.widgets.TbListView',array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); ?>
