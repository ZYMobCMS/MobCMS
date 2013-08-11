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
        $truePageIndex = ($pageIndex-1)>=0? $pageIndex-1:$pageIndex;
        $startIndex = $truePageIndex*$pageSize;
        
        //hotNews
        $hotNewsSql = "select id,title,publish_time,source,summary,images,links,commentable,author,hot_news,tab_type_id,category_id from zy_article where category_id=$categoryId and tab_type_id=$tabTypeId and hot_news=1";
        $hotNews = $dbOperation->queryAllBySql($hotNewsSql);
          
        $normalNewsSql = "select id,title,publish_time,source,summary,images,links,commentable,author,hot_news,tab_type_id,category_id from zy_article where category_id=$categoryId and tab_type_id=$tabTypeId and hot_news=0 limit $startIndex,$pageSize";
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
        $userId    = $_GET['userId'];
        
        if(!$articleId || !$productId || !$userId){
           $resultArr = array('status'=>'0','msg'=>'参数缺失');
            
            echo json_encode($resultArr);
            
            return;                     
        }
        
        //查询
        $dbOperation = new class_DBOperation(DataBaseConfig::$dbhost,DataBaseConfig::$username,DataBaseConfig::$password,$productId,DataBaseConfig::$charset);
        $sql = "select * from zy_article where id=$articleId";
        $resultObj = $dbOperation->queryBySql($sql);
        
        //查询是否收藏该文章
        $checkFavorite = "select id from zy_user_favorite where article_id=$articleId and user_id=$userId";
        $checkResult = $dbOperation->queryBySql($checkFavorite);
        $resultType = $checkResult?  1:0;
        $resultObj->isFavorite=$resultType;
        
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
            
            //文章是否还存在
            $checkSql = "select id from zy_article where id=$articleId";
            $checkResult = $dbOperation->queryAllBySql($checkSql);
            if(!$checkResult){
                $resultArr = array('status'=>'0','msg'=>'文章已经被删除');
                echo json_encode($resultArr);
                return;
            }
            
            $truePageIndex = ($pageIndex-1)>=0? $pageIndex-1:$pageIndex;
            $startIndex = $truePageIndex*$pageSize;
            $sql = "select zy_comment.*,zy_user.login_name,zy_user.nick_name,zy_user.location from zy_comment inner join zy_user on create_user = id where article_id=$articleId limit $startIndex,$pageSize";
            
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
            //文章是否还存在
            $checkSql = "select id from zy_article where id=$articleId";
            $checkResult = $dbOperation->queryAllBySql($checkSql);
            if(!$checkResult){
                $resultArr = array('status'=>'0','msg'=>'文章已经被删除');
                echo json_encode($resultArr);
                return;
            }
            
            $insertSql = "insert into zy_comment(article_id,create_user,content,create_time)values($articleId,$userId,'$content','$create_time')";            
            $insertResult = $dbOperation->saveBySql($insertSql);
            
            if($insertResult){
                
                $resultArr = array('status'=>'1','msg'=>'评论成功');
                
                //为该文章增加一条评论数
                $updateSql = "update zy_article set comment_count=comment_count+1 where id=$articleId";
                $updateResult = $dbOperation->saveBySql($updateSql);
                if($updateResult){
                    
                }
            
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
            
            //不允许重复收藏
            $favoriteExistSql = "select id from zy_user_favorite where article_id=$articleId and user_id=$userId";
            $favoriteExist = $dbOperation->queryBySql($favoriteExistSql);
            if($favoriteExist){
              
                $resultArr = array('status'=>'0','msg'=>'已经收藏过该文章');
                
                echo json_encode($resultArr);
                
                return;
                
            } 
            
            
            $insertSql = "insert into zy_user_favorite(article_id,user_id,add_time)values($articleId,$userId,'$create_time')";            
            $insertResult = $dbOperation->saveBySql($insertSql);
            
            if($insertResult){
                
                $resultArr = array('status'=>'1','msg'=>'收藏成功');
            
                //文章收藏数加1
                $updateFavoriteSql = "update zy_article set favorite_count=favorite_count+1 where id=$articleId";
                $dbOperation->saveBySql($updateFavoriteSql);
                
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
         * @param appId,pageIndex,pageSize
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
            $truePageIndex = ($pageIndex-1)>=0? $pageIndex-1:$pageIndex;
            $startIndex = $truePageIndex*$pageSize;
            $sql = "select zy_comment.*,zy_article.title,zy_user.login_name,zy_user.location from zy_comment inner join zy_article on zy_comment.article_id=zy_article.id inner join zy_user on zy_comment.create_user=zy_user.id order by support_count desc limit $startIndex,$pageSize ";
            
            $resultArr = $dbOperation->queryAllBySql($sql);
            
            $josnArr = array('status'=>'1','data'=>$resultArr);
            
            echo json_encode($josnArr);
            
        }
        
        
} 

?>
