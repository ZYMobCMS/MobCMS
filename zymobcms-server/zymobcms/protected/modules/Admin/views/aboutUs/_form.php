<?php $form=$this->beginWidget('bootstrap.widgets.TbActiveForm',array(
	'id'=>'about-us-form',
	'enableAjaxValidation'=>false,
)); ?>

	<p class="help-block">Fields with <span class="required">*</span> are required.</p>

	<?php echo $form->errorSummary($model); ?>

	<?php echo $form->textFieldRow($model,'tag',array('class'=>'span5','maxlength'=>500)); ?>

	<?php echo $form->textFieldRow($model,'value',array('class'=>'span5','maxlength'=>8000)); ?>

	<?php echo $form->textFieldRow($model,'type_id',array('class'=>'span5')); ?>

	<div class="form-actions">
		<?php $this->widget('bootstrap.widgets.TbButton', array(
			'buttonType'=>'submit',
			'type'=>'primary',
			'label'=>$model->isNewRecord ? 'Create' : 'Save',
		)); ?>
	</div>

<?php $this->endWidget(); ?>
