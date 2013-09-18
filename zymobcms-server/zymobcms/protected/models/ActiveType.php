<?php

/**
 * This is the model class for table "zy_active_type".
 *
 * The followings are the available columns in table 'zy_active_type':
 * @property integer $id
 * @property string $type_name
 * @property integer $type_point
 * @property integer $create_user
 * @property string $create_time
 * @property integer $status
 * @property string $relation_table
 */
class ActiveType extends RActiveRecord
{
	/**
	 * Returns the static model of the specified AR class.
	 * @param string $className active record class name.
	 * @return ActiveType the static model class
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
		return 'zy_active_type';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('type_name, type_point, create_user, create_time, status, relation_table', 'required'),
			array('type_point, create_user, status', 'numerical', 'integerOnly'=>true),
			array('type_name, relation_table', 'length', 'max'=>3000),
			// The following rule is used by search().
			// Please remove those attributes that should not be searched.
			array('id, type_name, type_point, create_user, create_time, status, relation_table', 'safe', 'on'=>'search'),
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
			'type_name' => 'Type Name',
			'type_point' => 'Type Point',
			'create_user' => 'Create User',
			'create_time' => 'Create Time',
			'status' => 'Status',
			'relation_table' => 'Relation Table',
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
		$criteria->compare('type_name',$this->type_name,true);
		$criteria->compare('type_point',$this->type_point);
		$criteria->compare('create_user',$this->create_user);
		$criteria->compare('create_time',$this->create_time,true);
		$criteria->compare('status',$this->status);
		$criteria->compare('relation_table',$this->relation_table,true);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}
}