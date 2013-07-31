<?php

/**
 * This is the model class for table "zy_rights".
 *
 * The followings are the available columns in table 'zy_rights':
 * @property integer $id
 * @property string $name
 * @property integer $is_category
 * @property integer $create_user
 * @property string $create_time
 * @property integer $index
 */
class Rights extends CActiveRecord
{
	/**
	 * Returns the static model of the specified AR class.
	 * @param string $className active record class name.
	 * @return Rights the static model class
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
		return 'zy_rights';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('name, is_category, index', 'required'),
			array('is_category, create_user, index', 'numerical', 'integerOnly'=>true),
			array('name', 'length', 'max'=>1000),
			array('create_user, create_time','safe'),
			// The following rule is used by search().
			// Please remove those attributes that should not be searched.
			array('id, name, is_category, create_user, create_time, index', 'safe', 'on'=>'search'),
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
			'is_category' => 'Is Category',
			'create_user' => 'Create User',
			'create_time' => 'Create Time',
			'index' => 'Index',
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
		$criteria->compare('is_category',$this->is_category);
		$criteria->compare('create_user',$this->create_user);
		$criteria->compare('create_time',$this->create_time,true);
		$criteria->compare('index',$this->index);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}
	
	/*
	 * 获取是category类型的模块
	 * 
	 */
	public function getAllCategoryList(){
		
		$sql = "select * from zy_rights where is_category=1";
		$resultArr = Rights::model()->findAllBySql($sql);
		
		return CHtml::listData($resultArr,'id','name');
	}
}