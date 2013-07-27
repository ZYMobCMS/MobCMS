<?php
/* @var $this AboutUsController */
/* @var $data AboutUs */
?>

<div class="view">

	<b><?php echo CHtml::encode($data->getAttributeLabel('id')); ?>:</b>
	<?php echo CHtml::link(CHtml::encode($data->id), array('view', 'id'=>$data->id)); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('content')); ?>:</b>
	<?php echo CHtml::encode($data->content); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('phone')); ?>:</b>
	<?php echo CHtml::encode($data->phone); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('website')); ?>:</b>
	<?php echo CHtml::encode($data->website); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('email')); ?>:</b>
	<?php echo CHtml::encode($data->email); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('qq')); ?>:</b>
	<?php echo CHtml::encode($data->qq); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('msn')); ?>:</b>
	<?php echo CHtml::encode($data->msn); ?>
	<br />

	<?php /*
	<b><?php echo CHtml::encode($data->getAttributeLabel('home_phone')); ?>:</b>
	<?php echo CHtml::encode($data->home_phone); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('copy_right')); ?>:</b>
	<?php echo CHtml::encode($data->copy_right); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('company_name')); ?>:</b>
	<?php echo CHtml::encode($data->company_name); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('blog_host')); ?>:</b>
	<?php echo CHtml::encode($data->blog_host); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('contact_who')); ?>:</b>
	<?php echo CHtml::encode($data->contact_who); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('status')); ?>:</b>
	<?php echo CHtml::encode($data->status); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('product_name')); ?>:</b>
	<?php echo CHtml::encode($data->product_name); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('logo_image')); ?>:</b>
	<?php echo CHtml::encode($data->logo_image); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('update_time')); ?>:</b>
	<?php echo CHtml::encode($data->update_time); ?>
	<br />

	*/ ?>

</div>