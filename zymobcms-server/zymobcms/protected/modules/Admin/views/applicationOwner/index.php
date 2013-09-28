<?php
$this->breadcrumbs=array(
	'Application Owners',
);

$this->menu=array(
	array('label'=>'Create ApplicationOwner','url'=>array('create')),
	array('label'=>'Manage ApplicationOwner','url'=>array('admin')),
);
?>

<h1>Application Owners</h1>

<?php $this->widget('bootstrap.widgets.TbListView',array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); ?>
