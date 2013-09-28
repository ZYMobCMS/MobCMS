<?php
$this->breadcrumbs=array(
	'User Picture Favorites'=>array('index'),
	'Create',
);

$this->menu=array(
	array('label'=>'List UserPictureFavorite','url'=>array('index')),
	array('label'=>'Manage UserPictureFavorite','url'=>array('admin')),
);
?>

<h1>Create UserPictureFavorite</h1>

<?php echo $this->renderPartial('_form', array('model'=>$model)); ?>