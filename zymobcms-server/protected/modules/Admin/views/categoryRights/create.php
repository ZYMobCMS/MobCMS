<?php
/* @var $this CategoryRightsController */
/* @var $model CategoryRights */

$this->breadcrumbs=array(
	'Category Rights'=>array('index'),
	'Create',
);

$this->menu=array(
	array('label'=>'List CategoryRights', 'url'=>array('index')),
	array('label'=>'Manage CategoryRights', 'url'=>array('admin')),
);
?>

<h1>Create CategoryRights</h1>

<?php echo $this->renderPartial('_form', array('model'=>$model)); ?>