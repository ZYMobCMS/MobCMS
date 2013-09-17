<?php
/* @var $this ArticleController */
/* @var $dataProvider CActiveDataProvider */

$this->breadcrumbs=array(
	'Articles',
);

$this->menu=array(
	array('label'=>'Create Article', 'url'=>array('create')),
	array('label'=>'Manage Article', 'url'=>array('admin')),
);
?>

<h1>文章列表</h1>

<?php $this->widget('bootstrap.widgets.TbGridView', array(
    'type'=>'striped bordered condensed',
    'dataProvider'=>$dataProvider,
    'template'=>"{items}",
    'columns'=>array(
        array('name'=>'id', 'header'=>'id'),
        array('name'=>'title', 'header'=>'标题'),
        array('name'=>'source', 'header'=>'来源'),
        array('name'=>'publish_time', 'header'=>'发布时间'),
        array(
            'class'=>'bootstrap.widgets.TbButtonColumn',
            'htmlOptions'=>array('style'=>'width: 50px'),
        ),
    ),
)); ?>



