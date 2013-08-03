<?php
/* @var $this UserMessageController */
/* @var $model UserMessage */
/* @var $form CActiveForm */
?>

<div class="form">

<?php $form=$this->beginWidget('CActiveForm', array(
	'id'=>'user-message-form',
	'enableAjaxValidation'=>false,
)); ?>

	<p class="note">Fields with <span class="required">*</span> are required.</p>

	<?php echo $form->errorSummary($model); ?>

	<div class="row">
		<?php echo $form->labelEx($model,'from_user_id'); ?>
		<?php echo $form->textField($model,'from_user_id'); ?>
		<?php echo $form->error($model,'from_user_id'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'recieve_user_id'); ?>
		<?php echo $form->textField($model,'recieve_user_id'); ?>
		<?php echo $form->error($model,'recieve_user_id'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'content'); ?>
		<?php echo $form->textField($model,'content',array('size'=>60,'maxlength'=>2000)); ?>
		<?php echo $form->error($model,'content'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'send_time'); ?>
		<?php echo $form->textField($model,'send_time'); ?>
		<?php echo $form->error($model,'send_time'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'status'); ?>
		<?php echo $form->textField($model,'status'); ?>
		<?php echo $form->error($model,'status'); ?>
	</div>

	<div class="row buttons">
		<?php echo CHtml::submitButton($model->isNewRecord ? 'Create' : 'Save'); ?>
	</div>

<?php $this->endWidget(); ?>

</div><!-- form -->