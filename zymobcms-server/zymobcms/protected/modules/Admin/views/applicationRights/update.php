<?php
/* @var $this ApplicationRightsController */
/* @var $model ApplicationRights */

$this->breadcrumbs=array(
	'Application Rights'=>array('index'),
	$model->right_id=>array('view','id'=>$model->right_id),
	'Update',
);

$this->menu=array(
	array('label'=>'List ApplicationRights', 'url'=>array('index')),
	array('label'=>'Create ApplicationRights', 'url'=>array('create')),
	array('label'=>'View ApplicationRights', 'url'=>array('view', 'id'=>$model->right_id)),
	array('label'=>'Manage ApplicationRights', 'url'=>array('admin')),
);
?>

<h1>Update ApplicationRights <?php echo $model->right_id; ?></h1>

<?php echo $this->renderPartial('_form', array('model'=>$model)); ?>