<?php

/**
 * This is the model class for table "zy_user_active".
 *
 * The followings are the available columns in table 'zy_user_active':
 * @property integer $id
 * @property integer $relation_id
 * @property string $relation_table
 * @property string $content
 * @property string $create_time
 * @property integer $status
 * @property integer $create_user
 * @property integer $active_type_id
 * @property string $relation_images
 * @property integer $refer_user
 * @property string $create_login_name
 * @property string $create_nick_name
 * @property string $relation_title
 */
class UserActive extends RActiveRecord
{
	/**
	 * Returns the static model of the specified AR class.
	 * @param string $className active record class name.
	 * @return UserActive the static model class
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
		return 'zy_user_active';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('relation_id, relation_table, content, create_time, status, create_user, active_type_id, relation_images, refer_user, create_login_name, create_nick_name, relation_title', 'required'),
			array('relation_id, status, create_user, active_type_id, refer_user', 'numerical', 'integerOnly'=>true),
			array('relation_table', 'length', 'max'=>2000),
			array('content, relation_images, create_login_name, create_nick_name, relation_title', 'length', 'max'=>3000),
			// The following rule is used by search().
			// Please remove those attributes that should not be searched.
			array('id, relation_id, relation_table, content, create_time, status, create_user, active_type_id, relation_images, refer_user, create_login_name, create_nick_name, relation_title', 'safe', 'on'=>'search'),
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
			'relation_id' => 'Relation',
			'relation_table' => 'Relation Table',
			'content' => 'Content',
			'create_time' => 'Create Time',
			'status' => 'Status',
			'create_user' => 'Create User',
			'active_type_id' => 'Active Type',
			'relation_images' => 'Relation Images',
			'refer_user' => 'Refer User',
			'create_login_name' => 'Create Login Name',
			'create_nick_name' => 'Create Nick Name',
			'relation_title' => 'Relation Title',
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
		$criteria->compare('relation_id',$this->relation_id);
		$criteria->compare('relation_table',$this->relation_table,true);
		$criteria->compare('content',$this->content,true);
		$criteria->compare('create_time',$this->create_time,true);
		$criteria->compare('status',$this->status);
		$criteria->compare('create_user',$this->create_user);
		$criteria->compare('active_type_id',$this->active_type_id);
		$criteria->compare('relation_images',$this->relation_images,true);
		$criteria->compare('refer_user',$this->refer_user);
		$criteria->compare('create_login_name',$this->create_login_name,true);
		$criteria->compare('create_nick_name',$this->create_nick_name,true);
		$criteria->compare('relation_title',$this->relation_title,true);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}
}