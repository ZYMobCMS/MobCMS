<?php

/**
 * UserIdentity represents the data needed to identity a user.
 * It contains the authentication method that checks if the provided
 * data can identity the user.
 */
class UserIdentity extends CUserIdentity
{
	/**
	 * Authenticates a user.
	 * The example implementation makes sure if the username and password
	 * are both 'demo'.
	 * In practical applications, this should be changed to authenticate
	 * against some persistent user identity storage (e.g. database).
	 * @return boolean whether authentication succeeds.
	 */
	public function authenticate()
	{       
		if(!isset($this->username))
                {
                   $this->errorCode=self::ERROR_USERNAME_INVALID;
                   
                }else if(!isset($this->password)) {
                   $this->errorCode=self::ERROR_PASSWORD_INVALID;

                }else{
                   $adminCheck = Admin::model()->findByAttributes(array('login_name'=>  $this->username));
                   
                   if(!$adminCheck){
                       
                       $this->errorCode=self::ERROR_USERNAME_INVALID;

                   }else{
                       
                       if($this->password != $adminCheck->password){
                         $this->errorCode=self::ERROR_PASSWORD_INVALID;

                       }else{
                         
                         //作为安全信息保存在session里面
                         $this->setState('db_name', $adminCheck->db_name);
                         $this->setState('login_name',$adminCheck->login_name);
                         $this->setState('id',$adminCheck->id);
                         $this->errorCode=self::ERROR_NONE;
 
                       }
                   }
                   
                }
		
		return !$this->errorCode;
	}
}