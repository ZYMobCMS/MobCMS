<?php
$this->breadcrumbs=array(
	'Picture Comment Supports',
);

$this->menu=array(
	array('label'=>'Create PictureCommentSupport','url'=>array('create')),
	array('label'=>'Manage PictureCommentSupport','url'=>array('admin')),
);
?>

<h1>Picture Comment Supports</h1>

<?php $this->widget('bootstrap.widgets.TbListView',array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); ?>
