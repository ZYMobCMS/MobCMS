<?php
$this->breadcrumbs=array(
	'Product Tab Types',
);

$this->menu=array(
	array('label'=>'Create ProductTabType','url'=>array('create')),
	array('label'=>'Manage ProductTabType','url'=>array('admin')),
);
?>

<h1>Product Tab Types</h1>

<?php $this->widget('bootstrap.widgets.TbListView',array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); ?>
