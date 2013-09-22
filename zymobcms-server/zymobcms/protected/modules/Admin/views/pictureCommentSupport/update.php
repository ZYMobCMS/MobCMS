<?php
$this->breadcrumbs=array(
	'Picture Comment Supports'=>array('index'),
	$model->id=>array('view','id'=>$model->id),
	'Update',
);

$this->menu=array(
	array('label'=>'List PictureCommentSupport','url'=>array('index')),
	array('label'=>'Create PictureCommentSupport','url'=>array('create')),
	array('label'=>'View PictureCommentSupport','url'=>array('view','id'=>$model->id)),
	array('label'=>'Manage PictureCommentSupport','url'=>array('admin')),
);
?>

<h1>Update PictureCommentSupport <?php echo $model->id; ?></h1>

<?php echo $this->renderPartial('_form',array('model'=>$model)); ?>