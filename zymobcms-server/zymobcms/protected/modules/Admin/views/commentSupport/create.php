<?php
$this->breadcrumbs=array(
	'Comment Supports'=>array('index'),
	'Create',
);

$this->menu=array(
	array('label'=>'List CommentSupport','url'=>array('index')),
	array('label'=>'Manage CommentSupport','url'=>array('admin')),
);
?>

<h1>Create CommentSupport</h1>

<?php echo $this->renderPartial('_form', array('model'=>$model)); ?>