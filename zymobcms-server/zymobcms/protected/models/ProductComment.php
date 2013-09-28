<?php

/**
 * This is the model class for table "zy_product_comment".
 *
 * The followings are the available columns in table 'zy_product_comment':
 * @property integer $comment_id
 * @property integer $product_id
 * @property string $content
 * @property string $create_time
 * @property integer $create_user
 * @property string $to_users
 * @property integer $status
 * @property integer $support_count
 * @property integer $unsupport_count
 * @property string $title
 */
class ProductComment extends RActiveRecord
{
	/**
	 * Returns the static model of the specified AR class.
	 * @param string $className active record class name.
	 * @return ProductComment the static model class
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
		return 'zy_product_comment';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('product_id, content, create_time, create_user, to_users, status, support_count, unsupport_count, title', 'required'),
			array('product_id, create_user, status, support_count, unsupport_count', 'numerical', 'integerOnly'=>true),
			array('content, to_users', 'length', 'max'=>500),
			array('title', 'length', 'max'=>3000),
			// The following rule is used by search().
			// Please remove those attributes that should not be searched.
			array('comment_id, product_id, content, create_time, create_user, to_users, status, support_count, unsupport_count, title', 'safe', 'on'=>'search'),
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
			'comment_id' => 'Comment',
			'product_id' => 'Product',
			'content' => 'Content',
			'create_time' => 'Create Time',
			'create_user' => 'Create User',
			'to_users' => 'To Users',
			'status' => 'Status',
			'support_count' => 'Support Count',
			'unsupport_count' => 'Unsupport Count',
			'title' => 'Title',
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

		$criteria->compare('comment_id',$this->comment_id);
		$criteria->compare('product_id',$this->product_id);
		$criteria->compare('content',$this->content,true);
		$criteria->compare('create_time',$this->create_time,true);
		$criteria->compare('create_user',$this->create_user);
		$criteria->compare('to_users',$this->to_users,true);
		$criteria->compare('status',$this->status);
		$criteria->compare('support_count',$this->support_count);
		$criteria->compare('unsupport_count',$this->unsupport_count);
		$criteria->compare('title',$this->title,true);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}
}