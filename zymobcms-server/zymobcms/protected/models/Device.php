<?php

/**
 * This is the model class for table "zy_device".
 *
 * The followings are the available columns in table 'zy_device':
 * @property integer $id
 * @property string $token
 * @property integer $type_id
 * @property string $create_time
 * @property string $login_name
 * @property integer $user_id
 */
class Device extends RActiveRecord
{
	/**
	 * Returns the static model of the specified AR class.
	 * @param string $className active record class name.
	 * @return Device the static model class
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
		return 'zy_device';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('token, type_id, create_time, login_name, user_id', 'required'),
			array('type_id, user_id', 'numerical', 'integerOnly'=>true),
			array('token', 'length', 'max'=>3000),
			array('login_name', 'length', 'max'=>2000),
			// The following rule is used by search().
			// Please remove those attributes that should not be searched.
			array('id, token, type_id, create_time, login_name, user_id', 'safe', 'on'=>'search'),
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
			'token' => 'Token',
			'type_id' => 'Type',
			'create_time' => 'Create Time',
			'login_name' => 'Login Name',
			'user_id' => 'User',
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
		$criteria->compare('token',$this->token,true);
		$criteria->compare('type_id',$this->type_id);
		$criteria->compare('create_time',$this->create_time,true);
		$criteria->compare('login_name',$this->login_name,true);
		$criteria->compare('user_id',$this->user_id);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}
        
        public function getDbConnection()
        {
            return self::getAdvertDbConnection();
        }
}