<?php
$this->breadcrumbs=array(
	'文章管理',
);

$this->menu=array(
	array('label'=>'创建文章','url'=>array('create')),
	array('label'=>'管理文章','url'=>array('admin')),
);
?>

<h1>文章管理</h1>

<?php $this->widget('bootstrap.widgets.TbGridView',array(
	'dataProvider'=>$dataProvider,
//	'itemView'=>'_view',
        'columns'=>array(
        array('name'=>'id', 'header'=>'编号'),
        array('name'=>'title', 'header'=>'标题'),
        array('name'=>'source', 'header'=>'来源'), 
        array('name'=>'publish_time', 'header'=>'发布时间'),
        array('name'=>'links', 'header'=>'原文链接'),
        array(
            'class'=>'bootstrap.widgets.TbButtonColumn',
            'htmlOptions'=>array('style'=>'width: 50px'),
        ),
        ),
        'type'=>array('striped','bordered'),
)); ?>
