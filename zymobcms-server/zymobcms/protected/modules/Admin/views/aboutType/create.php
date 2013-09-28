<?php
$this->breadcrumbs=array(
	'About Types'=>array('index'),
	'Create',
);

$this->menu=array(
	array('label'=>'关于列表','url'=>array('index')),
	array('label'=>'管理关于列表','url'=>array('admin')),
);
?>

<h1>Create AboutType</h1>

<?php echo $this->renderPartial('_form', array('model'=>$model)); ?>