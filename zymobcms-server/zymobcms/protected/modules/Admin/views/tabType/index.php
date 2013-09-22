<?php
$this->breadcrumbs=array(
	'Tab Types',
);

$this->menu=array(
	array('label'=>'Create TabType','url'=>array('create')),
	array('label'=>'Manage TabType','url'=>array('admin')),
);
?>

<h1>Tab Types</h1>

<?php $this->widget('bootstrap.widgets.TbListView',array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); ?>
