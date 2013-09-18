<?php $form=$this->beginWidget('bootstrap.widgets.TbActiveForm',array(
	'action'=>Yii::app()->createUrl($this->route),
	'method'=>'get',
)); ?>

	<?php echo $form->textFieldRow($model,'id',array('class'=>'span5')); ?>

	<?php echo $form->textFieldRow($model,'title',array('class'=>'span5','maxlength'=>100)); ?>

	<?php echo $form->textFieldRow($model,'source',array('class'=>'span5','maxlength'=>100)); ?>

	<?php echo $form->textFieldRow($model,'summary',array('class'=>'span5','maxlength'=>500)); ?>

	<?php echo $form->textFieldRow($model,'author',array('class'=>'span5','maxlength'=>50)); ?>

	<?php echo $form->textFieldRow($model,'content',array('class'=>'span5','maxlength'=>5000)); ?>

	<?php echo $form->textFieldRow($model,'publish_time',array('class'=>'span5')); ?>

	<?php echo $form->textFieldRow($model,'create_time',array('class'=>'span5')); ?>

	<?php echo $form->textFieldRow($model,'status',array('class'=>'span5')); ?>

	<?php echo $form->textFieldRow($model,'images',array('class'=>'span5','maxlength'=>2000)); ?>

	<?php echo $form->textFieldRow($model,'update_time',array('class'=>'span5')); ?>

	<?php echo $form->textFieldRow($model,'tab_type_id',array('class'=>'span5')); ?>

	<?php echo $form->textFieldRow($model,'category_id',array('class'=>'span5')); ?>

	<?php echo $form->textFieldRow($model,'links',array('class'=>'span5','maxlength'=>2000)); ?>

	<?php echo $form->textFieldRow($model,'comment_count',array('class'=>'span5')); ?>

	<?php echo $form->textFieldRow($model,'favorite_count',array('class'=>'span5')); ?>

	<?php echo $form->textFieldRow($model,'commentable',array('class'=>'span5')); ?>

	<?php echo $form->textFieldRow($model,'hot_news',array('class'=>'span5')); ?>

	<?php echo $form->textFieldRow($model,'industry_id',array('class'=>'span5')); ?>

	<div class="form-actions">
		<?php $this->widget('bootstrap.widgets.TbButton', array(
			'buttonType'=>'submit',
			'type'=>'primary',
			'label'=>'Search',
		)); ?>
	</div>

<?php $this->endWidget(); ?>
