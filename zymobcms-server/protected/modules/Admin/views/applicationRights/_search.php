<?php
/* @var $this ApplicationRightsController */
/* @var $model ApplicationRights */
/* @var $form CActiveForm */
?>

<div class="wide form">

<?php $form=$this->beginWidget('CActiveForm', array(
	'action'=>Yii::app()->createUrl($this->route),
	'method'=>'get',
)); ?>

	<div class="row">
		<?php echo $form->label($model,'category_right'); ?>
		<?php echo $form->textField($model,'category_right'); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'topic_right'); ?>
		<?php echo $form->textField($model,'topic_right'); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'user_center_right'); ?>
		<?php echo $form->textField($model,'user_center_right'); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'picture_right'); ?>
		<?php echo $form->textField($model,'picture_right'); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'user_id'); ?>
		<?php echo $form->textField($model,'user_id'); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'user_type_id'); ?>
		<?php echo $form->textField($model,'user_type_id'); ?>
	</div>

	<div class="row buttons">
		<?php echo CHtml::submitButton('Search'); ?>
	</div>

<?php $this->endWidget(); ?>

</div><!-- search-form -->