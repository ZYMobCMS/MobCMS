<?php

/**
 * This is the model class for table "zy_topic".
 *
 * The followings are the available columns in table 'zy_topic':
 * @property integer $id
 * @property string $name
 * @property integer $relate_article_id
 * @property string $summary
 * @property string $content
 * @property string $create_time
 * @property string $update_time
 * @property integer $create_user
 * @property integer $support_count
 * @property integer $unsupport_count
 * @property integer $status
 */
class Topic extends CActiveRecord
{
	/**
	 * Returns the static model of the specified AR class.
	 * @param string $className active record class name.
	 * @return Topic the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}

	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'zy_topic';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('name, relate_article_id, summary, content, create_time, update_time, create_user, support_count, unsupport_count, status', 'required'),
			array('relate_article_id, create_user, support_count, unsupport_count, status', 'numerical', 'integerOnly'=>true),
			array('name', 'length', 'max'=>200),
			array('summary', 'length', 'max'=>500),
			array('content', 'length', 'max'=>3000),
			// The following rule is used by search().
			// Please remove those attributes that should not be searched.
			array('id, name, relate_article_id, summary, content, create_time, update_time, create_user, support_count, unsupport_count, status', 'safe', 'on'=>'search'),
		);
	}

	/**
	 * @return array relational rules.
	 */
	public function relations()
	{
		// NOTE: you may need to adjust the relation name and the related
		// class name for the relations automatically generated below.
		return array(
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'id' => 'ID',
			'name' => 'Name',
			'relate_article_id' => 'Relate Article',
			'summary' => 'Summary',
			'content' => 'Content',
			'create_time' => 'Create Time',
			'update_time' => 'Update Time',
			'create_user' => 'Create User',
			'support_count' => 'Support Count',
			'unsupport_count' => 'Unsupport Count',
			'status' => 'Status',
		);
	}

	/**
	 * Retrieves a list of models based on the current search/filter conditions.
	 * @return CActiveDataProvider the data provider that can return the models based on the search/filter conditions.
	 */
	public function search()
	{
		// Warning: Please modify the following code to remove attributes that
		// should not be searched.

		$criteria=new CDbCriteria;

		$criteria->compare('id',$this->id);
		$criteria->compare('name',$this->name,true);
		$criteria->compare('relate_article_id',$this->relate_article_id);
		$criteria->compare('summary',$this->summary,true);
		$criteria->compare('content',$this->content,true);
		$criteria->compare('create_time',$this->create_time,true);
		$criteria->compare('update_time',$this->update_time,true);
		$criteria->compare('create_user',$this->create_user);
		$criteria->compare('support_count',$this->support_count);
		$criteria->compare('unsupport_count',$this->unsupport_count);
		$criteria->compare('status',$this->status);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}
}