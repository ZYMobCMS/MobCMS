<?php
$this->breadcrumbs=array(
	'User Replies'=>array('index'),
	$model->id=>array('view','id'=>$model->id),
	'Update',
);

$this->menu=array(
	array('label'=>'List UserReply','url'=>array('index')),
	array('label'=>'Create UserReply','url'=>array('create')),
	array('label'=>'View UserReply','url'=>array('view','id'=>$model->id)),
	array('label'=>'Manage UserReply','url'=>array('admin')),
);
?>

<h1>Update UserReply <?php echo $model->id; ?></h1>

<?php echo $this->renderPartial('_form',array('model'=>$model)); ?>