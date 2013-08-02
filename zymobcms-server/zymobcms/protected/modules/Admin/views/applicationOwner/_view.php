<?php
/* @var $this ApplicationOwnerController */
/* @var $data ApplicationOwner */
?>

<div class="view">

	<b><?php echo CHtml::encode($data->getAttributeLabel('owner_id')); ?>:</b>
	<?php echo CHtml::link(CHtml::encode($data->owner_id), array('view', 'id'=>$data->owner_id)); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('status')); ?>:</b>
	<?php echo CHtml::encode($data->status); ?>
	<br />


</div>