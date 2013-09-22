<?php
$this->breadcrumbs=array(
	'Picture Tab Types'=>array('index'),
	'Create',
);

$this->menu=array(
	array('label'=>'List PictureTabType','url'=>array('index')),
	array('label'=>'Manage PictureTabType','url'=>array('admin')),
);
?>

<h1>Create PictureTabType</h1>

<?php echo $this->renderPartial('_form', array('model'=>$model)); ?>