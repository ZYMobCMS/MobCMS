<?php
$this->breadcrumbs=array(
	'User Product Favorites',
);

$this->menu=array(
	array('label'=>'Create UserProductFavorite','url'=>array('create')),
	array('label'=>'Manage UserProductFavorite','url'=>array('admin')),
);
?>

<h1>User Product Favorites</h1>

<?php $this->widget('bootstrap.widgets.TbListView',array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); ?>
