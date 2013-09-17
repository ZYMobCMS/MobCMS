<?php
/* @var $this UserController */
/* @var $model User */
/* @var $form CActiveForm */
?>

<div class="form">

<?php $form=$this->beginWidget('CActiveForm', array(
	'id'=>'user-form',
	'enableAjaxValidation'=>false,
)); ?>

	<p class="note">Fields with <span class="required">*</span> are required.</p>

        
        <?php $this->widget('bootstrap.widgets.TbDetailView', array(
        'data'=>array('id'=>1, 'firstName'=>'Mark', 'lastName'=>'Otto', 'language'=>'CSS'),
        'attributes'=>array(
        array('name'=>'firstName', 'label'=>'First name'),
        array('name'=>'lastName', 'label'=>'Last name'),
        array('name'=>'language', 'label'=>'Language'),
        ),
        )); ?>
        
	<?php echo $form->errorSummary($model); ?>

	<div class="row">
		<?php echo $form->labelEx($model,'login_name'); ?>
		<?php echo $form->textField($model,'login_name',array('size'=>50,'maxlength'=>50)); ?>
		<?php echo $form->error($model,'login_name'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'password'); ?>
		<?php echo $form->passwordField($model,'password',array('size'=>60,'maxlength'=>2000)); ?>
		<?php echo $form->error($model,'password'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'nick_name'); ?>
		<?php echo $form->textArea($model,'nick_name',array('rows'=>6, 'cols'=>50)); ?>
		<?php echo $form->error($model,'nick_name'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'rigist_time'); ?>
		<?php echo $form->textField($model,'rigist_time'); ?>
		<?php echo $form->error($model,'rigist_time'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'status'); ?>
		<?php echo $form->textField($model,'status'); ?>
		<?php echo $form->error($model,'status'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'user_type_id'); ?>
		<?php echo $form->textField($model,'user_type_id'); ?>
		<?php echo $form->error($model,'user_type_id'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'msn'); ?>
		<?php echo $form->textField($model,'msn',array('size'=>60,'maxlength'=>100)); ?>
		<?php echo $form->error($model,'msn'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'qq'); ?>
		<?php echo $form->textField($model,'qq',array('size'=>60,'maxlength'=>100)); ?>
		<?php echo $form->error($model,'qq'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'email'); ?>
		<?php echo $form->textField($model,'email',array('size'=>60,'maxlength'=>100)); ?>
		<?php echo $form->error($model,'email'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'phone'); ?>
		<?php echo $form->textField($model,'phone',array('size'=>60,'maxlength'=>100)); ?>
		<?php echo $form->error($model,'phone'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'mobile'); ?>
		<?php echo $form->textField($model,'mobile',array('size'=>60,'maxlength'=>100)); ?>
		<?php echo $form->error($model,'mobile'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'profile'); ?>
		<?php echo $form->textField($model,'profile',array('size'=>60,'maxlength'=>500)); ?>
		<?php echo $form->error($model,'profile'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'sex'); ?>
		<?php echo $form->textField($model,'sex'); ?>
		<?php echo $form->error($model,'sex'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'location'); ?>
		<?php echo $form->textField($model,'location',array('size'=>60,'maxlength'=>300)); ?>
		<?php echo $form->error($model,'location'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'token'); ?>
		<?php echo $form->textField($model,'token',array('size'=>60,'maxlength'=>5000)); ?>
		<?php echo $form->error($model,'token'); ?>
	</div>

	<div class="row buttons">
		<?php echo CHtml::submitButton($model->isNewRecord ? 'Create' : 'Save'); ?>
	</div>

<?php $this->endWidget(); ?>

</div><!-- form -->