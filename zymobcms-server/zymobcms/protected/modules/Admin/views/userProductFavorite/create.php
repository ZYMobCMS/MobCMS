<?php
$this->breadcrumbs=array(
	'User Product Favorites'=>array('index'),
	'Create',
);

$this->menu=array(
	array('label'=>'List UserProductFavorite','url'=>array('index')),
	array('label'=>'Manage UserProductFavorite','url'=>array('admin')),
);
?>

<h1>Create UserProductFavorite</h1>

<?php echo $this->renderPartial('_form', array('model'=>$model)); ?>