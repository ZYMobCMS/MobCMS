<?php
/* @var $this RightsController */
/* @var $dataProvider CActiveDataProvider */

$this->breadcrumbs=array(
	'功能模块',
);

?>

<?php $this->widget('bootstrap.widgets.TbButtonGroup', array(
    'buttons'=>array(
        array('label'=>'创建模块', 'url'=>'create'),
        array('label'=>'管理模块', 'url'=>'manager'),
    ),
)); ?>

<h1>模块</h1>


<?php $this->widget('zii.widgets.CListView', array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); ?>
