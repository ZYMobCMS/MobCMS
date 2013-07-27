<?php
/* @var $this CategoryRightsController */
/* @var $model CategoryRights */

$this->breadcrumbs=array(
	'Category Rights'=>array('index'),
	$model->id=>array('view','id'=>$model->id),
	'Update',
);

$this->menu=array(
	array('label'=>'List CategoryRights', 'url'=>array('index')),
	array('label'=>'Create CategoryRights', 'url'=>array('create')),
	array('label'=>'View CategoryRights', 'url'=>array('view', 'id'=>$model->id)),
	array('label'=>'Manage CategoryRights', 'url'=>array('admin')),
);
?>

<h1>Update CategoryRights <?php echo $model->id; ?></h1>

<?php echo $this->renderPartial('_form', array('model'=>$model)); ?>