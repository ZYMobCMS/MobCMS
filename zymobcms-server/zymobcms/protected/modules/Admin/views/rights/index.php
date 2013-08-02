<?php
/* @var $this RightsController */
/* @var $dataProvider CActiveDataProvider */

$this->breadcrumbs=array(
	'Rights',
);

$this->menu=array(
	array('label'=>'Create Rights', 'url'=>array('create')),
	array('label'=>'Manage Rights', 'url'=>array('admin')),
);
?>

<h1>Rights</h1>

<?php $this->widget('zii.widgets.CListView', array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); ?>
