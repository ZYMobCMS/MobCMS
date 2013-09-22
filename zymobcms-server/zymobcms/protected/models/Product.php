<?php

/**
 * This is the model class for table "zy_product".
 *
 * The followings are the available columns in table 'zy_product':
 * @property integer $id
 * @property string $title
 * @property string $summary
 * @property string $content
 * @property double $price
 * @property string $images
 * @property string $create_time
 * @property string $update_time
 * @property integer $status
 * @property integer $create_user
 * @property integer $has_now
 * @property integer $support_count
 * @property string $links
 * @property string $contact_email
 * @property string $contact_name
 * @property string $contact_phone
 * @property string $contact_qq
 * @property integer $type_id
 * @property integer $comment_count
 * @property integer $favorite_count
 * @property string $source
 * @property integer $has_selled_count
 * @property double $admin_price
 * @property string $product_code
 * @property double $product_weight
 * @property string $product_respority_code
 * @property string $product_sale_face
 * @property string $contact_wangwang
 * @property double $market_price
 * @property double $we_price
 * @property integer $industry_id
 * @property string $contact_mobile
 * @property string $contact_url
 * @property integer $main_category_id
 * @property integer $sub_tab_type_id
 */
class Product extends RActiveRecord
{
	/**
	 * Returns the static model of the specified AR class.
	 * @param string $className active record class name.
	 * @return Product the static model class
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
		return 'zy_product';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('title, summary, content, price, images, create_time, update_time, status, create_user, has_now, support_count, links, contact_email, contact_name, contact_phone, contact_qq, type_id, comment_count, favorite_count, source, has_selled_count, admin_price, product_code, product_weight, product_respority_code, product_sale_face, contact_wangwang, market_price, we_price, industry_id, contact_mobile, contact_url, main_category_id, sub_tab_type_id', 'required'),
			array('status, create_user, has_now, support_count, type_id, comment_count, favorite_count, has_selled_count, industry_id, main_category_id, sub_tab_type_id', 'numerical', 'integerOnly'=>true),
			array('price, admin_price, product_weight, market_price, we_price', 'numerical'),
			array('title, content', 'length', 'max'=>1000),
			array('summary', 'length', 'max'=>500),
			array('images, product_code', 'length', 'max'=>3000),
			array('links, contact_email, contact_name, contact_phone, contact_qq, source, product_respority_code, product_sale_face, contact_wangwang, contact_mobile, contact_url', 'length', 'max'=>2000),
			// The following rule is used by search().
			// Please remove those attributes that should not be searched.
			array('id, title, summary, content, price, images, create_time, update_time, status, create_user, has_now, support_count, links, contact_email, contact_name, contact_phone, contact_qq, type_id, comment_count, favorite_count, source, has_selled_count, admin_price, product_code, product_weight, product_respority_code, product_sale_face, contact_wangwang, market_price, we_price, industry_id, contact_mobile, contact_url, main_category_id, sub_tab_type_id', 'safe', 'on'=>'search'),
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
			'content' => 'Content',
			'price' => 'Price',
			'images' => 'Images',
			'create_time' => 'Create Time',
			'update_time' => 'Update Time',
			'status' => 'Status',
			'create_user' => 'Create User',
			'has_now' => 'Has Now',
			'support_count' => 'Support Count',
			'links' => 'Links',
			'contact_email' => 'Contact Email',
			'contact_name' => 'Contact Name',
			'contact_phone' => 'Contact Phone',
			'contact_qq' => 'Contact Qq',
			'type_id' => 'Type',
			'comment_count' => 'Comment Count',
			'favorite_count' => 'Favorite Count',
			'source' => 'Source',
			'has_selled_count' => 'Has Selled Count',
			'admin_price' => 'Admin Price',
			'product_code' => 'Product Code',
			'product_weight' => 'Product Weight',
			'product_respority_code' => 'Product Respority Code',
			'product_sale_face' => 'Product Sale Face',
			'contact_wangwang' => 'Contact Wangwang',
			'market_price' => 'Market Price',
			'we_price' => 'We Price',
			'industry_id' => 'Industry',
			'contact_mobile' => 'Contact Mobile',
			'contact_url' => 'Contact Url',
			'main_category_id' => 'Main Category',
			'sub_tab_type_id' => 'Sub Tab Type',
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
		$criteria->compare('content',$this->content,true);
		$criteria->compare('price',$this->price);
		$criteria->compare('images',$this->images,true);
		$criteria->compare('create_time',$this->create_time,true);
		$criteria->compare('update_time',$this->update_time,true);
		$criteria->compare('status',$this->status);
		$criteria->compare('create_user',$this->create_user);
		$criteria->compare('has_now',$this->has_now);
		$criteria->compare('support_count',$this->support_count);
		$criteria->compare('links',$this->links,true);
		$criteria->compare('contact_email',$this->contact_email,true);
		$criteria->compare('contact_name',$this->contact_name,true);
		$criteria->compare('contact_phone',$this->contact_phone,true);
		$criteria->compare('contact_qq',$this->contact_qq,true);
		$criteria->compare('type_id',$this->type_id);
		$criteria->compare('comment_count',$this->comment_count);
		$criteria->compare('favorite_count',$this->favorite_count);
		$criteria->compare('source',$this->source,true);
		$criteria->compare('has_selled_count',$this->has_selled_count);
		$criteria->compare('admin_price',$this->admin_price);
		$criteria->compare('product_code',$this->product_code,true);
		$criteria->compare('product_weight',$this->product_weight);
		$criteria->compare('product_respority_code',$this->product_respority_code,true);
		$criteria->compare('product_sale_face',$this->product_sale_face,true);
		$criteria->compare('contact_wangwang',$this->contact_wangwang,true);
		$criteria->compare('market_price',$this->market_price);
		$criteria->compare('we_price',$this->we_price);
		$criteria->compare('industry_id',$this->industry_id);
		$criteria->compare('contact_mobile',$this->contact_mobile,true);
		$criteria->compare('contact_url',$this->contact_url,true);
		$criteria->compare('main_category_id',$this->main_category_id);
		$criteria->compare('sub_tab_type_id',$this->sub_tab_type_id);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}
        
        public function getDbConnection()
        {
            return self::getAdvertDbConnection();
        }
}