<?php
$this->breadcrumbs=array(
	'User Actives'=>array('index'),
	'Create',
);

$this->menu=array(
	array('label'=>'List UserActive','url'=>array('index')),
	array('label'=>'Manage UserActive','url'=>array('admin')),
);
?>

<h1>Create UserActive</h1>

<?php echo $this->renderPartial('_form', array('model'=>$model)); ?>