<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of PictureController
 *
 * @author barfoo
 */
class PictureController extends Controller {
    //put your code here
    
    /*
     * 获取图片列表
     * @param productId,$pageIndex,$pageSiz
     * 
     */
    public function actionPictureList() {
        
        $productId = $_GET['appId'];
        $pageIndex = $_GET['pageIndex'];
        $pageSize = $_GET['pageSize'];
        
        if(!$productId){
            
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
        $dbOperation = new class_DBOperation(DataBaseConfig::$dbhost,DataBaseConfig::$username,DataBaseConfig::$password,$productId,DataBaseConfig::$charset);
        $startIndex = ($pageIndex-1)*$pageSize;
        $sql = "select * from zy_picture limit $startIndex,$pageSize";
        
        $resultArr = $dbOperation->queryAllBySql($sql);
        
        $jsonArr = array('status'=>'1','data'=>$resultArr);
        
        echo json_encode($jsonArr);
        
    }
    
}

?>
