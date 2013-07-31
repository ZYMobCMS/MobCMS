<?php
/* @var $this ApplicationRightsController */
/* @var $data ApplicationRights */
?>

<div class="view">

	<b><?php echo CHtml::encode($data->getAttributeLabel('right_id')); ?>:</b>
	<?php echo CHtml::link(CHtml::encode($data->right_id), array('view', 'id'=>$data->right_id)); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('index')); ?>:</b>
	<?php echo CHtml::encode($data->index); ?>
	<br />


</div>