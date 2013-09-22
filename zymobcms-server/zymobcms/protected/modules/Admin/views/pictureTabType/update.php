<?php
$this->breadcrumbs=array(
	'Picture Tab Types'=>array('index'),
	$model->id=>array('view','id'=>$model->id),
	'Update',
);

$this->menu=array(
	array('label'=>'List PictureTabType','url'=>array('index')),
	array('label'=>'Create PictureTabType','url'=>array('create')),
	array('label'=>'View PictureTabType','url'=>array('view','id'=>$model->id)),
	array('label'=>'Manage PictureTabType','url'=>array('admin')),
);
?>

<h1>Update PictureTabType <?php echo $model->id; ?></h1>

<?php echo $this->renderPartial('_form',array('model'=>$model)); ?>