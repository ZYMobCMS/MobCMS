<?php
$this->breadcrumbs=array(
	'Active Types'=>array('index'),
	'Create',
);

$this->menu=array(
	array('label'=>'List ActiveType','url'=>array('index')),
	array('label'=>'Manage ActiveType','url'=>array('admin')),
);
?>

<h1>Create ActiveType</h1>

<?php echo $this->renderPartial('_form', array('model'=>$model)); ?>