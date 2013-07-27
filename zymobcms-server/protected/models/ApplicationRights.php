<?php

/**
 * This is the model class for table "zy_application_rights".
 *
 * The followings are the available columns in table 'zy_application_rights':
 * @property integer $category_right
 * @property integer $topic_right
 * @property integer $user_center_right
 * @property integer $picture_right
 * @property integer $user_id
 * @property integer $user_type_id
 */
class ApplicationRights extends CActiveRecord
{
	/**
	 * Returns the static model of the specified AR class.
	 * @param string $className active record class name.
	 * @return ApplicationRights the static model class
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
		return 'zy_application_rights';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('category_right, topic_right, user_center_right, picture_right, user_id, user_type_id', 'required'),
			array('category_right, topic_right, user_center_right, picture_right, user_id, user_type_id', 'numerical', 'integerOnly'=>true),
			// The following rule is used by search().
			// Please remove those attributes that should not be searched.
			array('category_right, topic_right, user_center_right, picture_right, user_id, user_type_id', 'safe', 'on'=>'search'),
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
			'category_right' => 'Category Right',
			'topic_right' => 'Topic Right',
			'user_center_right' => 'User Center Right',
			'picture_right' => 'Picture Right',
			'user_id' => 'User',
			'user_type_id' => 'User Type',
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

		$criteria->compare('category_right',$this->category_right);
		$criteria->compare('topic_right',$this->topic_right);
		$criteria->compare('user_center_right',$this->user_center_right);
		$criteria->compare('picture_right',$this->picture_right);
		$criteria->compare('user_id',$this->user_id);
		$criteria->compare('user_type_id',$this->user_type_id);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}
}