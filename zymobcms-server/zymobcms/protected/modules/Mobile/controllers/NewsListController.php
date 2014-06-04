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
        $dbOperation = new Class_DBOperation(DataBaseConfig::$dbhost,DataBaseConfig::$username,DataBaseConfig::$password,$productId,DataBaseConfig::$charset);
        
        $hotNews = array();
        if($pageIndex<=1){
        	//hotNews
        	$hotNewsSql = "select id,title,publish_time,source,summary,images,links,commentable,author,hot_news,tab_type_id,category_id from zy_article where category_id=$categoryId and tab_type_id=$tabTypeId and hot_news=1 order by id desc";
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
        
        $normalNewsSql = "select zy_user.nick_name as create_user_name, zy_article.id,zy_article.title,zy_article.publish_time,zy_article.source,zy_article.summary,zy_article.images,zy_article.links,zy_article.commentable,zy_article.author,zy_article.hot_news,zy_article.tab_type_id,zy_article.category_id,zy_article.create_user from zy_article inner join zy_user on zy_user.id = zy_article.create_user where category_id=$categoryId and tab_type_id=$tabTypeId and hot_news=0 order by id desc limit $startIndex,$pageSize";
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
        $dbOperation = new Class_DBOperation(DataBaseConfig::$dbhost,DataBaseConfig::$username,DataBaseConfig::$password,$productId,DataBaseConfig::$charset);
        
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
            $dbOperation = new Class_DBOperation(DataBaseConfig::$dbhost,DataBaseConfig::$username,DataBaseConfig::$password,$productId,DataBaseConfig::$charset);
            
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
            $sql = "select zy_comment.*,zy_user.login_name,zy_user.nick_name,zy_user.location from zy_comment inner join zy_user on zy_comment.create_user = zy_user.id where article_id=$articleId order by comment_id desc limit $startIndex,$pageSize";
                        
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
            $userActiveOpen = $_GET['userActiveOpen'];
            
            if(!$articleId || !$productId || !$content || !$userId){
                
                $resultArr = array('status'=>'0','msg'=>'参数缺失');
            
                echo json_encode($resultArr);
            
                return; 
            }
            
            $create_time = date('y-m-d H:i:s');
            
            $dbOperation = new Class_DBOperation(DataBaseConfig::$dbhost,DataBaseConfig::$username,DataBaseConfig::$password,$productId,DataBaseConfig::$charset);
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
                
                //返回该评论Id
                $sql = "select * from zy_comment where article_id = $articleId and create_user = $userId and content='$content'";
                $findObj = $dbOperation->queryBySql($sql);
                $resultArr = array('status'=>'1','data'=>$findObj);
                
                //为该文章增加一条评论数
                $updateSql = "update zy_article set comment_count=comment_count+1 where id=$articleId";
                $updateResult = $dbOperation->saveBySql($updateSql);
                if($updateResult){
                    
                }
            
                echo json_encode($resultArr);
            
                //插入一条活动纪录
                $activeRecordManager = new UserActiveRecordManager($productId,$userActiveOpen);
                $activeRecordManager->createAnCommentNewsRecord($content,$userId,'','',$articleId);
                
                
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
            $userActiveOpen = $_GET['userActiveOpen'];
            
            if(!$articleId || !$productId || !$userId){
                
                $resultArr = array('status'=>'0','msg'=>'参数缺失');
            
                echo json_encode($resultArr);
            
                return; 
            }
            
            $create_time = date('y-m-d h:i:s');
            
            $dbOperation = new Class_DBOperation(DataBaseConfig::$dbhost,DataBaseConfig::$username,DataBaseConfig::$password,$productId,DataBaseConfig::$charset);
            
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
            
                //插入一条活动纪录
                $activeRecordManager = new UserActiveRecordManager($productId,$userActiveOpen);
                $activeRecordManager->createFavNewsRecord('',$userId,'','',$articleId);
                
                
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
            
            $dbOperation = new Class_DBOperation(DataBaseConfig::$dbhost,DataBaseConfig::$username,DataBaseConfig::$password,$appId,DataBaseConfig::$charset);
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
               $userActiveOpen = $_GET['userActiveOpen'];
                
               if($appId==NULL || $commentId == NULL || $userId==NULL){
                   $resultArr = array('status'=>'0','msg'=>'参数缺失');
            
                    echo json_encode($resultArr);
            
                    return;
               }
           
               
            $dbOperation = new Class_DBOperation(DataBaseConfig::$dbhost,DataBaseConfig::$username,DataBaseConfig::$password,$appId,DataBaseConfig::$charset);
            
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
                   
                   echo json_encode($josnArr);
                    
                   //插入一条活动纪录
                	$sql = "select content,article_id from zy_comment where comment_id = $commentId";
                   	$resultObj = $dbOperation->queryBySql($sql);
                   	if($resultObj){
                   		$activeRecordManager = new UserActiveRecordManager($appId,$userActiveOpen);
                   		$activeRecordManager->createSupportAnNewsCommentRecord($resultObj->content,$userId,'','',$resultObj->article_id);
                   	}
                   
                   
                }  else {
                   $josnArr = array('status'=>'0','msg'=>'失败，服务器忙');
                   
                   echo json_encode($josnArr);
                    
                }
            
            
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
               $userActiveOpen = $_GET['userActiveOpen'];
                
               if($appId==NULL || $commentId == NULL || $userId==NULL){
                   $resultArr = array('status'=>'0','msg'=>'参数缺失');
            
                    echo json_encode($resultArr);
            
                    return;
               }
               
            $dbOperation = new Class_DBOperation(DataBaseConfig::$dbhost,DataBaseConfig::$username,DataBaseConfig::$password,$appId,DataBaseConfig::$charset);
            
            $sqlDelete = "delete from zy_comment_support where user_id=$userId and comment_id=$commentId";
            
            $deleteResult = $dbOperation->saveBySql($sqlDelete);
            
            if($deleteResult){
                $sql = "update zy_comment set support_count=support_count-1 where comment_id = $commentId";
            
                $resultObj = $dbOperation->saveBySql($sql);
            
                if($resultObj){
                   $josnArr = array('status'=>'1','data'=>'支持成功');
                   echo json_encode($josnArr);
                    
                   //插入一条活动纪录
                	$sql = "select content,article_id from zy_comment where comment_id = $commentId";
                   	$resultObj = $dbOperation->queryBySql($sql);
                   	if($resultObj){
                   		$activeRecordManager = new UserActiveRecordManager($appId,$userActiveOpen);
                   		$activeRecordManager->createUnSupportAnNewsCommentRecord($resultObj->content,$userId,'','',$resultObj->article_id);
                   	}

                }  else {
                   $josnArr = array('status'=>'0','msg'=>'已经踩过了');
                   echo json_encode($josnArr);
                    
                }
            
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
            $userActiveOpen = $_GET['userActiveOpen'];
            
            if(!$articleId || !$productId || !$userId){
                
                $resultArr = array('status'=>'0','msg'=>'参数缺失');
            
                echo json_encode($resultArr);
            
                return; 
            }
                        
            $dbOperation = new Class_DBOperation(DataBaseConfig::$dbhost,DataBaseConfig::$username,DataBaseConfig::$password,$productId,DataBaseConfig::$charset);
            
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
            
                //插入一条活动纪录
                $activeRecordManager = new UserActiveRecordManager($productId,$userActiveOpen);
                $activeRecordManager->createUnFavNewsRecord('',$userId,'','',$articleId);

                return;
                
            }else{
                
                $resultArr = array('status'=>'0','msg'=>'收藏失败');
            
                echo json_encode($resultArr);
            
                return;
            }
            
        }
        
        /*
         * 发表文章
         */
        public function actionPublishArticle(){
            
            $productId = $_GET['appId'];
            $userId  = $_GET['userId'];
            $content = $_GET['content'];
            $title = $_GET['title'];
            $images = $_GET['images'];
            $links = $_GET['links'];
            $source = $_GET['source'];
            $categoryId = $_GET['categoryId'];
            $tabTypeId = $_GET['tabTypeId'];
            $summary = $_GET['summary'];
            
            
            if(!$productId || !$userId || !$content || !$title){
                
                $resultArr = array('status'=>'0','msg'=>'参数缺失');
            
                echo json_encode($resultArr);
            
                return; 
            }
            
            $dbOperation = new Class_DBOperation(DataBaseConfig::$dbhost,DataBaseConfig::$username,DataBaseConfig::$password,$productId,DataBaseConfig::$charset);
            
            $creatTime = date("Y-m-d H:i:s");
            $createSql = "insert into zy_article(summary,title,create_time,publish_time,content,images,links,source,create_user,category_id,tab_type_id)values('$summary',$title','$creatTime','$creatTime','$content','$images','$links','$source','$userId','$categoryId','$tabTypeId')";
            
            echo $createSql;
            $createArticleResult = $dbOperation->saveBySql($createSql);
            if($createArticleResult){
                $resultArr = array('status'=>'1','msg'=>'发表成功');
            
                echo json_encode($resultArr);
            
                return; 
            }else{
                $resultArr = array('status'=>'0','msg'=>'发表失败');
            
                echo json_encode($resultArr);
            
                return; 
            }
            
        }
        
        /*
         * 更新文章
         */
        public function actionUpdateArticle(){
            
            $productId = $_GET['appId'];
            $userId  = $_GET['userId'];
            $articleId = $_GET['articleId'];
            $content = $_GET['content'];
            $title = $_GET['title'];
            $images = $_GET['images'];
            $links = $_GET['links'];
            $source = $_GET['source'];
            $summary = $_GET['summary'];
            
            if(!$productId || !$userId || !$articleId){
                
                $resultArr = array('status'=>'0','msg'=>'参数缺失');
            
                echo json_encode($resultArr);
            
                return; 
            }
            
            $dbOperation = new Class_DBOperation(DataBaseConfig::$dbhost,DataBaseConfig::$username,DataBaseConfig::$password,$productId,DataBaseConfig::$charset);
            
            $updateTime = date("Y-m-d H:i:s");
            $updateSql = "update zy_article set title='$title',content='$content',images='$images',links='$links',source='$source',summary='$summary',update_time='$updateTime' where id = '$articleId' and create_user = '$userId'";
            
            $updateResult = $dbOperation->saveBySql($updateSql);
            if($updateResult){
                $resultArr = array('status'=>'1','msg'=>'更新成功');
            
                echo json_encode($resultArr);
            
                return; 
            }else{
                $resultArr = array('status'=>'0','msg'=>'更新失败');
            
                echo json_encode($resultArr);
            
                return; 
            }
        }
        
        /*
         * 删除文章
         */
        public function actionDeleteArticle(){
            
            $productId = $_GET['appId'];
            $userId  = $_GET['userId'];
            $articleId = $_GET['articleId'];
            
            if(!$productId || !$userId || !$articleId){
                
                $resultArr = array('status'=>'0','msg'=>'参数缺失');
            
                echo json_encode($resultArr);
            
                return; 
            }
            
            $dbOperation = new Class_DBOperation(DataBaseConfig::$dbhost,DataBaseConfig::$username,DataBaseConfig::$password,$productId,DataBaseConfig::$charset);

            $deleteSql = "delete from zy_article where id = '$articleId' and create_user = '$userId'";
            $deleteResult = $dbOperation->saveBySql($deleteSql);
            if($deleteResult){
                $resultArr = array('status'=>'1','msg'=>'删除成功');
            
                echo json_encode($resultArr);
            
                return; 
            }else{
                $resultArr = array('status'=>'0','msg'=>'删除失败');
            
                echo json_encode($resultArr);
            
                return; 
            }
        }
        
        
} 

?>
