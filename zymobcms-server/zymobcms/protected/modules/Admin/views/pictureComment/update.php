<?php
$this->breadcrumbs=array(
	'Picture Comments'=>array('index'),
	$model->title=>array('view','id'=>$model->comment_id),
	'Update',
);

$this->menu=array(
	array('label'=>'List PictureComment','url'=>array('index')),
	array('label'=>'Create PictureComment','url'=>array('create')),
	array('label'=>'View PictureComment','url'=>array('view','id'=>$model->comment_id)),
	array('label'=>'Manage PictureComment','url'=>array('admin')),
);
?>

<h1>Update PictureComment <?php echo $model->comment_id; ?></h1>

<?php echo $this->renderPartial('_form',array('model'=>$model)); ?>