<?php

/**
 * This is the model class for table "zy_application_owner".
 *
 * The followings are the available columns in table 'zy_application_owner':
 * @property integer $owner_id
 * @property integer $status
 * @property string $name
 * @property string $appId
 * @property string $pem_path
 */
class ApplicationOwner extends RActiveRecord
{
	/**
	 * Returns the static model of the specified AR class.
	 * @param string $className active record class name.
	 * @return ApplicationOwner the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
        
        public function getDbConnection()
        {
                return self::getAdvertDbConnection();
        }

	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'zy_application_owner';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('status, name, appId, pem_path', 'required'),
			array('status', 'numerical', 'integerOnly'=>true),
			array('name', 'length', 'max'=>200),
			array('appId, pem_path', 'length', 'max'=>2000),
			// The following rule is used by search().
			// Please remove those attributes that should not be searched.
			array('owner_id, status, name, appId, pem_path', 'safe', 'on'=>'search'),
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
			'owner_id' => 'Owner',
			'status' => 'Status',
			'name' => 'Name',
			'appId' => 'App',
			'pem_path' => 'Pem Path',
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

		$criteria->compare('owner_id',$this->owner_id);
		$criteria->compare('status',$this->status);
		$criteria->compare('name',$this->name,true);
		$criteria->compare('appId',$this->appId,true);
		$criteria->compare('pem_path',$this->pem_path,true);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}
        
}