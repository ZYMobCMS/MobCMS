<?php
$this->breadcrumbs=array(
	'Device Types',
);

$this->menu=array(
	array('label'=>'Create DeviceType','url'=>array('create')),
	array('label'=>'Manage DeviceType','url'=>array('admin')),
);
?>

<h1>Device Types</h1>

<?php $this->widget('bootstrap.widgets.TbListView',array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); ?>
