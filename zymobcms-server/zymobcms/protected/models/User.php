<?php

/**
 * This is the model class for table "zy_user".
 *
 * The followings are the available columns in table 'zy_user':
 * @property integer $id
 * @property string $login_name
 * @property string $password
 * @property string $nick_name
 * @property string $rigist_time
 * @property integer $status
 * @property integer $user_type_id
 * @property string $msn
 * @property string $qq
 * @property string $email
 * @property string $phone
 * @property string $mobile
 * @property string $profile
 * @property integer $sex
 * @property string $location
 * @property string $token
 */
class User extends CActiveRecord
{
	/**
	 * Returns the static model of the specified AR class.
	 * @param string $className active record class name.
	 * @return User the static model class
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
		return 'zy_user';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('login_name, password', 'required'),
			array('status, user_type_id, sex', 'numerical', 'integerOnly'=>true),
			array('login_name', 'length', 'max'=>50),
			array('password', 'length', 'max'=>2000),
			array('msn, qq, email, phone, mobile', 'length', 'max'=>100),
			array('profile', 'length', 'max'=>500),
			array('location', 'length', 'max'=>300),
			array('token', 'length', 'max'=>5000),
			array('nick_name, rigist_time, status, user_type_id, msn, qq, email, phone, mobile, profile, sex, location, token','safe'),
			// The following rule is used by search().
			// Please remove those attributes that should not be searched.
			array('id, login_name, password, nick_name, rigist_time, status, user_type_id, msn, qq, email, phone, mobile, profile, sex, location, token', 'safe', 'on'=>'search'),
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
			'login_name' => 'Login Name',
			'password' => 'Password',
			'nick_name' => 'Nick Name',
			'rigist_time' => 'Rigist Time',
			'status' => 'Status',
			'user_type_id' => 'User Type',
			'msn' => 'Msn',
			'qq' => 'Qq',
			'email' => 'Email',
			'phone' => 'Phone',
			'mobile' => 'Mobile',
			'profile' => 'Profile',
			'sex' => 'Sex',
			'location' => 'Location',
			'token' => 'Token',
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
		$criteria->compare('login_name',$this->login_name,true);
		$criteria->compare('password',$this->password,true);
		$criteria->compare('nick_name',$this->nick_name,true);
		$criteria->compare('rigist_time',$this->rigist_time,true);
		$criteria->compare('status',$this->status);
		$criteria->compare('user_type_id',$this->user_type_id);
		$criteria->compare('msn',$this->msn,true);
		$criteria->compare('qq',$this->qq,true);
		$criteria->compare('email',$this->email,true);
		$criteria->compare('phone',$this->phone,true);
		$criteria->compare('mobile',$this->mobile,true);
		$criteria->compare('profile',$this->profile,true);
		$criteria->compare('sex',$this->sex);
		$criteria->compare('location',$this->location,true);
		$criteria->compare('token',$this->token,true);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}
	
	/**
	 * MD5
	 * 
	 */
	public function enypt($aString){
		return md5($aString);
	}
	
	/*
	 * 验证密码
	 */
	public function validatePassword($password){
		
		if($this->password == $this->enypt($password)){
			return true;
		}else{
			return false;
		}
	}
	
	/*
	 * 保存注册信息
	 */
	protected function beforeSave(){
		
		if (parent::beforeSave()) {
			
			if ($this->isNewRecord) {
				
				$this->password = $this->enypt($this->password);
				$this->rigist_time = date('y:m:d h:i:s');
				
			}
			
			return true;
		}else{
			return false;
		}
	}
}