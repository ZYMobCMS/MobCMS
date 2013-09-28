<?php

/**
 * This is the model class for table "zy_rights".
 *
 * The followings are the available columns in table 'zy_rights':
 * @property integer $id
 * @property string $name
 * @property integer $module_id
 * @property integer $create_user
 * @property string $create_time
 * @property integer $index
 * @property string $icon
 * @property integer $is_local_icon
 */
class Rights extends RActiveRecord
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
        
        public function getDbConnection()
        {
                return self::getAdvertDbConnection();
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
			array('name, module_id, create_user, create_time, index, icon, is_local_icon', 'required'),
			array('module_id, create_user, index, is_local_icon', 'numerical', 'integerOnly'=>true),
			array('name', 'length', 'max'=>1000),
			array('icon', 'length', 'max'=>3000),
			// The following rule is used by search().
			// Please remove those attributes that should not be searched.
			array('id, name, module_id, create_user, create_time, index, icon, is_local_icon', 'safe', 'on'=>'search'),
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
			'module_id' => 'Module',
			'create_user' => 'Create User',
			'create_time' => 'Create Time',
			'index' => 'Index',
			'icon' => 'Icon',
			'is_local_icon' => 'Is Local Icon',
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
		$criteria->compare('module_id',$this->module_id);
		$criteria->compare('create_user',$this->create_user);
		$criteria->compare('create_time',$this->create_time,true);
		$criteria->compare('index',$this->index);
		$criteria->compare('icon',$this->icon,true);
		$criteria->compare('is_local_icon',$this->is_local_icon);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}
}