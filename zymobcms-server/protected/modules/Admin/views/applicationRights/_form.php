<?php
/* @var $this ApplicationRightsController */
/* @var $model ApplicationRights */
/* @var $form CActiveForm */
?>

<div class="form">

<?php $form=$this->beginWidget('CActiveForm', array(
	'id'=>'application-rights-form',
	'enableAjaxValidation'=>false,
)); ?>

	<p class="note">Fields with <span class="required">*</span> are required.</p>

	<?php echo $form->errorSummary($model); ?>

	<div class="row">
		<?php echo $form->labelEx($model,'category_right'); ?>
		<?php echo $form->textField($model,'category_right'); ?>
		<?php echo $form->error($model,'category_right'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'topic_right'); ?>
		<?php echo $form->textField($model,'topic_right'); ?>
		<?php echo $form->error($model,'topic_right'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'user_center_right'); ?>
		<?php echo $form->textField($model,'user_center_right'); ?>
		<?php echo $form->error($model,'user_center_right'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'picture_right'); ?>
		<?php echo $form->textField($model,'picture_right'); ?>
		<?php echo $form->error($model,'picture_right'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'user_id'); ?>
		<?php echo $form->textField($model,'user_id'); ?>
		<?php echo $form->error($model,'user_id'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'user_type_id'); ?>
		<?php echo $form->textField($model,'user_type_id'); ?>
		<?php echo $form->error($model,'user_type_id'); ?>
	</div>

	<div class="row buttons">
		<?php echo CHtml::submitButton($model->isNewRecord ? 'Create' : 'Save'); ?>
	</div>

<?php $this->endWidget(); ?>

</div><!-- form -->