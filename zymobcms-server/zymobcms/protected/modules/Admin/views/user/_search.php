<?php $form=$this->beginWidget('bootstrap.widgets.TbActiveForm',array(
	'action'=>Yii::app()->createUrl($this->route),
	'method'=>'get',
)); ?>

	<?php echo $form->textFieldRow($model,'id',array('class'=>'span5')); ?>

	<?php echo $form->textFieldRow($model,'login_name',array('class'=>'span5','maxlength'=>50)); ?>

	<?php echo $form->textAreaRow($model,'nick_name',array('rows'=>6, 'cols'=>50, 'class'=>'span8')); ?>

	<?php echo $form->textFieldRow($model,'rigist_time',array('class'=>'span5')); ?>

	<?php echo $form->textFieldRow($model,'status',array('class'=>'span5')); ?>

	<?php echo $form->textFieldRow($model,'user_type_id',array('class'=>'span5')); ?>

	<?php echo $form->textFieldRow($model,'msn',array('class'=>'span5','maxlength'=>100)); ?>

	<?php echo $form->textFieldRow($model,'qq',array('class'=>'span5','maxlength'=>100)); ?>

	<?php echo $form->textFieldRow($model,'email',array('class'=>'span5','maxlength'=>100)); ?>

	<?php echo $form->textFieldRow($model,'phone',array('class'=>'span5','maxlength'=>100)); ?>

	<?php echo $form->textFieldRow($model,'mobile',array('class'=>'span5','maxlength'=>100)); ?>

	<?php echo $form->textFieldRow($model,'profile',array('class'=>'span5','maxlength'=>500)); ?>

	<?php echo $form->textFieldRow($model,'sex',array('class'=>'span5')); ?>

	<?php echo $form->textFieldRow($model,'location',array('class'=>'span5','maxlength'=>300)); ?>

	<?php echo $form->textFieldRow($model,'token',array('class'=>'span5','maxlength'=>5000)); ?>

	<?php echo $form->textFieldRow($model,'login_days',array('class'=>'span5')); ?>

	<?php echo $form->textFieldRow($model,'points',array('class'=>'span5')); ?>

	<?php echo $form->textFieldRow($model,'user_active_open',array('class'=>'span5')); ?>

	<div class="form-actions">
		<?php $this->widget('bootstrap.widgets.TbButton', array(
			'buttonType'=>'submit',
			'type'=>'primary',
			'label'=>'Search',
		)); ?>
	</div>

<?php $this->endWidget(); ?>
