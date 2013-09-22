<?php
$this->breadcrumbs=array(
	'Picture Comments'=>array('index'),
	'Create',
);

$this->menu=array(
	array('label'=>'List PictureComment','url'=>array('index')),
	array('label'=>'Manage PictureComment','url'=>array('admin')),
);
?>

<h1>Create PictureComment</h1>

<?php echo $this->renderPartial('_form', array('model'=>$model)); ?>