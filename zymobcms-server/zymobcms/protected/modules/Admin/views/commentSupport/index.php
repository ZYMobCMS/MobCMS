<?php
$this->breadcrumbs=array(
	'Comment Supports',
);

$this->menu=array(
	array('label'=>'Create CommentSupport','url'=>array('create')),
	array('label'=>'Manage CommentSupport','url'=>array('admin')),
);
?>

<h1>Comment Supports</h1>

<?php $this->widget('bootstrap.widgets.TbListView',array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); ?>
