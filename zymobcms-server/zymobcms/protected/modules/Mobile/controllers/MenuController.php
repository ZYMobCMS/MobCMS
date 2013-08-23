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
     * 程序所有功能模块以及顺序
     * @param $appId
     */
    public function actionMenuList(){
        
        $appId = $_GET['appId'];
        
        if($appId==NULL){
            $resultArr = array('status'=>'0','msg'=>'参数缺失');
            
            echo json_encode($resultArr);
            
            return;
        }
        
        //查询
        $dbOperation = new class_DBOperation(DataBaseConfig::$dbhost,DataBaseConfig::$username,DataBaseConfig::$password,$appId,DataBaseConfig::$charset);
         
        $sql = "select * from zy_rights order by module_id";
      
        $resultArr = $dbOperation->queryAllBySql($sql);
        
        $jsonArr = array('status'=>'1','data'=>$resultArr);
        
        echo json_encode($jsonArr);
        
    }


    /*
     * 获取程序所有功能模块
     * @param appId
     */
    public function  actionCategoryList(){
        
        $appId = $_GET['appId'];
        
        if($appId==NULL){
            
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
        
        if($categoryId==NULL || $appId==NULL){
            
            $resultArr = array('status'=>'0','msg'=>'参数缺失');
            
            echo json_encode($resultArr);
            
            return;
        }
        
        //是否有缓存
        $cacheManager = new CacheManager($appId);
        $isCached = $cacheManager->isNewsListTabTypesCachedExist($categoryId);
        if($isCached){
        
        	$resultArr = $cacheManager->returnNewsListTabTypes($categoryId);
        
        	echo $resultArr;
        
        	return ;
        }
        
        //查询
        $dbOperation = new class_DBOperation(DataBaseConfig::$dbhost,DataBaseConfig::$username,DataBaseConfig::$password,$appId,DataBaseConfig::$charset);
        
        $sql = "select * from zy_tab_type where category_id = $categoryId";
        
        $resultArr = $dbOperation->queryAllBySql($sql);
        
        $jsonArr = array('status'=>'1','data'=>$resultArr);
        
        //缓存
        $cacheManager->cacheNewsListTabTypes($categoryId,$jsonArr);
        
        echo json_encode($jsonArr);
        
    }
    
    /*
     * 获取应用程序名字
     */
    public function actionApplicationName(){
    	
    	$appId = $_GET['appId'];
    	 
    	if($appId==NULL){
    	
    		$resultArr = array('status'=>'0','msg'=>'参数缺失');
    	
    		echo json_encode($resultArr);
    	
    		return;
    	}
    	
    	$dbOperation = new class_DBOperation(DataBaseConfig::$dbhost,DataBaseConfig::$username,DataBaseConfig::$password,$appId,DataBaseConfig::$charset);
    	
    	$sql = "select * from zy_application_owner";
    	
    	$resultArr = $dbOperation->queryAllBySql($sql);
    	
    	$jsonArr = array('status'=>'1','data'=>$resultArr[0]);
    	
    	echo json_encode($jsonArr);
    }
    
}

?>
