<?php

/**
 * This is the model class for table "zy_picture".
 *
 * The followings are the available columns in table 'zy_picture':
 * @property integer $id
 * @property string $title
 * @property string $summary
 * @property string $images
 * @property string $create_time
 * @property integer $create_user
 * @property integer $status
 * @property string $links
 * @property integer $comment_count
 * @property integer $favorite_count
 * @property string $source
 * @property integer $industry_id
 * @property integer $main_category_id
 * @property integer $sub_tab_type_id
 * @property double $market_price
 * @property double $we_price
 * @property double $low_price
 * @property string $product_code
 * @property string $product_face_code
 * @property string $contact_mobile
 * @property string $product_combine
 * @property string $location
 * @property integer $has_now
 * @property string $product_sale_face
 * @property string $product_respority_code
 * @property integer $has_sale_count
 */
class Picture extends RActiveRecord
{
	/**
	 * Returns the static model of the specified AR class.
	 * @param string $className active record class name.
	 * @return Picture the static model class
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
		return 'zy_picture';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('title, summary, images, create_time, create_user, status, links, comment_count, favorite_count, source, industry_id, main_category_id, sub_tab_type_id, market_price, we_price, low_price, product_code, product_face_code, contact_mobile, product_combine, location, has_now, product_sale_face, product_respority_code, has_sale_count', 'required'),
			array('create_user, status, comment_count, favorite_count, industry_id, main_category_id, sub_tab_type_id, has_now, has_sale_count', 'numerical', 'integerOnly'=>true),
			array('market_price, we_price, low_price', 'numerical'),
			array('title', 'length', 'max'=>200),
			array('summary', 'length', 'max'=>8000),
			array('images', 'length', 'max'=>3000),
			array('links, source, product_code, product_face_code, contact_mobile, product_combine, location, product_sale_face, product_respority_code', 'length', 'max'=>2000),
			// The following rule is used by search().
			// Please remove those attributes that should not be searched.
			array('id, title, summary, images, create_time, create_user, status, links, comment_count, favorite_count, source, industry_id, main_category_id, sub_tab_type_id, market_price, we_price, low_price, product_code, product_face_code, contact_mobile, product_combine, location, has_now, product_sale_face, product_respority_code, has_sale_count', 'safe', 'on'=>'search'),
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
			'title' => 'Title',
			'summary' => 'Summary',
			'images' => 'Images',
			'create_time' => 'Create Time',
			'create_user' => 'Create User',
			'status' => 'Status',
			'links' => 'Links',
			'comment_count' => 'Comment Count',
			'favorite_count' => 'Favorite Count',
			'source' => 'Source',
			'industry_id' => 'Industry',
			'main_category_id' => 'Main Category',
			'sub_tab_type_id' => 'Sub Tab Type',
			'market_price' => 'Market Price',
			'we_price' => 'We Price',
			'low_price' => 'Low Price',
			'product_code' => 'Product Code',
			'product_face_code' => 'Product Face Code',
			'contact_mobile' => 'Contact Mobile',
			'product_combine' => 'Product Combine',
			'location' => 'Location',
			'has_now' => 'Has Now',
			'product_sale_face' => 'Product Sale Face',
			'product_respority_code' => 'Product Respority Code',
			'has_sale_count' => 'Has Sale Count',
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
		$criteria->compare('title',$this->title,true);
		$criteria->compare('summary',$this->summary,true);
		$criteria->compare('images',$this->images,true);
		$criteria->compare('create_time',$this->create_time,true);
		$criteria->compare('create_user',$this->create_user);
		$criteria->compare('status',$this->status);
		$criteria->compare('links',$this->links,true);
		$criteria->compare('comment_count',$this->comment_count);
		$criteria->compare('favorite_count',$this->favorite_count);
		$criteria->compare('source',$this->source,true);
		$criteria->compare('industry_id',$this->industry_id);
		$criteria->compare('main_category_id',$this->main_category_id);
		$criteria->compare('sub_tab_type_id',$this->sub_tab_type_id);
		$criteria->compare('market_price',$this->market_price);
		$criteria->compare('we_price',$this->we_price);
		$criteria->compare('low_price',$this->low_price);
		$criteria->compare('product_code',$this->product_code,true);
		$criteria->compare('product_face_code',$this->product_face_code,true);
		$criteria->compare('contact_mobile',$this->contact_mobile,true);
		$criteria->compare('product_combine',$this->product_combine,true);
		$criteria->compare('location',$this->location,true);
		$criteria->compare('has_now',$this->has_now);
		$criteria->compare('product_sale_face',$this->product_sale_face,true);
		$criteria->compare('product_respority_code',$this->product_respority_code,true);
		$criteria->compare('has_sale_count',$this->has_sale_count);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}
        
        public function getDbConnection()
        {
            return self::getAdvertDbConnection();
        }
}