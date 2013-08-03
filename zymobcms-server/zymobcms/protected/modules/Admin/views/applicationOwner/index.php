<?php
/* @var $this ApplicationOwnerController */
/* @var $dataProvider CActiveDataProvider */

$this->breadcrumbs=array(
	'Application Owners',
);

$this->menu=array(
	array('label'=>'Create ApplicationOwner', 'url'=>array('create')),
	array('label'=>'Manage ApplicationOwner', 'url'=>array('admin')),
);
?>

<h1>Application Owners</h1>

<?php $this->widget('zii.widgets.CListView', array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); ?>
