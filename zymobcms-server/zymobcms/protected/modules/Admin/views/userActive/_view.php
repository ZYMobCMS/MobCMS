<div class="view">

	<b><?php echo CHtml::encode($data->getAttributeLabel('id')); ?>:</b>
	<?php echo CHtml::link(CHtml::encode($data->id),array('view','id'=>$data->id)); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('relation_id')); ?>:</b>
	<?php echo CHtml::encode($data->relation_id); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('relation_table')); ?>:</b>
	<?php echo CHtml::encode($data->relation_table); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('content')); ?>:</b>
	<?php echo CHtml::encode($data->content); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('create_time')); ?>:</b>
	<?php echo CHtml::encode($data->create_time); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('status')); ?>:</b>
	<?php echo CHtml::encode($data->status); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('create_user')); ?>:</b>
	<?php echo CHtml::encode($data->create_user); ?>
	<br />

	<?php /*
	<b><?php echo CHtml::encode($data->getAttributeLabel('active_type_id')); ?>:</b>
	<?php echo CHtml::encode($data->active_type_id); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('relation_images')); ?>:</b>
	<?php echo CHtml::encode($data->relation_images); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('refer_user')); ?>:</b>
	<?php echo CHtml::encode($data->refer_user); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('create_login_name')); ?>:</b>
	<?php echo CHtml::encode($data->create_login_name); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('create_nick_name')); ?>:</b>
	<?php echo CHtml::encode($data->create_nick_name); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('relation_title')); ?>:</b>
	<?php echo CHtml::encode($data->relation_title); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('user_active_open')); ?>:</b>
	<?php echo CHtml::encode($data->user_active_open); ?>
	<br />

	*/ ?>

</div>