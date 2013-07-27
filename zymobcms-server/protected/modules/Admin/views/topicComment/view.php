<?php
/* @var $this TopicCommentController */
/* @var $model TopicComment */

$this->breadcrumbs=array(
	'Topic Comments'=>array('index'),
	$model->id,
);

$this->menu=array(
	array('label'=>'List TopicComment', 'url'=>array('index')),
	array('label'=>'Create TopicComment', 'url'=>array('create')),
	array('label'=>'Update TopicComment', 'url'=>array('update', 'id'=>$model->id)),
	array('label'=>'Delete TopicComment', 'url'=>'#', 'linkOptions'=>array('submit'=>array('delete','id'=>$model->id),'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>'Manage TopicComment', 'url'=>array('admin')),
);
?>

<h1>View TopicComment #<?php echo $model->id; ?></h1>

<?php $this->widget('zii.widgets.CDetailView', array(
	'data'=>$model,
	'attributes'=>array(
		'id',
		'topic_id',
		'create_time',
		'update_time',
		'user_id',
		'content',
		'status',
	),
)); ?>
