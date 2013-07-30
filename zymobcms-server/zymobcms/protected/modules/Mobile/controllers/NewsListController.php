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
        $productId = $_GET['appId'];
        
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
        
        //hotNews
        $hotNewsSql = "select id,title,publish_time,source,summary,images,links,commentable,author from zy_article where category_id=$categoryId and tab_type_id=$tabTypeId and hot_news=1";
        $hotNews = $dbOperation->queryAllBySql($hotNewsSql);
          
        $normalNewsSql = "select id,title,publish_time,source,summary,images,links,commentable,author from zy_article where category_id=$categoryId and tab_type_id=$tabTypeId and hot_news=0 limit $startIndex,$pageSize";
        $resultArr = $dbOperation->queryAllBySql($normalNewsSql);
        
        $jsonArr = array('status'=>'1','data'=>array('hotNews'=>$hotNews,'newsList'=>$resultArr));
        
        echo json_encode($jsonArr);
        
    }
    
    /*
     * 文章详情
     * @param articleId,productId
     */
    public function actionArticleDetail(){
        
        $articleId = $_GET['articleId'];
        $productId = $_GET['appId'];
        
        if(!$articleId || !$productId){
           $resultArr = array('status'=>'0','msg'=>'参数缺失');
            
            echo json_encode($resultArr);
            
            return;                     
        }
        
        //查询
        $dbOperation = new class_DBOperation(DataBaseConfig::$dbhost,DataBaseConfig::$username,DataBaseConfig::$password,$productId,DataBaseConfig::$charset);
        $sql = "select * from zy_article where id=$articleId";
        $resultObj = $dbOperation->queryBySql($sql);
        
        if($resultObj){
            $resultArr = array('status'=>'1','data'=>$resultObj);
            
            echo json_encode($resultArr);

        }else{
            $resultArr = array('status'=>'0','msg'=>'没有查询到数据');
            
            echo json_encode($resultArr);

        }
    }

        /*
         * 文章评论
         * @parma articleId,productId,pageSize,pageIndex
         */
        public function actionArticleComment(){
            
            $articleId = $_GET['articleId'];
            $productId = $_GET['appId'];
            $pageIndex = $_GET['pageIndex'];
            $pageSize  = $_GET['pageSize'];
            
            if(!$articleId || !$productId){
                
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
            $sql = "select * from zy_comment where article_id=$articleId limit $startIndex,$pageSize";
            
            $commentArr = $dbOperation->queryAllBySql($sql);
            
            $resultArr = array('status'=>'1','data'=>$commentArr);
            
            echo json_encode($resultArr);
            
        }
        
        /*
         * 发表评论
         * @param articleId,content,productId,$userId
         */
        public function actionCommentArticle(){
            
            $articleId = $_GET['articleId'];
            $productId = $_GET['appId'];
            $content = $_GET['content'];
            $userId  = $_GET['userId'];
            
            if(!$articleId || !$productId || !$content || !$userId){
                
                $resultArr = array('status'=>'0','msg'=>'参数缺失');
            
                echo json_encode($resultArr);
            
                return; 
            }
            
            $create_time = date('y-m-d h:i:s');
            
            $dbOperation = new class_DBOperation(DataBaseConfig::$dbhost,DataBaseConfig::$username,DataBaseConfig::$password,$productId,DataBaseConfig::$charset);
            $insertSql = "insert into zy_comment(article_id,create_user,content,create_time)values($articleId,$userId,'$content','$create_time')";
                        
            $insertResult = $dbOperation->saveBySql($insertSql);
            
            if($insertResult){
                
                $resultArr = array('status'=>'1','msg'=>'评论成功');
            
                echo json_encode($resultArr);
            
                return;
                
            }else{
                
                $resultArr = array('status'=>'0','msg'=>'评论失败');
            
                echo json_encode($resultArr);
            
                return;
            }
            
        }
        
        /*
         *收藏文章 
         *@param articleId,userId,productId, 
         */
        public function actionFavoriteArticle(){
            
            $articleId = $_GET['articleId'];
            $productId = $_GET['appId'];
            $userId  = $_GET['userId'];
            
            if(!$articleId || !$productId || !$userId){
                
                $resultArr = array('status'=>'0','msg'=>'参数缺失');
            
                echo json_encode($resultArr);
            
                return; 
            }
            
            $create_time = date('y-m-d h:i:s');
            
            $dbOperation = new class_DBOperation(DataBaseConfig::$dbhost,DataBaseConfig::$username,DataBaseConfig::$password,$productId,DataBaseConfig::$charset);
            $insertSql = "insert into zy_user_favorite(article_id,user_id,add_time)values($articleId,$userId,'$create_time')";
                        
            $insertResult = $dbOperation->saveBySql($insertSql);
            
            if($insertResult){
                
                $resultArr = array('status'=>'1','msg'=>'收藏成功');
            
                echo json_encode($resultArr);
            
                return;
                
            }else{
                
                $resultArr = array('status'=>'0','msg'=>'收藏失败');
            
                echo json_encode($resultArr);
            
                return;
            }
            
            
        }
         
        /*
         * 热门评论
         * @param appId
         */
        public function actionHotComments(){
            
            $appId = $_GET['appId'];
            $pageIndex = $_GET['pageIndex'];
            $pageSize = $_GET['pageSize'];
            
            if(!$appId){
            
            $resultArr = array('status'=>'0','msg'=>'参数缺失');
            
            echo json_encode($resultArr);
            
            return;
            }
            
            if($pageIndex<0){
                $pageIndex=0;
            }
            
            if($pageSize>10){
                $pageSize=10;
            }
            
            $dbOperation = new class_DBOperation(DataBaseConfig::$dbhost,DataBaseConfig::$username,DataBaseConfig::$password,$appId,DataBaseConfig::$charset);

            $startIndex = ($pageIndex-1)*$pageSize;
            $sql = "select * from zy_comment where support_count>20 limit $startIndex,$pageSize";
            
            $resultArr = $dbOperation->queryAllBySql($sql);
            
            $josnArr = array('status'=>'1','data'=>$resultArr);
            
            echo json_encode($josnArr);
            
        }
} 

?>
