<?php
/* @var $this UserCategoriesController */
/* @var $model UserCategories */

$this->breadcrumbs=array(
	'User Categories'=>array('index'),
	$model->id,
);

$this->menu=array(
	array('label'=>'List UserCategories', 'url'=>array('index')),
	array('label'=>'Create UserCategories', 'url'=>array('create')),
	array('label'=>'Update UserCategories', 'url'=>array('update', 'id'=>$model->id)),
	array('label'=>'Delete UserCategories', 'url'=>'#', 'linkOptions'=>array('submit'=>array('delete','id'=>$model->id),'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>'Manage UserCategories', 'url'=>array('admin')),
);
?>

<h1>View UserCategories #<?php echo $model->id; ?></h1>

<?php $this->widget('zii.widgets.CDetailView', array(
	'data'=>$model,
	'attributes'=>array(
		'id',
		'category_id',
		'status',
		'add_time',
		'create_user',
	),
)); ?>
