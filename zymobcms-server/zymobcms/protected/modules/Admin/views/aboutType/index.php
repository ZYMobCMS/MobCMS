<?php
$this->breadcrumbs=array(
	'About Types',
);

$this->menu=array(
	array('label'=>'Create AboutType','url'=>array('create')),
	array('label'=>'Manage AboutType','url'=>array('admin')),
);
?>

<h1>About Types</h1>

<?php $this->widget('bootstrap.widgets.TbListView',array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); ?>
