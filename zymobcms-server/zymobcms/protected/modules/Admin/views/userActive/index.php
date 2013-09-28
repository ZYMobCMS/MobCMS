<?php
$this->breadcrumbs=array(
	'User Actives',
);

$this->menu=array(
	array('label'=>'Create UserActive','url'=>array('create')),
	array('label'=>'Manage UserActive','url'=>array('admin')),
);
?>

<h1>User Actives</h1>

<?php $this->widget('bootstrap.widgets.TbListView',array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); ?>
