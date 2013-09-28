<?php
$this->breadcrumbs=array(
	'User Actives'=>array('index'),
	'Manage',
);

$this->menu=array(
	array('label'=>'List UserActive','url'=>array('index')),
	array('label'=>'Create UserActive','url'=>array('create')),
);

Yii::app()->clientScript->registerScript('search', "
$('.search-button').click(function(){
	$('.search-form').toggle();
	return false;
});
$('.search-form form').submit(function(){
	$.fn.yiiGridView.update('user-active-grid', {
		data: $(this).serialize()
	});
	return false;
});
");
?>

<h1>Manage User Actives</h1>

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
	'id'=>'user-active-grid',
	'dataProvider'=>$model->search(),
	'filter'=>$model,
	'columns'=>array(
		'id',
		'relation_id',
		'relation_table',
		'content',
		'create_time',
		'status',
		/*
		'create_user',
		'active_type_id',
		'relation_images',
		'refer_user',
		'create_login_name',
		'create_nick_name',
		'relation_title',
		'user_active_open',

		*/
		array(
			'class'=>'bootstrap.widgets.TbButtonColumn',
		),
	),
)); ?>
