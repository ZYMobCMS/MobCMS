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
		<?php echo $form->labelEx($model,'right_id'); ?>
		<?php echo $form->textField($model,'right_id'); ?>
		<?php echo $form->error($model,'right_id'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'index'); ?>
		<?php echo $form->textField($model,'index'); ?>
		<?php echo $form->error($model,'index'); ?>
	</div>

	<div class="row buttons">
		<?php echo CHtml::submitButton($model->isNewRecord ? 'Create' : 'Save'); ?>
	</div>

<?php $this->endWidget(); ?>

</div><!-- form -->