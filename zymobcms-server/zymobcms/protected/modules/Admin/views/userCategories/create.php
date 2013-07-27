<?php
/* @var $this UserCategoriesController */
/* @var $model UserCategories */

$this->breadcrumbs=array(
	'User Categories'=>array('index'),
	'Create',
);

$this->menu=array(
	array('label'=>'List UserCategories', 'url'=>array('index')),
	array('label'=>'Manage UserCategories', 'url'=>array('admin')),
);
?>

<h1>Create UserCategories</h1>

<?php echo $this->renderPartial('_form', array('model'=>$model)); ?>