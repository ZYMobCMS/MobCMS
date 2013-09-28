<?php
$this->breadcrumbs=array(
	'Pictures',
);

$this->menu=array(
	array('label'=>'Create Picture','url'=>array('create')),
	array('label'=>'Manage Picture','url'=>array('admin')),
);
?>

<h1>Pictures</h1>

<?php $this->widget('bootstrap.widgets.TbListView',array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); ?>
