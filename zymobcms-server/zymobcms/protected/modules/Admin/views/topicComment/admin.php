<?php
/* @var $this TopicCommentController */
/* @var $model TopicComment */

$this->breadcrumbs=array(
	'Topic Comments'=>array('index'),
	'Manage',
);

$this->menu=array(
	array('label'=>'List TopicComment', 'url'=>array('index')),
	array('label'=>'Create TopicComment', 'url'=>array('create')),
);

Yii::app()->clientScript->registerScript('search', "
$('.search-button').click(function(){
	$('.search-form').toggle();
	return false;
});
$('.search-form form').submit(function(){
	$('#topic-comment-grid').yiiGridView('update', {
		data: $(this).serialize()
	});
	return false;
});
");
?>

<h1>Manage Topic Comments</h1>

<p>
You may optionally enter a comparison operator (<b>&lt;</b>, <b>&lt;=</b>, <b>&gt;</b>, <b>&gt;=</b>, <b>&lt;&gt;</b>
or <b>=</b>) at the beginning of each of your search values to specify how the comparison should be done.
</p>

<?php echo CHtml::link('Advanced Search','#',array('class'=>'search-button')); ?>
<div class="search-form" style="display:none">
<?php $this->renderPartial('_search',array(
	'model'=>$model,
)); ?>
</div><!-- search-form -->

<?php $this->widget('zii.widgets.grid.CGridView', array(
	'id'=>'topic-comment-grid',
	'dataProvider'=>$model->search(),
	'filter'=>$model,
	'columns'=>array(
		'id',
		'topic_id',
		'create_time',
		'update_time',
		'user_id',
		'content',
		/*
		'status',
		*/
		array(
			'class'=>'CButtonColumn',
		),
	),
)); ?>
