<?php
$this->breadcrumbs=array(
	'Products'=>array('index'),
	$model->title,
);

$this->menu=array(
	array('label'=>'List Product','url'=>array('index')),
	array('label'=>'Create Product','url'=>array('create')),
	array('label'=>'Update Product','url'=>array('update','id'=>$model->id)),
	array('label'=>'Delete Product','url'=>'#','linkOptions'=>array('submit'=>array('delete','id'=>$model->id),'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>'Manage Product','url'=>array('admin')),
);
?>

<h1>View Product #<?php echo $model->id; ?></h1>

<?php $this->widget('bootstrap.widgets.TbDetailView',array(
	'data'=>$model,
	'attributes'=>array(
		'id',
		'title',
		'summary',
		'content',
		'price',
		'images',
		'create_time',
		'update_time',
		'status',
		'create_user',
		'has_now',
		'support_count',
		'links',
		'contact_email',
		'contact_name',
		'contact_phone',
		'contact_qq',
		'type_id',
		'comment_count',
		'favorite_count',
		'source',
		'has_selled_count',
		'admin_price',
		'product_code',
		'product_weight',
		'product_respority_code',
		'product_sale_face',
		'contact_wangwang',
		'market_price',
		'we_price',
		'industry_id',
		'contact_mobile',
		'contact_url',
		'main_category_id',
		'sub_tab_type_id',
	),
)); ?>
