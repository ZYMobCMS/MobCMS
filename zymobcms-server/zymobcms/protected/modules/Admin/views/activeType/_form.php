<?php $form=$this->beginWidget('bootstrap.widgets.TbActiveForm',array(
	'id'=>'active-type-form',
	'enableAjaxValidation'=>false,
)); ?>

	<p class="help-block">Fields with <span class="required">*</span> are required.</p>

	<?php echo $form->errorSummary($model); ?>

	<?php echo $form->textFieldRow($model,'type_name',array('class'=>'span5','maxlength'=>3000)); ?>

	<?php echo $form->textFieldRow($model,'type_point',array('class'=>'span5')); ?>

	<?php echo $form->textFieldRow($model,'create_user',array('class'=>'span5')); ?>

	<?php echo $form->textFieldRow($model,'create_time',array('class'=>'span5')); ?>

	<?php echo $form->textFieldRow($model,'status',array('class'=>'span5')); ?>

	<?php echo $form->textFieldRow($model,'relation_table',array('class'=>'span5','maxlength'=>3000)); ?>

<<<<<<< HEAD
	<?php echo $form->textFieldRow($model,'can_show_detail',array('class'=>'span5')); ?>

=======
>>>>>>> 9e438a74f5629d8503d3b4d558d27a1975878cdd
	<div class="form-actions">
		<?php $this->widget('bootstrap.widgets.TbButton', array(
			'buttonType'=>'submit',
			'type'=>'primary',
			'label'=>$model->isNewRecord ? 'Create' : 'Save',
		)); ?>
	</div>

<?php $this->endWidget(); ?>
