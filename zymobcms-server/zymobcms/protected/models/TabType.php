<?php

/**
 * This is the model class for table "zy_tab_type".
 *
 * The followings are the available columns in table 'zy_tab_type':
 * @property integer $id
 * @property string $name
 * @property integer $create_user
 * @property integer $status
 * @property string $create_time
 * @property integer $category_id
 */
class TabType extends CActiveRecord
{
	/**
	 * Returns the static model of the specified AR class.
	 * @param string $className active record class name.
	 * @return TabType the static model class
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
		return 'zy_tab_type';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('name, create_user, status, create_time, category_id', 'required'),
			array('create_user, status, category_id', 'numerical', 'integerOnly'=>true),
			array('name', 'length', 'max'=>1000),
			// The following rule is used by search().
			// Please remove those attributes that should not be searched.
			array('id, name, create_user, status, create_time, category_id', 'safe', 'on'=>'search'),
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
				'categoryName'=>array(self::BELONGS_TO,'Rights','category_id'),
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
			'create_user' => 'Create User',
			'status' => 'Status',
			'create_time' => 'Create Time',
			'category_id' => 'Category',
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
		$criteria->compare('create_user',$this->create_user);
		$criteria->compare('status',$this->status);
		$criteria->compare('create_time',$this->create_time,true);
		$criteria->compare('category_id',$this->category_id);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}
	
	/*
	 * 获取对应category_id的tab_types
	*
	*/
	public function getTabTypeByCategoryId($categoryId){
	
		$sql = "select * from zy_tab_type where category_id = $categoryId";
	
		$resultArr = TabType::model()->findAllBySql($sql);
	
		return CHtml::listData($resultArr, 'id', 'name');
	
	
	}
}