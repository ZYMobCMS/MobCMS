<?php
/* @var $this ApplicationRightsController */
/* @var $dataProvider CActiveDataProvider */

$this->breadcrumbs=array(
	'Application Rights',
);

$this->menu=array(
	array('label'=>'Create ApplicationRights', 'url'=>array('create')),
	array('label'=>'Manage ApplicationRights', 'url'=>array('admin')),
);
?>

<h1>Application Rights</h1>

<?php $this->widget('zii.widgets.CListView', array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); ?>
