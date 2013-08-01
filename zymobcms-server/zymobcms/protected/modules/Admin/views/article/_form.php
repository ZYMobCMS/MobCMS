<?php
/* @var $this ArticleController */
/* @var $model Article */
/* @var $form CActiveForm */
?>



<div class="form">

        <?php $form=$this->beginWidget('CActiveForm', array(
                'id'=>'images-form',
                'enableAjaxValidation'=>false,
                'htmlOptions'=>array('enctype'=>'multipart/form-data'),
                 )); 
        ?>
    
	<p class="note">Fields with <span class="required">*</span> are required.</p>

	<?php echo $form->errorSummary($model); ?>

	<div class="row">
		<?php echo $form->labelEx($model,'title'); ?>
		<?php echo $form->textField($model,'title',array('size'=>60,'maxlength'=>100)); ?>
		<?php echo $form->error($model,'title'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'source'); ?>
		<?php echo $form->textField($model,'source',array('size'=>60,'maxlength'=>100)); ?>
		<?php echo $form->error($model,'source'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'summary'); ?>
		<?php echo $form->textField($model,'summary',array('size'=>60,'maxlength'=>500)); ?>
		<?php echo $form->error($model,'summary'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'author'); ?>
		<?php echo $form->textField($model,'author',array('size'=>50,'maxlength'=>50)); ?>
		<?php echo $form->error($model,'author'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'content'); ?>
		<?php echo $form->textField($model,'content',array('size'=>60,'maxlength'=>5000)); ?>
		<?php echo $form->error($model,'content'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'publish_time'); ?>
		<?php echo $form->textField($model,'publish_time'); ?>
		<?php echo $form->error($model,'publish_time'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'create_time'); ?>
		<?php echo $form->textField($model,'create_time'); ?>
		<?php echo $form->error($model,'create_time'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'status'); ?>
		<?php echo $form->textField($model,'status'); ?>
		<?php echo $form->error($model,'status'); ?>
	</div>

        
	<div class="row">
		<?php echo $form->labelEx($model,'images'); ?>
		<?php echo CHtml::activeFileField($model,'images'); ?>
		<?php echo $form->error($model,'images'); ?>
        </div>
        

	<div class="row">
		<?php echo $form->labelEx($model,'update_time'); ?>
		<?php echo $form->textField($model,'update_time'); ?>
		<?php echo $form->error($model,'update_time'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'category_id'); ?>
		<?php echo $form->dropDownList($model,'category_id',Rights::model()->getAllCategoryList(),array('empty'=>'--请选择模块--',
                                'ajax' => array(
                                'type'=>'POST',
                                'url'=>Yii::app()->createUrl('Admin/article/getTabTypes'),
                                'update'=>'#'.CHtml::activeId($model,'tab_typ_id')))); ?>
		<?php echo $form->error($model,'category_id'); ?>
	</div>
	
	<div class="row">
		<?php echo $form->labelEx($model,'tab_type_id'); ?>
		<?php echo $form->dropDownList($model,'tab_type_id',array()); ?>
		<?php echo $form->error($model,'tab_type_id'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'links'); ?>
		<?php echo $form->textField($model,'links',array('size'=>60,'maxlength'=>2000)); ?>
		<?php echo $form->error($model,'links'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'comment_count'); ?>
		<?php echo $form->textField($model,'comment_count'); ?>
		<?php echo $form->error($model,'comment_count'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'favorite_count'); ?>
		<?php echo $form->textField($model,'favorite_count'); ?>
		<?php echo $form->error($model,'favorite_count'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'commentable'); ?>
		<?php echo $form->textField($model,'commentable'); ?>
		<?php echo $form->error($model,'commentable'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'hot_news'); ?>
		<?php echo $form->textField($model,'hot_news'); ?>
		<?php echo $form->error($model,'hot_news'); ?>
	</div>

	<div class="row buttons">
		<?php echo CHtml::submitButton($model->isNewRecord ? 'Create' : 'Save'); ?>
	</div>

<?php $this->endWidget(); ?>

</div><!-- form -->