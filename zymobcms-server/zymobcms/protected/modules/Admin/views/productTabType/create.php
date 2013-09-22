<?php
$this->breadcrumbs=array(
	'Product Tab Types'=>array('index'),
	'Create',
);

$this->menu=array(
	array('label'=>'List ProductTabType','url'=>array('index')),
	array('label'=>'Manage ProductTabType','url'=>array('admin')),
);
?>

<h1>Create ProductTabType</h1>

<?php echo $this->renderPartial('_form', array('model'=>$model)); ?>