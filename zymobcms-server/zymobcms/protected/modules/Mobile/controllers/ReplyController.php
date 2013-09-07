<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of ReplyController
 *
 * @author barfoo
 */
class ReplyController extends Controller {
    //put your code here
    
    /*
     * 提交反馈信息
     * @param appId,userId,content
     */
    public function actionReply(){
        
        $appId=$_GET['appId'];
        $userId = $_GET['userId'];
        $content= $_GET['content'];
        
        if($appId==NULL  || $content==NULL){
            
             $resultArr = array('status'=>'0','msg'=>'参数缺失');
            
            echo json_encode($resultArr);
            
            return; 
        }
        
        if ($userId == NULL) {
        	$userId = 99999;
        }
        
        $dbOperation = new Class_DBOperation(DataBaseConfig::$dbhost,DataBaseConfig::$username,DataBaseConfig::$password,$appId,DataBaseConfig::$charset);
        $insertSql = "insert into zy_user_reply(custom_user_id,content)values($userId,'$content')";
        
        $insertResult = $dbOperation->saveBySql($insertSql);
        
        if($insertResult){
            
            $resultArr = array('status'=>'1','msg'=>'反馈成功');
            
            echo json_encode($resultArr);
            
        }else{
            
            $resultArr = array('status'=>'0','msg'=>'反馈失败');
            
            echo json_encode($resultArr);
            
        }
        
    }
}

?>
