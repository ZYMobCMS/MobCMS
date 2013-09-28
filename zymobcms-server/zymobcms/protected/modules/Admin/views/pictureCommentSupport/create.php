<?php
$this->breadcrumbs=array(
	'Picture Comment Supports'=>array('index'),
	'Create',
);

$this->menu=array(
	array('label'=>'List PictureCommentSupport','url'=>array('index')),
	array('label'=>'Manage PictureCommentSupport','url'=>array('admin')),
);
?>

<h1>Create PictureCommentSupport</h1>

<?php echo $this->renderPartial('_form', array('model'=>$model)); ?>