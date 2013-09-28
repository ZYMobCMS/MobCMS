<?php
$this->breadcrumbs=array(
	'Picture Tab Types',
);

$this->menu=array(
	array('label'=>'Create PictureTabType','url'=>array('create')),
	array('label'=>'Manage PictureTabType','url'=>array('admin')),
);
?>

<h1>Picture Tab Types</h1>

<?php $this->widget('bootstrap.widgets.TbListView',array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); ?>
