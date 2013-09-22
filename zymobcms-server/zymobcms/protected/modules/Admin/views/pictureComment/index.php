<?php
$this->breadcrumbs=array(
	'Picture Comments',
);

$this->menu=array(
	array('label'=>'Create PictureComment','url'=>array('create')),
	array('label'=>'Manage PictureComment','url'=>array('admin')),
);
?>

<h1>Picture Comments</h1>

<?php $this->widget('bootstrap.widgets.TbListView',array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); ?>
