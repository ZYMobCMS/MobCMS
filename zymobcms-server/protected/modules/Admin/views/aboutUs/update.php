<?php
/* @var $this AboutUsController */
/* @var $model AboutUs */

$this->breadcrumbs=array(
	'About Uses'=>array('index'),
	$model->id=>array('view','id'=>$model->id),
	'Update',
);

$this->menu=array(
	array('label'=>'List AboutUs', 'url'=>array('index')),
	array('label'=>'Create AboutUs', 'url'=>array('create')),
	array('label'=>'View AboutUs', 'url'=>array('view', 'id'=>$model->id)),
	array('label'=>'Manage AboutUs', 'url'=>array('admin')),
);
?>

<h1>Update AboutUs <?php echo $model->id; ?></h1>

<?php echo $this->renderPartial('_form', array('model'=>$model)); ?>