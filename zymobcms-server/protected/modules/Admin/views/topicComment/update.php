<?php
/* @var $this TopicCommentController */
/* @var $model TopicComment */

$this->breadcrumbs=array(
	'Topic Comments'=>array('index'),
	$model->id=>array('view','id'=>$model->id),
	'Update',
);

$this->menu=array(
	array('label'=>'List TopicComment', 'url'=>array('index')),
	array('label'=>'Create TopicComment', 'url'=>array('create')),
	array('label'=>'View TopicComment', 'url'=>array('view', 'id'=>$model->id)),
	array('label'=>'Manage TopicComment', 'url'=>array('admin')),
);
?>

<h1>Update TopicComment <?php echo $model->id; ?></h1>

<?php echo $this->renderPartial('_form', array('model'=>$model)); ?>