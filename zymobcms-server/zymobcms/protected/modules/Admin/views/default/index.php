<?php
/* @var $this DefaultController */

$this->breadcrumbs=array(
	$this->module->id,
);
?>

<?php  $this->widget('bootstrap.widgets.TbNavbar',array(
    'items'=>array(
        array(
            'class'=>'bootstrap.widgets.TbMenu',
            'items'=>array(
                array('label'=>'文章', 'url'=>array('Admin/article/index')),
		array('label'=>'评论', 'url'=>array('Admin/comment/index')),
		array('label'=>'图片', 'url'=>array('Admin/picture/index')),
                array('label'=>'用户', 'url'=>array('Admin/user/index')),
                array('label'=>'产品', 'url'=>array('Admin/product/index')),
                array('label'=>'分类', 'url'=>array('Admin/rights/index')),
                array('label'=>'栏目', 'url'=>array('Admin/tabType/index')),
                array('label'=>'关于','url'=>array('Admin/aboutUs/index')),
                array('label'=>'Login', 'url'=>array('/site/login'), 'visible'=>Yii::app()->user->isGuest),
                array('label'=>'Logout ('.Yii::app()->user->name.')', 'url'=>array('/site/logout'), 'visible'=>!Yii::app()->user->isGuest)
            ),
        ),
    ),
)); ?>