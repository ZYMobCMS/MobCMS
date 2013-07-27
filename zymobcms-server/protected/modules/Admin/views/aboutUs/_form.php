<?php
/* @var $this AboutUsController */
/* @var $model AboutUs */
/* @var $form CActiveForm */
?>

<div class="form">

<?php $form=$this->beginWidget('CActiveForm', array(
	'id'=>'about-us-form',
	'enableAjaxValidation'=>false,
)); ?>

	<p class="note">Fields with <span class="required">*</span> are required.</p>

	<?php echo $form->errorSummary($model); ?>

	<div class="row">
		<?php echo $form->labelEx($model,'content'); ?>
		<?php echo $form->textField($model,'content',array('size'=>60,'maxlength'=>3000)); ?>
		<?php echo $form->error($model,'content'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'phone'); ?>
		<?php echo $form->textField($model,'phone',array('size'=>60,'maxlength'=>300)); ?>
		<?php echo $form->error($model,'phone'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'website'); ?>
		<?php echo $form->textField($model,'website',array('size'=>60,'maxlength'=>300)); ?>
		<?php echo $form->error($model,'website'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'email'); ?>
		<?php echo $form->textField($model,'email',array('size'=>60,'maxlength'=>500)); ?>
		<?php echo $form->error($model,'email'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'qq'); ?>
		<?php echo $form->textField($model,'qq',array('size'=>60,'maxlength'=>100)); ?>
		<?php echo $form->error($model,'qq'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'msn'); ?>
		<?php echo $form->textField($model,'msn',array('size'=>60,'maxlength'=>100)); ?>
		<?php echo $form->error($model,'msn'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'home_phone'); ?>
		<?php echo $form->textField($model,'home_phone',array('size'=>60,'maxlength'=>100)); ?>
		<?php echo $form->error($model,'home_phone'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'copy_right'); ?>
		<?php echo $form->textField($model,'copy_right',array('size'=>60,'maxlength'=>100)); ?>
		<?php echo $form->error($model,'copy_right'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'company_name'); ?>
		<?php echo $form->textField($model,'company_name',array('size'=>60,'maxlength'=>1000)); ?>
		<?php echo $form->error($model,'company_name'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'blog_host'); ?>
		<?php echo $form->textField($model,'blog_host',array('size'=>60,'maxlength'=>500)); ?>
		<?php echo $form->error($model,'blog_host'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'contact_who'); ?>
		<?php echo $form->textField($model,'contact_who',array('size'=>60,'maxlength'=>500)); ?>
		<?php echo $form->error($model,'contact_who'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'status'); ?>
		<?php echo $form->textField($model,'status'); ?>
		<?php echo $form->error($model,'status'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'product_name'); ?>
		<?php echo $form->textField($model,'product_name',array('size'=>60,'maxlength'=>500)); ?>
		<?php echo $form->error($model,'product_name'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'logo_image'); ?>
		<?php echo $form->textField($model,'logo_image',array('size'=>60,'maxlength'=>1000)); ?>
		<?php echo $form->error($model,'logo_image'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'update_time'); ?>
		<?php echo $form->textField($model,'update_time'); ?>
		<?php echo $form->error($model,'update_time'); ?>
	</div>

	<div class="row buttons">
		<?php echo CHtml::submitButton($model->isNewRecord ? 'Create' : 'Save'); ?>
	</div>

<?php $this->endWidget(); ?>

</div><!-- form -->