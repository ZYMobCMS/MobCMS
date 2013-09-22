<?php
$this->breadcrumbs=array(
	'Active Types',
);

$this->menu=array(
	array('label'=>'Create ActiveType','url'=>array('create')),
	array('label'=>'Manage ActiveType','url'=>array('admin')),
);
?>

<h1>Active Types</h1>

<?php $this->widget('bootstrap.widgets.TbListView',array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); ?>
