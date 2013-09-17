<?php
/* @var $this UserController */
/* @var $dataProvider CActiveDataProvider */

$this->breadcrumbs=array(
	'Users',
);

?>

<h5>用户管理</h5>

<?php $this->widget('bootstrap.widgets.TbButtonGroup', array(
    'buttons'=>array(
        array('label'=>'创建用户', 'url'=>'create','type'=>'primary'),
        array('label'=>'管理用户', 'url'=>'admin','type'=>'success'),
    ),
)); ?>

<div class="btn-toolbar">
    <?php $this->widget('bootstrap.widgets.TbButtonGroup', array(
        'type'=>'primary', // '', 'primary', 'info', 'success', 'warning', 'danger' or 'inverse'
        'buttons'=>array(
            array('label'=>'Action', 'items'=>array(
                array('label'=>'Action', 'url'=>'#'),
                array('label'=>'Another action', 'url'=>'#'),
                array('label'=>'Something else', 'url'=>'#'),
                '---',
                array('label'=>'Separate link', 'url'=>'#'),
            )),
        ),
    )); ?>
    
    <?php $this->widget('bootstrap.widgets.TbButtonGroup', array(
        'type'=>'primary', // '', 'primary', 'info', 'success', 'warning', 'danger' or 'inverse'
        'buttons'=>array(
            array('label'=>'Action', 'url'=>'#'),
            array('items'=>array(
                array('label'=>'Action', 'url'=>'#'),
                array('label'=>'Another action', 'url'=>'#'),
                array('label'=>'Something else', 'url'=>'#'),
                '---',
                array('label'=>'Separate link', 'url'=>'#'),
            )),
        ),
    )); ?>
    
    <?php $this->widget('bootstrap.widgets.TbButton', array(
    'type'=>'primary',
    'label'=>'Block level button',
    'block'=>true,
    )); ?>
    
    <?php $this->widget('bootstrap.widgets.TbButton', array(
    'buttonType'=>'button',
    'type'=>'primary',
    'label'=>'Click me',
    'loadingText'=>'loading...',
    'htmlOptions'=>array('id'=>'buttonStateful'),
    ));  
    ?>
    
    
    
</div>



<?php $this->widget('bootstrap.widgets.TbGridView', array(
    'type'=>'striped bordered condensed',
    'dataProvider'=>$dataProvider,
    'template'=>"{items}",
    'columns'=>array(
        array('name'=>'id', 'header'=>'用户ID'),
        array('name'=>'login_name', 'header'=>'标题'),
        array('name'=>'rigist_time', 'header'=>'注册时间'),
        array('name'=>'points', 'header'=>'积分'),
        array(
            'class'=>'bootstrap.widgets.TbButtonColumn',
            'htmlOptions'=>array('style'=>'width: 50px'),
        ),
    ),
)); ?>
