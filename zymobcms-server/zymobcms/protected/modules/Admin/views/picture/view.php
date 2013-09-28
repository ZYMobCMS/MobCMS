<?php
$this->breadcrumbs=array(
	'Pictures'=>array('index'),
	$model->title,
);

$this->menu=array(
	array('label'=>'List Picture','url'=>array('index')),
	array('label'=>'Create Picture','url'=>array('create')),
	array('label'=>'Update Picture','url'=>array('update','id'=>$model->id)),
	array('label'=>'Delete Picture','url'=>'#','linkOptions'=>array('submit'=>array('delete','id'=>$model->id),'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>'Manage Picture','url'=>array('admin')),
);
?>

<h1>View Picture #<?php echo $model->id; ?></h1>

<?php $this->widget('bootstrap.widgets.TbDetailView',array(
	'data'=>$model,
	'attributes'=>array(
		'id',
		'title',
		'summary',
		'images',
		'create_time',
		'create_user',
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
		'cotact_mobile',
		'product_combine',
		'location',
		'has_now',
		'product_sale_face',
		'product_respority_code',
		'has_sale_count',
	),
)); ?>
