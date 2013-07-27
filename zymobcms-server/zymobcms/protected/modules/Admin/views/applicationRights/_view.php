<?php
/* @var $this ApplicationRightsController */
/* @var $data ApplicationRights */
?>

<div class="view">

	<b><?php echo CHtml::encode($data->getAttributeLabel('user_id')); ?>:</b>
	<?php echo CHtml::link(CHtml::encode($data->user_id), array('view', 'id'=>$data->user_id)); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('category_right')); ?>:</b>
	<?php echo CHtml::encode($data->category_right); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('topic_right')); ?>:</b>
	<?php echo CHtml::encode($data->topic_right); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('user_center_right')); ?>:</b>
	<?php echo CHtml::encode($data->user_center_right); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('picture_right')); ?>:</b>
	<?php echo CHtml::encode($data->picture_right); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('user_type_id')); ?>:</b>
	<?php echo CHtml::encode($data->user_type_id); ?>
	<br />


</div>