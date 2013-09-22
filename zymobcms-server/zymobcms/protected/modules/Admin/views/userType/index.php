<?php
$this->breadcrumbs=array(
	'User Types',
);

$this->menu=array(
	array('label'=>'Create UserType','url'=>array('create')),
	array('label'=>'Manage UserType','url'=>array('admin')),
);
?>

<h1>User Types</h1>

<?php $this->widget('bootstrap.widgets.TbListView',array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); ?>
