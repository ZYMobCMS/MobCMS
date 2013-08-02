<?php
/* @var $this TopicCommentController */
/* @var $dataProvider CActiveDataProvider */

$this->breadcrumbs=array(
	'Topic Comments',
);

$this->menu=array(
	array('label'=>'Create TopicComment', 'url'=>array('create')),
	array('label'=>'Manage TopicComment', 'url'=>array('admin')),
);
?>

<h1>Topic Comments</h1>

<?php $this->widget('zii.widgets.CListView', array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); ?>
