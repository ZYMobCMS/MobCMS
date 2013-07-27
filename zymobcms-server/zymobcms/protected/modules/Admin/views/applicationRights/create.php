<?php
/* @var $this ApplicationRightsController */
/* @var $model ApplicationRights */

$this->breadcrumbs=array(
	'Application Rights'=>array('index'),
	'Create',
);

$this->menu=array(
	array('label'=>'List ApplicationRights', 'url'=>array('index')),
	array('label'=>'Manage ApplicationRights', 'url'=>array('admin')),
);
?>

<h1>Create ApplicationRights</h1>

<?php echo $this->renderPartial('_form', array('model'=>$model)); ?>