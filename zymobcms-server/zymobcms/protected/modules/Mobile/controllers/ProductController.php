<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of ProductController
 *
 * @author barfoo
 */
class ProductController extends Controller{
    //put your code here
    
    /*
     * 获取产品列表
     * @param productId,pageIndex,pageSize
     */
    public function actionProductList(){
        
        $appId = $_GET['appId'];
        $pageIndex = $_GET['pageIndex'];
        $pageSize = $_GET['pageSize'];
        
        if(!$appId){
            
            $resultArr = array('status'=>'0','msg'=>'参数缺失');
            
            echo json_encode($resultArr);
            
            return; 
            
        }
        
        if($pageIndex<0){
                $resultArr = array('status'=>'0','msg'=>'参数非法');
            
                echo json_encode($resultArr);
            
                return;
                
        }
        
        if($pageSize>10 || $pageSize<0){
                 $pageSize = 10;
        }
        
        //查询
        $dbOperation = new class_DBOperation(DataBaseConfig::$dbhost,DataBaseConfig::$username,DataBaseConfig::$password,$appId,DataBaseConfig::$charset);
        $truePageIndex = ($pageIndex-1)>=0? $pageIndex-1:$pageIndex;
        $startIndex = $truePageIndex*$pageSize;
        $sql = "select id,name,summary,support_count,images from zy_product limit $startIndex,$pageSize";
        
        $resultArr = $dbOperation->queryAllBySql($sql);
        
        $jsonArr = array('status'=>'1','data'=>$resultArr);
        
        echo json_encode($jsonArr);
        
    }
    
    /*
     * 获取产品详情
     * @param productId,appId
     */
    public function actionProductDetail(){
        
        
        $productId = $_GET['productId'];
        $appId = $_GET['appId'];
        
        if(!$productId || !$appId){
            
            $resultArr = array('status'=>'0','msg'=>'参数缺失');
            
            echo json_encode($resultArr);
            
            return;
        }
        
        //查询
        $dbOperation = new class_DBOperation(DataBaseConfig::$dbhost,DataBaseConfig::$username,DataBaseConfig::$password,$appId,DataBaseConfig::$charset);
        
        $sql = "select * from zy_product where id=$productId";
        
        $resultObj = $dbOperation->queryBySql($sql);
        
        if($resultObj){
            
            $resultArr = array('status'=>'1','data'=>$resultObj);
            
            echo json_encode($resultArr);
            
        }else{
            
            $resultArr = array ('status'=>'0','msg'=>'查询失败');
            
            echo json_encode($resultArr);
            
        }
        
    }
    
}

?>
