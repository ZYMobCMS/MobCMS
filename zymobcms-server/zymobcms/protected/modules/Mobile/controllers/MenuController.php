<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of MenuController
 *
 * @author barfoo
 */
class MenuController extends Controller {
    //put your code here
    
    /*
     * 获取程序所有功能模块
     * @param appId
     */
    public function  actionCategoryList(){
        
        $appId = $_GET['appId'];
        
        if(!$appId){
            
            $resultArr = array('status'=>'0','msg'=>'参数缺失');
            
            echo json_encode($resultArr);
            
            return;
        }
        
        //查询
        $dbOperation = new class_DBOperation(DataBaseConfig::$dbhost,DataBaseConfig::$username,DataBaseConfig::$password,$appId,DataBaseConfig::$charset);
        
        $sql = "select * from zy_category";
        
        $resultArr = $dbOperation->queryAllBySql($sql);
        
        $jsonArr = array('status'=>'1','data'=>$resultArr);
        
        echo json_encode($jsonArr);
    }
    
    /*
     * 获取某个大类下面得tabType
     * @param appId , categoryId
     */
    public function actionCategoryTabType(){
        
        $appId = $_GET['appId'];
        $categoryId = $_GET['categoryId'];
        
        if(!$categoryId || !$appId){
            
            $resultArr = array('status'=>'0','msg'=>'参数缺失');
            
            echo json_encode($resultArr);
            
            return;
        }
        
        //查询
        $dbOperation = new class_DBOperation(DataBaseConfig::$dbhost,DataBaseConfig::$username,DataBaseConfig::$password,$appId,DataBaseConfig::$charset);
        
        $sql = "select zy_category_rights.*,zy_tab_type.name from zy_category_rights inner join zy_tab_type on zy_category_rights.tab_type_id=zy_tab_type.id where category_id = $categoryId";
        
        $resultArr = $dbOperation->queryAllBySql($sql);
        
        $jsonArr = array('status'=>'1','data'=>$resultArr);
        
        echo json_encode($jsonArr);
        
    }
    
}

?>
