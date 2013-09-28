<?php
$this->breadcrumbs=array(
	'Pictures'=>array('index'),
	'Manage',
);

$this->menu=array(
	array('label'=>'List Picture','url'=>array('index')),
	array('label'=>'Create Picture','url'=>array('create')),
);

Yii::app()->clientScript->registerScript('search', "
$('.search-button').click(function(){
	$('.search-form').toggle();
	return false;
});
$('.search-form form').submit(function(){
	$.fn.yiiGridView.update('picture-grid', {
		data: $(this).serialize()
	});
	return false;
});
");
?>

<h1>Manage Pictures</h1>

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
	'id'=>'picture-grid',
	'dataProvider'=>$model->search(),
	'filter'=>$model,
	'columns'=>array(
		'id',
		'title',
		'summary',
		'images',
		'create_time',
		'create_user',
		/*
		'status',
		'links',
		'comment_count',
		'favorite_count',
		'source',
		'industry_id',
		'main_category_id',
		'sub_tab_type_id',
		'market_price',
		'we_price',
		'low_price',
		'product_code',
		'product_face_code',
		'contact_mobile',
		'product_combine',
		'location',
		'has_now',
		'product_sale_face',
		'product_respority_code',
		'has_sale_count',
		*/
		array(
			'class'=>'bootstrap.widgets.TbButtonColumn',
		),
	),
)); ?>
