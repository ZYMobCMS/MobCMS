<?php
$this->breadcrumbs=array(
	'Product Comment Supports'=>array('index'),
	'Create',
);

$this->menu=array(
	array('label'=>'List ProductCommentSupport','url'=>array('index')),
	array('label'=>'Manage ProductCommentSupport','url'=>array('admin')),
);
?>

<h1>Create ProductCommentSupport</h1>

<?php echo $this->renderPartial('_form', array('model'=>$model)); ?>