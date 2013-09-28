<?php
$this->breadcrumbs=array(
	'Product Comment Supports'=>array('index'),
	$model->id=>array('view','id'=>$model->id),
	'Update',
);

$this->menu=array(
	array('label'=>'List ProductCommentSupport','url'=>array('index')),
	array('label'=>'Create ProductCommentSupport','url'=>array('create')),
	array('label'=>'View ProductCommentSupport','url'=>array('view','id'=>$model->id)),
	array('label'=>'Manage ProductCommentSupport','url'=>array('admin')),
);
?>

<h1>Update ProductCommentSupport <?php echo $model->id; ?></h1>

<?php echo $this->renderPartial('_form',array('model'=>$model)); ?>