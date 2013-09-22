<?php
$this->breadcrumbs=array(
	'Product Comments'=>array('index'),
	'Manage',
);

$this->menu=array(
	array('label'=>'List ProductComment','url'=>array('index')),
	array('label'=>'Create ProductComment','url'=>array('create')),
);

Yii::app()->clientScript->registerScript('search', "
$('.search-button').click(function(){
	$('.search-form').toggle();
	return false;
});
$('.search-form form').submit(function(){
	$.fn.yiiGridView.update('product-comment-grid', {
		data: $(this).serialize()
	});
	return false;
});
");
?>

<h1>Manage Product Comments</h1>

<p>
You may optionally enter a comparison operator (<b>&lt;</b>, <b>&lt;=</b>, <b>&gt;</b>, <b>&gt;=</b>, <b>&lt;&gt;</b>
or <b>=</b>) at the beginning of each of your search values to specify how the comparison should be done.
</p>

<?php echo CHtml::link('Advanced Search','#',array('class'=>'search-button btn')); ?>
<div class="search-form" style="display:none">
<?php $this->renderPartial('_search',array(
	'model'=>$model,
)); ?>
</div><!-- search-form -->

<?php $this->widget('bootstrap.widgets.TbGridView',array(
	'id'=>'product-comment-grid',
	'dataProvider'=>$model->search(),
	'filter'=>$model,
	'columns'=>array(
		'comment_id',
		'product_id',
		'content',
		'create_time',
		'create_user',
		'to_users',
		/*
		'status',
		'support_count',
		'unsupport_count',
		'title',
		*/
		array(
			'class'=>'bootstrap.widgets.TbButtonColumn',
		),
	),
)); ?>
