<?php

/**
 * This is the model class for table "zy_user_categories".
 *
 * The followings are the available columns in table 'zy_user_categories':
 * @property integer $id
 * @property integer $category_id
 * @property integer $status
 * @property string $add_time
 * @property integer $create_user
 */
class UserCategories extends CActiveRecord
{
	/**
	 * Returns the static model of the specified AR class.
	 * @param string $className active record class name.
	 * @return UserCategories the static model class
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
		return 'zy_user_categories';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('category_id, status, add_time, create_user', 'required'),
			array('category_id, status, create_user', 'numerical', 'integerOnly'=>true),
			// The following rule is used by search().
			// Please remove those attributes that should not be searched.
			array('id, category_id, status, add_time, create_user', 'safe', 'on'=>'search'),
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
			'category_id' => 'Category',
			'status' => 'Status',
			'add_time' => 'Add Time',
			'create_user' => 'Create User',
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
		$criteria->compare('category_id',$this->category_id);
		$criteria->compare('status',$this->status);
		$criteria->compare('add_time',$this->add_time,true);
		$criteria->compare('create_user',$this->create_user);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}
}