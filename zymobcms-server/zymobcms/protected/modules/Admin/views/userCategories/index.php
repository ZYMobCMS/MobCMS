<?php
/* @var $this UserCategoriesController */
/* @var $dataProvider CActiveDataProvider */

$this->breadcrumbs=array(
	'User Categories',
);

$this->menu=array(
	array('label'=>'Create UserCategories', 'url'=>array('create')),
	array('label'=>'Manage UserCategories', 'url'=>array('admin')),
);
?>

<h1>User Categories</h1>

<?php $this->widget('zii.widgets.CListView', array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); ?>
