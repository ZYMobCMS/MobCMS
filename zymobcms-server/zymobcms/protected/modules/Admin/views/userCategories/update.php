<?php
/* @var $this UserCategoriesController */
/* @var $model UserCategories */

$this->breadcrumbs=array(
	'User Categories'=>array('index'),
	$model->id=>array('view','id'=>$model->id),
	'Update',
);

$this->menu=array(
	array('label'=>'List UserCategories', 'url'=>array('index')),
	array('label'=>'Create UserCategories', 'url'=>array('create')),
	array('label'=>'View UserCategories', 'url'=>array('view', 'id'=>$model->id)),
	array('label'=>'Manage UserCategories', 'url'=>array('admin')),
);
?>

<h1>Update UserCategories <?php echo $model->id; ?></h1>

<?php echo $this->renderPartial('_form', array('model'=>$model)); ?>