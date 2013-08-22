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


    private function pushMessageForIOSDevices($data,$title){
       
    //查询所有iOS设备
    $dbOperation = new class_DBOperation(DataBaseConfig::$dbhost,DataBaseConfig::$username,DataBaseConfig::$password,$this->_appId,DataBaseConfig::$charset);
    $querySql = "select token from zy_device where type_id = 1";
    $devices = $dbOperation->queryAllBySql($querySql);
    
        
    // Adjust to your timezone
    date_default_timezone_set('Europe/Rome');

    // Report all PHP errors
    error_reporting(-1);

   // Using Autoload all classes are loaded on-demand
   require_once 'ApnsPHP/Autoload.php';

   // Instanciate a new ApnsPHP_Push object
   $push = new ApnsPHP_Push(
	 ApnsPHP_Abstract::ENVIRONMENT_SANDBOX,
	'server_certificates_bundle_sandbox.pem'
   );

   // Set the Root Certificate Autority to verify the Apple remote peer
   $push->setRootCertificationAuthority('entrust_root_certification_authority.pem');

   // Increase write interval to 100ms (default value is 10ms).
   // This is an example value, the 10ms default value is OK in most cases.
   // To speed up the sending operations, use Zero as parameter but
   // some messages may be lost.
   // $push->setWriteInterval(100 * 1000);

   // Connect to the Apple Push Notification Service
   $push->connect();

   for($j=10;$j<count($devices);$j++){
               
             $message = new ApnsPHP_Message($devices[$j]->token);

            // Set a custom identifier. To get back this identifier use the getCustomIdentifier() method
            // over a ApnsPHP_Message object retrieved with the getErrors() message.
            $message->setCustomIdentifier(sprintf("Message-Badge-%03d", count($data)));

            // Set badge icon to "3"
            $message->setBadge(count($data));
            
            $message->setCustomProperty('data',$data);

            // Add the message to the message queue
            $push->add($message);
   }
   // Send all messages in the message queue
   $push->send();

   // Disconnect from the Apple Push Notification Service
   $push->disconnect();

   // Examine the error message container
   $aErrorQueue = $push->getErrors();
   if (!empty($aErrorQueue)) {
	  var_dump($aErrorQueue);
      }  
   }
   
    
    private function pushMessageForAndroidDevices($data,$title){
        
        
    }
    
    public function pushMessageNow($message,$title){
        
        
        
    }
}

?>
