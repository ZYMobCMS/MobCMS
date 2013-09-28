<?php
$this->breadcrumbs=array(
	'Comment Supports'=>array('index'),
	$model->id=>array('view','id'=>$model->id),
	'Update',
);

$this->menu=array(
	array('label'=>'List CommentSupport','url'=>array('index')),
	array('label'=>'Create CommentSupport','url'=>array('create')),
	array('label'=>'View CommentSupport','url'=>array('view','id'=>$model->id)),
	array('label'=>'Manage CommentSupport','url'=>array('admin')),
);
?>

<h1>Update CommentSupport <?php echo $model->id; ?></h1>

<?php echo $this->renderPartial('_form',array('model'=>$model)); ?>