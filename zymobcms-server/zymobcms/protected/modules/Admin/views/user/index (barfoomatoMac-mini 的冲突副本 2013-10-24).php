<?php
$this->breadcrumbs=array(
	'用户管理',
);

$this->menu=array(
	array('label'=>'添加用户','url'=>array('create')),
	array('label'=>'管理用户','url'=>array('admin')),
);
?>

<h1>用户管理</h1>

<?php $this->widget('bootstrap.widgets.TbGridView',array(
	'dataProvider'=>$dataProvider,
//	'itemView'=>'_view',
        'columns'=>array(
        array('name'=>'id', 'header'=>'编号'),
        array('name'=>'nick_name', 'header'=>'昵称'),
        array('name'=>'rigist_time', 'header'=>'注册时间'), 
        array('name'=>'points', 'header'=>'积分'),
        array('name'=>'user_type', 'header'=>'用户级别'),
        array(
            'class'=>'bootstrap.widgets.TbButtonColumn',
            'htmlOptions'=>array('style'=>'width: 50px'),
        ),
        ),
        'type'=>array('striped','bordered'),
)); ?>
