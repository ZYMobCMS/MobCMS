<?php
/* @var $this ApplicationOwnerController */
/* @var $model ApplicationOwner */

$this->breadcrumbs=array(
	'Application Owners'=>array('index'),
	$model->owner_id=>array('view','id'=>$model->owner_id),
	'Update',
);

$this->menu=array(
	array('label'=>'List ApplicationOwner', 'url'=>array('index')),
	array('label'=>'Create ApplicationOwner', 'url'=>array('create')),
	array('label'=>'View ApplicationOwner', 'url'=>array('view', 'id'=>$model->owner_id)),
	array('label'=>'Manage ApplicationOwner', 'url'=>array('admin')),
);
?>

<h1>Update ApplicationOwner <?php echo $model->owner_id; ?></h1>

<?php echo $this->renderPartial('_form', array('model'=>$model)); ?>