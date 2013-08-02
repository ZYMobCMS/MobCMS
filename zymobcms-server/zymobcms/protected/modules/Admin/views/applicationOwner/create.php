<?php
/* @var $this ApplicationOwnerController */
/* @var $model ApplicationOwner */

$this->breadcrumbs=array(
	'Application Owners'=>array('index'),
	'Create',
);

$this->menu=array(
	array('label'=>'List ApplicationOwner', 'url'=>array('index')),
	array('label'=>'Manage ApplicationOwner', 'url'=>array('admin')),
);
?>

<h1>Create ApplicationOwner</h1>

<?php echo $this->renderPartial('_form', array('model'=>$model)); ?>