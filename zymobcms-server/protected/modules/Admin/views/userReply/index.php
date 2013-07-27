<?php
/* @var $this UserReplyController */
/* @var $dataProvider CActiveDataProvider */

$this->breadcrumbs=array(
	'User Replies',
);

$this->menu=array(
	array('label'=>'Create UserReply', 'url'=>array('create')),
	array('label'=>'Manage UserReply', 'url'=>array('admin')),
);
?>

<h1>User Replies</h1>

<?php $this->widget('zii.widgets.CListView', array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); ?>
