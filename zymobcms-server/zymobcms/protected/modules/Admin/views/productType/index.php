<?php
$this->breadcrumbs=array(
	'Product Types',
);

$this->menu=array(
	array('label'=>'Create ProductType','url'=>array('create')),
	array('label'=>'Manage ProductType','url'=>array('admin')),
);
?>

<h1>Product Types</h1>

<?php $this->widget('bootstrap.widgets.TbListView',array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); ?>
