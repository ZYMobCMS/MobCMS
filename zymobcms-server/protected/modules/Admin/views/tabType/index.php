<?php
/* @var $this TabTypeController */
/* @var $dataProvider CActiveDataProvider */

$this->breadcrumbs=array(
	'Tab Types',
);

$this->menu=array(
	array('label'=>'Create TabType', 'url'=>array('create')),
	array('label'=>'Manage TabType', 'url'=>array('admin')),
);
?>

<h1>Tab Types</h1>

<?php $this->widget('zii.widgets.CListView', array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); ?>
