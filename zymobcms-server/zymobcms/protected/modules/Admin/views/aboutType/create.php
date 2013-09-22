<?php
$this->breadcrumbs=array(
	'About Types'=>array('index'),
	'Create',
);

$this->menu=array(
	array('label'=>'List AboutType','url'=>array('index')),
	array('label'=>'Manage AboutType','url'=>array('admin')),
);
?>

<h1>Create AboutType</h1>

<?php echo $this->renderPartial('_form', array('model'=>$model)); ?>