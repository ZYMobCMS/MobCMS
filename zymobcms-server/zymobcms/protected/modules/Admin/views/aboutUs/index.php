<?php
$this->breadcrumbs=array(
	'About Uses',
);

$this->menu=array(
	array('label'=>'Create AboutUs','url'=>array('create')),
	array('label'=>'Manage AboutUs','url'=>array('admin')),
);
?>

<h1>About Uses</h1>

<?php $this->widget('bootstrap.widgets.TbListView',array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); ?>
