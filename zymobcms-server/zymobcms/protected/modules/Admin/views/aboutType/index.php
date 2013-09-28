<?php
$this->breadcrumbs=array(
	'关于类型',
);

$this->menu=array(
	array('label'=>'创建新类型','url'=>array('create')),
	array('label'=>'管理类型','url'=>array('admin')),
);
?>

<h1>关于类型</h1>

<?php $this->widget('bootstrap.widgets.TbGridView',array(
	'dataProvider'=>$dataProvider,
//	'itemView'=>'_view',
        'columns'=>array(
        array('name'=>'id', 'header'=>'编号'),
        array('name'=>'type_name', 'header'=>'名称'),
        array(
            'class'=>'bootstrap.widgets.TbButtonColumn',
            'htmlOptions'=>array('style'=>'width: 50px'),
        ),
        ),
        'type'=>array('striped','bordered'),
)); ?>

