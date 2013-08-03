<?php
/* @var $this UserReplyController */
/* @var $model UserReply */

$this->breadcrumbs=array(
	'User Replies'=>array('index'),
	'Create',
);

$this->menu=array(
	array('label'=>'List UserReply', 'url'=>array('index')),
	array('label'=>'Manage UserReply', 'url'=>array('admin')),
);
?>

<h1>Create UserReply</h1>

<?php echo $this->renderPartial('_form', array('model'=>$model)); ?>