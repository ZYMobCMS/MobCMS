<?php
/* @var $this AboutUsController */
/* @var $model AboutUs */

$this->breadcrumbs=array(
	'About Uses'=>array('index'),
	$model->id,
);

$this->menu=array(
	array('label'=>'List AboutUs', 'url'=>array('index')),
	array('label'=>'Create AboutUs', 'url'=>array('create')),
	array('label'=>'Update AboutUs', 'url'=>array('update', 'id'=>$model->id)),
	array('label'=>'Delete AboutUs', 'url'=>'#', 'linkOptions'=>array('submit'=>array('delete','id'=>$model->id),'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>'Manage AboutUs', 'url'=>array('admin')),
);
?>

<h1>View AboutUs #<?php echo $model->id; ?></h1>

<?php $this->widget('zii.widgets.CDetailView', array(
	'data'=>$model,
	'attributes'=>array(
		'id',
		'content',
		'phone',
		'website',
		'email',
		'qq',
		'msn',
		'home_phone',
		'copy_right',
		'company_name',
		'blog_host',
		'contact_who',
		'status',
		'product_name',
		'logo_image',
		'update_time',
	),
)); ?>
