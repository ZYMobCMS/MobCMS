<?php
/* @var $this PictureTypeController */
/* @var $dataProvider CActiveDataProvider */

$this->breadcrumbs=array(
	'Picture Types',
);

$this->menu=array(
	array('label'=>'Create PictureType', 'url'=>array('create')),
	array('label'=>'Manage PictureType', 'url'=>array('admin')),
);
?>

<h1>Picture Types</h1>

<?php $this->widget('zii.widgets.CListView', array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); ?>
