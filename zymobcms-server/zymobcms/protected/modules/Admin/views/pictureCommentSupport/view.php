<?php
$this->breadcrumbs=array(
	'Picture Comment Supports'=>array('index'),
	$model->id,
);

$this->menu=array(
	array('label'=>'List PictureCommentSupport','url'=>array('index')),
	array('label'=>'Create PictureCommentSupport','url'=>array('create')),
	array('label'=>'Update PictureCommentSupport','url'=>array('update','id'=>$model->id)),
	array('label'=>'Delete PictureCommentSupport','url'=>'#','linkOptions'=>array('submit'=>array('delete','id'=>$model->id),'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>'Manage PictureCommentSupport','url'=>array('admin')),
);
?>

<h1>View PictureCommentSupport #<?php echo $model->id; ?></h1>

<?php $this->widget('bootstrap.widgets.TbDetailView',array(
	'data'=>$model,
	'attributes'=>array(
		'id',
		'comment_id',
		'user_id',
	),
)); ?>
