<?php

use Wrep\Notificato\Notificato;
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
    private $_sandbox = 'gateway.sandbox.push.apple.com';
    private $_port = 2195;
    private $_public = 'gateway.push.apple.com';
    private $_environment = 0;

    public function __construct($appId,$pemPath,$environment){
        $this->_appId = $appId;
        $this->_pemPath = $pemPath;
        $this->_environment = $environment;
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

    public function pushMessageForIOSDevicesByUserId($title,$bageCount,$data,$param,$isUserId,$isAll){
       
     if($isAll){
         $devices = $this->foundAllIOSDevices();
     }else if($isUserId){
         $devices = $this->foundIOSRightTokeWithUserId($param);
     }else {
         $devices = $this->foundIOSRightTokeWithLoginName($param);
     }
     
//      print_r($devices);
          
      
     
     $apnsHost = $this->_environment? $this->_public:$this->_sandbox;
     $apnsCert = $this->_pemPath;
     $apnsPort = $this->_port;
     
     $payload['aps']=array(
     		'alert'=>$title,
     		'badge'=>$bageCount,
     		'sound'=>'default');
     $payload = json_encode($payload);
     print_r($payload);
     
     $streamContext = stream_context_create();
     stream_context_set_option($streamContext, 'ssl', 'local_cert', $apnsCert);
     $apns = stream_socket_client('ssl://' . $apnsHost . ':' . $apnsPort, $error, $errorString, 2, STREAM_CLIENT_CONNECT, $streamContext);
    
     if (!$apns) {
     	print "Failed to connect $error";
     
     	return;
     }
     
     print "Connection OK ";
     
   if(is_object($devices)){    

        $apnsMessage = chr(0) . chr(0) . chr(32) . pack('H*', str_replace(' ', '',$devices->token)) . chr(0) . chr(strlen($payload)) . $payload;
        fwrite($apns, $apnsMessage);
       
       echo 'sending to one .....';
           
   }else if(is_array($devices)){
       for($i=0;$i<count($devices);$i++){
       	       	                
        $cDevice = $devices[$i];
        $apnsMessage = chr(0) . chr(0) . chr(32) . pack('H*', str_replace(' ', '',$cDevice->token)) . chr(0) . chr(strlen($payload)) . $payload;
        fwrite($apns, $apnsMessage);
        
      }       
       echo 'sending..... to all.....';        
   }
   print_r($error);
   print_r($errorString);
   
   socket_close($apns);
   fclose($apns);
   
   }
   
    private function pushMessageForAndroidDevices($data,$title){
        
        
    }
    
    public function pushMessageNow($message,$title){
        
        
    }
}

?>
