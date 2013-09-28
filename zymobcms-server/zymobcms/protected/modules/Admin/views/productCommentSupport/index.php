<?php
$this->breadcrumbs=array(
	'Product Comment Supports',
);

$this->menu=array(
	array('label'=>'Create ProductCommentSupport','url'=>array('create')),
	array('label'=>'Manage ProductCommentSupport','url'=>array('admin')),
);
?>

<h1>Product Comment Supports</h1>

<?php $this->widget('bootstrap.widgets.TbListView',array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); ?>
