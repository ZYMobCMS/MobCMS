<div class="view">

	<b><?php echo CHtml::encode($data->getAttributeLabel('id')); ?>:</b>
	<?php echo CHtml::link(CHtml::encode($data->id),array('view','id'=>$data->id)); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('type_name')); ?>:</b>
	<?php echo CHtml::encode($data->type_name); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('type_point')); ?>:</b>
	<?php echo CHtml::encode($data->type_point); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('create_user')); ?>:</b>
	<?php echo CHtml::encode($data->create_user); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('create_time')); ?>:</b>
	<?php echo CHtml::encode($data->create_time); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('status')); ?>:</b>
	<?php echo CHtml::encode($data->status); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('relation_table')); ?>:</b>
	<?php echo CHtml::encode($data->relation_table); ?>
	<br />

<<<<<<< HEAD
	<?php /*
	<b><?php echo CHtml::encode($data->getAttributeLabel('can_show_detail')); ?>:</b>
	<?php echo CHtml::encode($data->can_show_detail); ?>
	<br />

	*/ ?>
=======
>>>>>>> 9e438a74f5629d8503d3b4d558d27a1975878cdd

</div>