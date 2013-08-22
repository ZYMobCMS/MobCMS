<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of PushNotiManager
 *
 * @author barfoo
 */
class PushNotiManager {
    //put your code here
    private $_appId = '';//需要用的时候修改
    private $_pemPath = '';
    private $_apns;

    public function __construct($appId,$pemPath){
        $this->_appId = $appId;
        $this->_pemPath = $pemPath;
        
        $rootpath = 'entrust_root_certification_authority.pem';  //ROOT证书地址
        $apns = new APNS(APNS::ENVIRONMENT_SANDBOX,$this->_pemPath);
        $this->_apns = $apns;
//        var_dump($this->_apns);
        try
        {
//            $apns->setRCA($this->_pemPath);  //设置ROOT证书
            $this->_apns->connect(); //连接
        }catch(Exception $e)
        {
         echo $e;
        }
    
    }

    private function foundIOSRightTokeWithUserId($userId){
        
        //查询所有iOS设备
        $dbOperation = new class_DBOperation(DataBaseConfig::$dbhost,DataBaseConfig::$username,DataBaseConfig::$password,$this->_appId,DataBaseConfig::$charset);
        $querySql = "select token from zy_device where type_id = 1 and user_id = $userId";
        $devices = $dbOperation->queryBySql($querySql);
        
        return $devices;
    }
    
    private function foundIOSRightTokeWithLoginName($loginName){
        
        //查询所有iOS设备
        $dbOperation = new class_DBOperation(DataBaseConfig::$dbhost,DataBaseConfig::$username,DataBaseConfig::$password,$this->_appId,DataBaseConfig::$charset);
        $querySql = "select token from zy_device where type_id = 1 and login_name = $loginName";
        $devices = $dbOperation->queryBySql($querySql);
        
        return $devices;
    }
    
    private function foundAllIOSDevices(){
        
        //查询所有iOS设备
        $dbOperation = new class_DBOperation(DataBaseConfig::$dbhost,DataBaseConfig::$username,DataBaseConfig::$password,$this->_appId,DataBaseConfig::$charset);
        $querySql = "select token from zy_device where type_id = 1";
        $devices = $dbOperation->queryAllBySql($querySql);
        
        return $devices;
    }

    public function pushMessageForIOSDevicesByUserId($title,$data,$param,$isUserId,$isAll){
       
     if($isAll){
         $devices = $this->foundAllIOSDevices();
     }else if($isUserId){
         $devices = $this->foundIOSRightTokeWithUserId($param);
     }else {
         $devices = $this->foundIOSRightTokeWithLoginName($param);
     }
     
   if(is_object($devices)){    

       $this->_apns->addDT($devices->token);  //加入deviceToken
       $this->_apns->setText($title);  //发送内容
       $this->_apns->setBadge(1);  //设置图标数
       $this->_apns->setSound();  //设置声音
       $this->_apns->setExpiry(3600);  //过期时间
       $this->_apns->setCP(json_encode($data));  //自定义操作
       $this->_apns->send();  //发送
           
   }else if(is_array($devices)){
       for($i=0;$i<count($devices);$i++){

       $this->_apns->addDT($devices[$i]['token']);  //加入deviceToken
       $this->_apns->setText($title);  //发送内容
       $this->_apns->setBadge(1);  //设置图标数
       $this->_apns->setSound();  //设置声音
       $this->_apns->setExpiry(3600);  //过期时间
       $this->_apns->setCP(json_encode($data));  //自定义操作
       $this->_apns->send();  //发送           
       }
   }
   
   // Disconnect from the Apple Push Notification Service
   $this->_apns->disconnect();
   
   }
   
    private function pushMessageForAndroidDevices($data,$title){
        
        
    }
    
    public function pushMessageNow($message,$title){
        
        
    }
}

?>
