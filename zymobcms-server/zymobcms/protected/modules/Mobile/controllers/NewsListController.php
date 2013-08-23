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
        $userId = $_GET['userId'];
        
        if($productId==NULL||$categoryId==NULL||$tabTypeId==NULL){
            
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
 
        //是否存在缓存
        $cacheManager = new CacheManager($productId);
        $isCached = $cacheManager->isCacheDataForCategoryIdAndTabType($categoryId,$tabTypeId,$pageIndex);
        if($isCached){
        
        	$resultArr = $cacheManager->returnCacheDataForCategoryIdAndTabType($categoryId,$tabTypeId,$pageIndex);
        
//         	foreach ($resultArr as $key=>$value){
        		
//         		//是否已经收藏过文章
//         		if(is_array($value)){
//         			$currentRecord = current($value);
        			        			
//         			while ($currentRecord){
        			
//         				for ($i = 0;$i<count($currentRecord);$i++){
        					
//         					$articleId = $currentRecord[$i]['id'];
//         					$checkIfUserSupport = "select id from zy_user_favorite where article_id = $articleId and user_id=$userId";
        					         					
//         					$resultCheck = $dbOperation->queryBySql($checkIfUserSupport);
//         					if ($resultCheck) {
//         						$currentRecord[$i]['isFavorited']="1";
//         					}else{
//         						$currentRecord[$i]['isFavorited']="0";
//         					}
//         					$currentRecord = next($value);
        					
//         				}
        				
//         			}
//         		}
//         	}
        	
        	echo $resultArr;
        	
        	return ;
        }
        
       
        $truePageIndex = ($pageIndex-1)>=0? $pageIndex-1:$pageIndex;
        $startIndex = $truePageIndex*$pageSize;
        
        //建立数据库链接
        $dbOperation = new class_DBOperation(DataBaseConfig::$dbhost,DataBaseConfig::$username,DataBaseConfig::$password,$productId,DataBaseConfig::$charset);
        
        $hotNews = array();
        if($pageIndex<=1){
        	//hotNews
        	$hotNewsSql = "select id,title,publish_time,source,summary,images,links,commentable,author,hot_news,tab_type_id,category_id from zy_article where category_id=$categoryId and tab_type_id=$tabTypeId and hot_news=1";
        	$hotNews = $dbOperation->queryAllBySql($hotNewsSql);
        	
//         	//是否已经收藏过文章
//         	$currentRecord = current($hotNews);
//         	while ($currentRecord){
        	
//         		$checkIfUserSupport = "select id from zy_user_favorite where article_id = $currentRecord->id and user_id=$userId";
        	
//         		$resultCheck = $dbOperation->queryBySql($checkIfUserSupport);
//         		if ($resultCheck) {
//         			$currentRecord->isFavorited="1";
//         		}else{
//         			$currentRecord->isFavorited="0";
//         		}
//         		$currentRecord = next($hotNews);
//         	}
        }
        
        $normalNewsSql = "select id,title,publish_time,source,summary,images,links,commentable,author,hot_news,tab_type_id,category_id from zy_article where category_id=$categoryId and tab_type_id=$tabTypeId and hot_news=0 limit $startIndex,$pageSize";
        $resultArr = $dbOperation->queryAllBySql($normalNewsSql);
        
        //列表内查询用户是否收藏，加重服务器负担，改在详情内查询
//         $currentRecord = current($resultArr);
//         while ($currentRecord){
        
//         	$checkIfUserSupport = "select id from zy_user_favorite where article_id = $currentRecord->id and user_id=$userId";
        
//         	$resultCheck = $dbOperation->queryBySql($checkIfUserSupport);
//         	if ($resultCheck) {
//         		$currentRecord->isFavorited="1";
//         	}else{
//         		$currentRecord->isFavorited="0";
//         	}
//         	$currentRecord = next($resultArr);
//         }
        
        $jsonArr = array('status'=>'1','data'=>array('hotNews'=>$hotNews,'newsList'=>$resultArr));
        
        echo json_encode($jsonArr);
        
        //save cache
        $cacheManager->cacheNewsListByCategoryAndTabType($categoryId,$tabTypeId,$pageIndex,$jsonArr);
        
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
        
        //是否存在缓存
        $cacheManager = new CacheManager($productId);
        $isCached = $cacheManager->isArticleDetailCacheExist($articleId);
        if($isCached){
        
        	$cacheObj = $cacheManager->returnArticleDetailCache($articleId);
        
        	//查询是否收藏该文章
        	$checkFavorite = "select id from zy_user_favorite where article_id=$articleId and user_id=$userId";
        	$checkResult = $dbOperation->queryBySql($checkFavorite);
        	$resultType = $checkResult?  1:0;
        	
        	$cacheObj['data']['isFavorite']=$resultType;
        	
        	echo json_encode($cacheObj);
        
        	return ;
        }
        
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

            //缓存
            $cacheManager->cacheArticleDetail($articleId,$resultArr);
            
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
            $userId    = $_GET['userId'];
            
            if($articleId==NULL || $productId==NULL || $userId==NULL){
                
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
            $sql = "select zy_comment.*,zy_user.login_name,zy_user.nick_name,zy_user.location from zy_comment inner join zy_user on zy_comment.create_user = zy_user.id where article_id=$articleId limit $startIndex,$pageSize";
                        
            $commentArr = $dbOperation->queryAllBySql($sql);
                        
            //是否已经支持
            $currentRecord = current($commentArr);
            while ($currentRecord){
            	
            	$currentCommentId = $currentRecord->comment_id;
            	$checkIfUserSupport = "select id from zy_comment_support where comment_id = $currentCommentId and user_id=$userId";
            	
            	$resultCheck = $dbOperation->queryBySql($checkIfUserSupport);
            	if ($resultCheck) {
            		$currentRecord->isSupported="1";
            	}else{
            		$currentRecord->isSupported="0";
            	}            	
            	$currentRecord = next($commentArr);
            }
            
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
            
            //检查是否有缓存
            $cacheManager = new CacheManager($appId);
            $isCached = $cacheManager->isHotCommentListCacheExist($pageIndex);
            if($isCached){
                $resultArr = $cacheManager->returnHotCommentCacheListByPageIndex($pageIndex);
                echo $resultArr;
                return;
            }
            
            $dbOperation = new class_DBOperation(DataBaseConfig::$dbhost,DataBaseConfig::$username,DataBaseConfig::$password,$appId,DataBaseConfig::$charset);
            $truePageIndex = ($pageIndex-1)>=0? $pageIndex-1:$pageIndex;
            $startIndex = $truePageIndex*$pageSize;
            $sql = "select zy_comment.*,zy_article.title,zy_user.login_name,zy_user.location from zy_comment inner join zy_article on zy_comment.article_id=zy_article.id inner join zy_user on zy_comment.create_user=zy_user.id order by support_count desc limit $startIndex,$pageSize ";
            
            $resultArr = $dbOperation->queryAllBySql($sql);
            
            $josnArr = array('status'=>'1','data'=>$resultArr);
            
            echo json_encode($josnArr);
            
            //缓存
            $cacheManager->cacheHotCommentNewList($pageIndex,$josnArr);
        }
        
        /*
         * 支持某条评论
         * 
         */
        public function actionSupportComment(){
            
               $appId = $_GET['appId'];
               $commentId = $_GET['commentId'];
               $userId = $_GET['userId'];
               
               if($appId==NULL || $commentId == NULL || $userId==NULL){
                   $resultArr = array('status'=>'0','msg'=>'参数缺失');
            
                    echo json_encode($resultArr);
            
                    return;
               }
           
               
            $dbOperation = new class_DBOperation(DataBaseConfig::$dbhost,DataBaseConfig::$username,DataBaseConfig::$password,$appId,DataBaseConfig::$charset);
            
            //是否已经支持过了
            $sqlCheck = "select id from zy_comment_support where comment_id=$commentId and user_id=$userId";

            $checkResult = $dbOperation->queryBySql($sqlCheck);
            
            if($checkResult){
            	
            	$josnArr = array('status'=>'0','msg'=>'已经支持过了');
            	
            	echo json_encode($josnArr);
            	 
            	return ;
            }
            
            $sqlInsert = "insert into zy_comment_support(comment_id,user_id)values($commentId,$userId)";
            
            $inserResult = $dbOperation->saveBySql($sqlInsert);
            
            if($inserResult){
                $sql = "update zy_comment set support_count=support_count+1 where comment_id = $commentId";
                $resultObj = $dbOperation->saveBySql($sql);
                
                if($resultObj){
                   $josnArr = array('status'=>'1','data'=>'支持成功');
                }  else {
                   $josnArr = array('status'=>'0','msg'=>'失败，服务器忙');
                }
            
            echo json_encode($josnArr);
            
            }else{
                $josnArr = array('status'=>'0','msg'=>'失败，服务器忙');
                echo json_encode($josnArr);
            } 
        }
        
        /*
         *  踩某条评论
         */
        public function actionUnSupportComment(){
            
               $appId = $_GET['appId'];
               $commentId = $_GET['commentId'];
               $userId = $_GET['userId'];
               
               if($appId==NULL || $commentId == NULL || $userId==NULL){
                   $resultArr = array('status'=>'0','msg'=>'参数缺失');
            
                    echo json_encode($resultArr);
            
                    return;
               }
               
            $dbOperation = new class_DBOperation(DataBaseConfig::$dbhost,DataBaseConfig::$username,DataBaseConfig::$password,$appId,DataBaseConfig::$charset);
            
            $sqlDelete = "delete from zy_comment_support where user_id=$userId and comment_id=$commentId";
            
            $deleteResult = $dbOperation->saveBySql($sqlDelete);
            
            if($deleteResult){
                $sql = "update zy_comment set support_count=support_count-1 where comment_id = $commentId";
            
                $resultObj = $dbOperation->saveBySql($sql);
            
                if($resultObj){
                   $josnArr = array('status'=>'1','data'=>'支持成功');
                }  else {
                   $josnArr = array('status'=>'0','msg'=>'已经踩过了');
                }
            
                echo json_encode($josnArr);
            }else{
                $josnArr = array('status'=>'0','msg'=>'失败，服务器忙');
                echo json_encode($josnArr);
            }
            
        }
        
        /*
         * 取消收藏
         */
        public function actionDeleteFavorite(){
            
            $articleId = $_GET['articleId'];
            $productId = $_GET['appId'];
            $userId  = $_GET['userId'];
            
            if(!$articleId || !$productId || !$userId){
                
                $resultArr = array('status'=>'0','msg'=>'参数缺失');
            
                echo json_encode($resultArr);
            
                return; 
            }
                        
            $dbOperation = new class_DBOperation(DataBaseConfig::$dbhost,DataBaseConfig::$username,DataBaseConfig::$password,$productId,DataBaseConfig::$charset);
            
            //不允许重复收藏
            $favoriteExistSql = "select id from zy_user_favorite where article_id=$articleId and user_id=$userId";
            $favoriteExist = $dbOperation->queryBySql($favoriteExistSql);
            if(!$favoriteExist){
              
                $resultArr = array('status'=>'0','msg'=>'你没有收藏过该文章');
                
                echo json_encode($resultArr);
                
                return;
                
            } 
            
            
            $insertSql = "delete from zy_user_favorite where article_id = $articleId and user_id=$userId";            
            $insertResult = $dbOperation->saveBySql($insertSql);
            
            if($insertResult){
                
                $resultArr = array('status'=>'1','msg'=>'取消成功');
            
                //文章收藏数加1
                $updateFavoriteSql = "update zy_article set favorite_count=favorite_count-1 where id=$articleId";
                $dbOperation->saveBySql($updateFavoriteSql);
                
                echo json_encode($resultArr);
            
                return;
                
            }else{
                
                $resultArr = array('status'=>'0','msg'=>'收藏失败');
            
                echo json_encode($resultArr);
            
                return;
            }
            
        }
        
} 

?>
