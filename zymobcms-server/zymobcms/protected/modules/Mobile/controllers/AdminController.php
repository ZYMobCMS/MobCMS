<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of AdminController
 *
 * @author barfoo
 */
class AdminController extends Controller {
    //put your code here
            
    /*
     * 管理员登陆
     */
    public function actionLogin(){
        
        $loginName = $_GET['loginName'];
        $appId = $_GET['appId'];
        $password = $_GET['password'];
        
        if($loginName==NULL||$password==NULL||$appId==NULL){
            
            $resultArr = array('status'=>'0','msg'=>'参数缺失');
            
            echo json_encode($resultArr);
            
            return;
        }
        
        //查询
        $dbOperation = new class_DBOperation(DataBaseConfig::$dbhost,DataBaseConfig::$username,DataBaseConfig::$password,$appId,DataBaseConfig::$charset);
        
        $checkSql = "select * from zy_admin where login_name='$loginName'";
        
        $resultObj = $dbOperation->queryBySql($checkSql);
        
        if(!$resultObj){
            
            $resultArr = array('status'=>'0','msg'=>'用户不存在');
            
            echo json_encode($resultArr);
            
            return;
        }
        
        if($resultObj->password!=$password){
            $resultArr = array('status'=>'0','msg'=>'密码错误');
            
            echo json_encode($resultArr);
            
            return;
        }else{
            
            $resultArr = array('status'=>'1','data'=>$resultObj);
            
            echo json_encode($resultArr);
            
            return;
        }
        
        
       
    }
    /*
     * 管理员发送推送消息
     */
    public function actionPushNotificationForIOSUser(){
        
        $msgContent= $_GET['msgContent'];
        $msgType = $_GET['msgType'];//新闻，图片，产品
        $msgDestId = $_GET['msgId'];//实际Id
        $msgTitle = $_GET['title'];
        $appId = $_GET['appId'];
        $adminLoginName = $_GET['adminLoginName'];
        $destUserId = $_GET['destUserId'];
        $destLoginName = $_GET['destLoginName'];
        
        if($appId==NULL){
            $resultArr = array('status'=>'0','msg'=>'参数缺失');
            
            echo json_encode($resultArr);
            
            return;
        }
        
//        //查询pem存放位置
//        $dbOperation = new class_DBOperation(DataBaseConfig::$dbhost,DataBaseConfig::$username,DataBaseConfig::$password,$appId,DataBaseConfig::$charset);
//        $checkSql = "select pem_path from zy_application_owner";
//        
//        $pemObj = $dbOperation->queryBySql($checkSql);
//        
//        if($pemObj==NULL){
//            $resultArr = array('status'=>'0','msg'=>'没有推送功能');
//            
//            echo json_encode($resultArr);
//            
//            return;
//        }
        
        //新建推送
//        print_r($pemPath);
        $pemPath = Yii::app()->basePath.'/uitil/apns-dev.pem';
        $pushManager = new PushNotiManager($appId,$pemPath);
        
//        print_r($pushManager);
        
        $newMsg = new PushMessage();
        
        var_dump($newMsg);
        
        $newMsg->title = $msgTitle;
        $newMsg->content=$msgContent;
        $newMsg->typeId = $msgType;
        $newMsg->id = $msgDestId;
        $newMsg->send_admin = $adminLoginName;
            
//        print_r($newMsg);
        
        if($destUserId==NULL && $destLoginName==NULL){
            
            $pushManager->pushMessageForIOSDevicesByUserId($newMsg->title,$newMsg, NULL, FALSE, TRUE);
            
        }else if($destUserId&&$destLoginName==NULL){
            
            $pushManager->pushMessageForIOSDevicesByUserId($newMsg->title,$newMsg,$destUserId, TRUE,FALSE);
        }else if($destLoginName&&$destUserId==NULL){
            
            echo 'push noti by login name !!!';

            $pushManager->pushMessageForIOSDevicesByUserId($newMsg->title,$newMsg,$destLoginName,FALSE,FALSE);
            
            
        }else if($destLoginName != NULL && $destUserId!=NULL){
             
            $pushManager->pushMessageForIOSDevicesByUserId($newMsg->title,$newMsg,$destUserId,TRUE,FALSE);
        }
        
        
    }
}

?>
