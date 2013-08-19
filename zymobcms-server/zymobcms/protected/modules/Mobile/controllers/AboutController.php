<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of AboutController
 *
 * @author barfoo
 */
class AboutController extends Controller {
    //put your code here
    
    /*
     * 获取关于详情
     * @param appId
     */
    public function actionAboutInfo(){
        
        $appId = $_GET['appId'];
        
        if(!$appId){
            
            $resultArr = array('status'=>'0','msg'=>'参数缺失');
            
            echo json_encode($resultArr);
            
            return;
            
        }
        
        $dbOperation = new class_DBOperation(DataBaseConfig::$dbhost,DataBaseConfig::$username,DataBaseConfig::$password,$appId,DataBaseConfig::$charset);
        $sql = "select * from zy_about_us";
        
        $resultObj = $dbOperation->queryAllBySql($sql);
        
        if($resultObj){
            
            $resultArr = array('status'=>'1','data'=>$resultObj);
            
            echo json_encode($resultArr);
        }else{
            
            $resultArr = array('status'=>'0','msg'=>'查询失败');
            
            echo json_encode($resultArr);
        }
        
    }
}

?>
