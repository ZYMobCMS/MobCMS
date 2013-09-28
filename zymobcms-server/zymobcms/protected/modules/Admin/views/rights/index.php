<?php
$this->breadcrumbs=array(
	'Rights',
);

$this->menu=array(
	array('label'=>'Create Rights','url'=>array('create')),
	array('label'=>'Manage Rights','url'=>array('admin')),
);
?>

<h1>Rights</h1>

<?php $this->widget('bootstrap.widgets.TbListView',array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); ?>
