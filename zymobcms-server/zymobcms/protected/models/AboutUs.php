<?php

/**
 * This is the model class for table "zy_about_us".
 *
 * The followings are the available columns in table 'zy_about_us':
 * @property integer $id
 * @property string $content
 * @property string $phone
 * @property string $website
 * @property string $email
 * @property string $qq
 * @property string $msn
 * @property string $home_phone
 * @property string $copy_right
 * @property string $company_name
 * @property string $blog_host
 * @property string $contact_who
 * @property integer $status
 * @property string $product_name
 * @property string $logo_image
 * @property string $update_time
 */
class AboutUs extends CActiveRecord
{
	/**
	 * Returns the static model of the specified AR class.
	 * @param string $className active record class name.
	 * @return AboutUs the static model class
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
		return 'zy_about_us';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('content, phone, website, email, qq, msn, home_phone, copy_right, company_name, blog_host, contact_who, status, product_name, logo_image, update_time', 'required'),
			array('status', 'numerical', 'integerOnly'=>true),
			array('content', 'length', 'max'=>3000),
			array('phone, website', 'length', 'max'=>300),
			array('email, blog_host, contact_who, product_name', 'length', 'max'=>500),
			array('qq, msn, home_phone, copy_right', 'length', 'max'=>100),
			array('company_name, logo_image', 'length', 'max'=>1000),
			// The following rule is used by search().
			// Please remove those attributes that should not be searched.
			array('id, content, phone, website, email, qq, msn, home_phone, copy_right, company_name, blog_host, contact_who, status, product_name, logo_image, update_time', 'safe', 'on'=>'search'),
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
			'content' => 'Content',
			'phone' => 'Phone',
			'website' => 'Website',
			'email' => 'Email',
			'qq' => 'Qq',
			'msn' => 'Msn',
			'home_phone' => 'Home Phone',
			'copy_right' => 'Copy Right',
			'company_name' => 'Company Name',
			'blog_host' => 'Blog Host',
			'contact_who' => 'Contact Who',
			'status' => 'Status',
			'product_name' => 'Product Name',
			'logo_image' => 'Logo Image',
			'update_time' => 'Update Time',
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
		$criteria->compare('content',$this->content,true);
		$criteria->compare('phone',$this->phone,true);
		$criteria->compare('website',$this->website,true);
		$criteria->compare('email',$this->email,true);
		$criteria->compare('qq',$this->qq,true);
		$criteria->compare('msn',$this->msn,true);
		$criteria->compare('home_phone',$this->home_phone,true);
		$criteria->compare('copy_right',$this->copy_right,true);
		$criteria->compare('company_name',$this->company_name,true);
		$criteria->compare('blog_host',$this->blog_host,true);
		$criteria->compare('contact_who',$this->contact_who,true);
		$criteria->compare('status',$this->status);
		$criteria->compare('product_name',$this->product_name,true);
		$criteria->compare('logo_image',$this->logo_image,true);
		$criteria->compare('update_time',$this->update_time,true);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}
}