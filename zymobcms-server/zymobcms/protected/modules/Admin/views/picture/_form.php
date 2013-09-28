<?php $form=$this->beginWidget('bootstrap.widgets.TbActiveForm',array(
	'id'=>'picture-form',
	'enableAjaxValidation'=>false,
)); ?>

	<p class="help-block">Fields with <span class="required">*</span> are required.</p>

	<?php echo $form->errorSummary($model); ?>

	<?php echo $form->textFieldRow($model,'title',array('class'=>'span5','maxlength'=>200)); ?>

	<?php echo $form->textFieldRow($model,'summary',array('class'=>'span5','maxlength'=>8000)); ?>

	<?php echo $form->textFieldRow($model,'images',array('class'=>'span5','maxlength'=>3000)); ?>

	<?php echo $form->textFieldRow($model,'create_time',array('class'=>'span5')); ?>

	<?php echo $form->textFieldRow($model,'create_user',array('class'=>'span5')); ?>

	<?php echo $form->textFieldRow($model,'status',array('class'=>'span5')); ?>

	<?php echo $form->textFieldRow($model,'links',array('class'=>'span5','maxlength'=>2000)); ?>

	<?php echo $form->textFieldRow($model,'comment_count',array('class'=>'span5')); ?>

	<?php echo $form->textFieldRow($model,'favorite_count',array('class'=>'span5')); ?>

	<?php echo $form->textFieldRow($model,'source',array('class'=>'span5','maxlength'=>2000)); ?>

	<?php echo $form->textFieldRow($model,'industry_id',array('class'=>'span5')); ?>

	<?php echo $form->textFieldRow($model,'main_category_id',array('class'=>'span5')); ?>

	<?php echo $form->textFieldRow($model,'sub_tab_type_id',array('class'=>'span5')); ?>

	<?php echo $form->textFieldRow($model,'market_price',array('class'=>'span5')); ?>

	<?php echo $form->textFieldRow($model,'we_price',array('class'=>'span5')); ?>

	<?php echo $form->textFieldRow($model,'low_price',array('class'=>'span5')); ?>

	<?php echo $form->textFieldRow($model,'product_code',array('class'=>'span5','maxlength'=>2000)); ?>

	<?php echo $form->textFieldRow($model,'product_face_code',array('class'=>'span5','maxlength'=>2000)); ?>

	<?php echo $form->textFieldRow($model,'contact_mobile',array('class'=>'span5','maxlength'=>2000)); ?>

	<?php echo $form->textFieldRow($model,'product_combine',array('class'=>'span5','maxlength'=>2000)); ?>

	<?php echo $form->textFieldRow($model,'location',array('class'=>'span5','maxlength'=>2000)); ?>

	<?php echo $form->textFieldRow($model,'has_now',array('class'=>'span5')); ?>

	<?php echo $form->textFieldRow($model,'product_sale_face',array('class'=>'span5','maxlength'=>2000)); ?>

	<?php echo $form->textFieldRow($model,'product_respority_code',array('class'=>'span5','maxlength'=>2000)); ?>

	<?php echo $form->textFieldRow($model,'has_sale_count',array('class'=>'span5')); ?>

	<div class="form-actions">
		<?php $this->widget('bootstrap.widgets.TbButton', array(
			'buttonType'=>'submit',
			'type'=>'primary',
			'label'=>$model->isNewRecord ? 'Create' : 'Save',
		)); ?>
	</div>

<?php $this->endWidget(); ?>
