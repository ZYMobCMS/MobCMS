<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of NewsListController
 *
 * @author barfoo
 */
class NewsListController extends Controller {
    //put your code here
    
    /*
     * 文章列表
     * @param categoryId,tabTypeId,pageIndex,pageSize,productId
     */
    public function actionNewsList(){
        
        $categoryId = $_GET['categoryId'];
        $tabTypeId = $_GET['tabTypeId'];
        $pageIndex = $_GET['pageIndex'];
        $pageSize  = $_GET['pageSize'];
        $productId = $_GET['productId'];
        
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
        $startIndex = $pageIndex*$pageSize;
        
        //hotNews
        $hotNews = $dbOperation->queryAllByAttributes('zy_article',array('category_id'=>$categoryId,'tab_type_id'=>$tabTypeId,'hot_news'=>'1'));
        
        echo json_encode($hotNews);
        
        $resultArr = $dbOperation->queryValuesByConditions('zy_article',array('category_id'=>$categoryId,'tab_type_id'=>$tabTypeId,'hot_news'=>'0'),array('id','title','public_time','source','summary','images','links','commentable','author'), $startIndex, $pageSize);
        
        $jsonArr = array('status'=>'1','data'=>array('hotNews'=>$hotNews,'newsList'=>$resultArr));
        
        echo json_encode($jsonArr);
        
    }
    
    /*
     * 文章详情
     * @param articleId
     */
    public function actionArticleDetail(){
        
        $articleId = isset($_GET['articleId'])? $_GET['articleId']:NULL;
        $productId = isset($_GET['productId'])? $_GET['productId']:NULL;
        
        if(!$articleId || !$productId){
           $resultArr = array('status'=>'0','msg'=>'参数缺失');
            
            echo json_encode($resultArr);
            
            return;                     
        }
        
        //查询
        $dbOperation = new class_DBOperation(DataBaseConfig::$dbhost,DataBaseConfig::$username,DataBaseConfig::$password,$productId,DataBaseConfig::$charset);
        
        $resultObj = $dbOperation->queryByPk('zy_article',array('id'=>$articleId));
        
        if($resultObj){
            $resultArr = array('status'=>'1','data'=>$resultObj);
            
            echo json_encode($resultArr);

        }else{
            $resultArr = array('status'=>'0','msg'=>'没有查询到数据');
            
            echo json_encode($resultArr);

        }
        
    }
}

?>
