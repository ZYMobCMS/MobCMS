<?php
/* @var $this CategoryRightsController */
/* @var $dataProvider CActiveDataProvider */

$this->breadcrumbs=array(
	'Category Rights',
);

$this->menu=array(
	array('label'=>'Create CategoryRights', 'url'=>array('create')),
	array('label'=>'Manage CategoryRights', 'url'=>array('admin')),
);
?>

<h1>Category Rights</h1>

<?php $this->widget('zii.widgets.CListView', array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); ?>
