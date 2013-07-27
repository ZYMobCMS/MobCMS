<?php
/* @var $this TopicCommentController */
/* @var $model TopicComment */

$this->breadcrumbs=array(
	'Topic Comments'=>array('index'),
	'Create',
);

$this->menu=array(
	array('label'=>'List TopicComment', 'url'=>array('index')),
	array('label'=>'Manage TopicComment', 'url'=>array('admin')),
);
?>

<h1>Create TopicComment</h1>

<?php echo $this->renderPartial('_form', array('model'=>$model)); ?>