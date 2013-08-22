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
        $userId   = $_GET['userId'];
        $categoryId = $_GET['categoryId'];
        $tabTypeId = $_GET['tabTypeId'];
        
        if($productId==NULL || $categoryId == NULL || $tabTypeId==NULL){
            
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
        
        //查询缓存是否存在
        $cacheManager = new CacheManager($productId);
        $isCached = $cacheManager->isPictureListCacheExist($categoryId,$tabTypeId,$pageIndex);
        if($isCached){
        
        	$resultArr = $cacheManager->returnPictureCacheListByPageIndex($categoryId,$tabTypeId,$pageIndex);
        
        	foreach ($resultArr as $key=>$value){
        
        		//是否已经收藏过图片
        		if(is_array($value)){
        			$currentRecord = current($value);
        
        			while ($currentRecord){
        				 
        				$articleId = $currentRecord['id'];
        				$checkIfUserSupport = "select id from zy_user_picture_favorite where picture_id = $articleId and user_id=$userId";
        					 
        				$resultCheck = $dbOperation->queryBySql($checkIfUserSupport);
        				if ($resultCheck) {
        					$currentRecord['isFavorited']="1";
        				}else{
        					$currentRecord['isFavorited']="0";
        				}
        				$currentRecord = next($value);
        			}
        		}
        	}
        	 
        	echo json_encode($resultArr);
        	 
        	return ;
        }
        
        
        $truePageIndex = ($pageIndex-1)>=0? $pageIndex-1:$pageIndex;
        $startIndex = $truePageIndex*$pageSize;
        $sql = "select * from zy_picture limit $startIndex,$pageSize";
        
        $resultArr = $dbOperation->queryAllBySql($sql);
        
        //是否已经收藏过这个图片
        $currentRecord = current($resultArr);
        while ($currentRecord){
        	 
        	$checkIfUserSupport = "select id from zy_user_picture_favorite where picture_id = $currentRecord->id and user_id=$userId";
        	 
        	$resultCheck = $dbOperation->queryBySql($checkIfUserSupport);
        	if ($resultCheck) {
        		$currentRecord->isFavorited="1";
        	}else{
        		$currentRecord->isFavorited="0";
        	}
        	$currentRecord = next($resultArr);
        }
        
        $jsonArr = array('status'=>'1','data'=>$resultArr);
    
        echo json_encode($jsonArr);
        
        //缓存数据
        $cacheManager->cachePictureNewList($categoryId, $tabTypeId,$pageIndex,$jsonArr);
        
    }
    
    /*
     * 评论该图片
     */
    public function actionCommentPicture(){
        
            $pictureId = $_GET['pictureId'];
            $productId = $_GET['appId'];
            $content = $_GET['content'];
            $userId  = $_GET['userId'];
            
            if(!$pictureId || !$productId || !$content || !$userId){
                
                $resultArr = array('status'=>'0','msg'=>'参数缺失');
            
                echo json_encode($resultArr);
            
                return; 
            }
            
            $create_time = date('y-m-d h:i:s');
            
            $dbOperation = new class_DBOperation(DataBaseConfig::$dbhost,DataBaseConfig::$username,DataBaseConfig::$password,$productId,DataBaseConfig::$charset);
            //文章是否还存在
            $checkSql = "select id from zy_picture where id=$pictureId";
            $checkResult = $dbOperation->queryAllBySql($checkSql);
            if(!$checkResult){
                $resultArr = array('status'=>'0','msg'=>'图片已经被删除');
                echo json_encode($resultArr);
                return;
            }
            
            $insertSql = "insert into zy_picture_comment(picture_id,create_user,content,create_time)values($pictureId,$userId,'$content','$create_time')";            
            $insertResult = $dbOperation->saveBySql($insertSql);
            
            if($insertResult){
                
                $resultArr = array('status'=>'1','msg'=>'评论成功');
                
                //为该文章增加一条评论数
                $updateSql = "update zy_picture set comment_count=comment_count+1 where id=$pictureId";
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
     * 图片评论列表
     * 
     */
    public function actionPictureCommentList(){
        
            $pictureId = $_GET['pictureId'];
            $productId = $_GET['appId'];
            $pageIndex = $_GET['pageIndex'];
            $pageSize  = $_GET['pageSize'];
            $userId    = $_GET['userId'];
            
            if(!$pictureId || !$productId){
                
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
            $checkSql = "select id from zy_picture where id=$pictureId";
            $checkResult = $dbOperation->queryAllBySql($checkSql);
            if(!$checkResult){
                $resultArr = array('status'=>'0','msg'=>'图片已经被删除');
                echo json_encode($resultArr);
                return;
            }
            
            $truePageIndex = ($pageIndex-1)>=0? $pageIndex-1:$pageIndex;
            $startIndex = $truePageIndex*$pageSize;
            $sql = "select zy_picture_comment.*,zy_user.login_name,zy_user.nick_name,zy_user.location from zy_picture_comment inner join zy_user on zy_picture_comment.create_user = zy_user.id where picture_id=$pictureId limit $startIndex,$pageSize";
            
            $commentArr = $dbOperation->queryAllBySql($sql);
            
            //是否已经支持
            $currentRecord = current($commentArr);
            while ($currentRecord){
            	 
            	$currentCommentId = $currentRecord->comment_id;
            	$checkIfUserSupport = "select id from zy_picture_comment_support where comment_id = $currentCommentId and user_id=$userId";
            	 
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
     * 收藏该图片
     */
    public function actionFavoritePicture(){
        
            $articleId = $_GET['pictureId'];
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
            $favoriteExistSql = "select id from zy_user_picture_favorite where picture_id=$articleId and user_id=$userId";
            $favoriteExist = $dbOperation->queryBySql($favoriteExistSql);
            if($favoriteExist){
              
                $resultArr = array('status'=>'0','msg'=>'已经收藏过该图片');
                
                echo json_encode($resultArr);
                
                return;
                
            } 
            
            
            $insertSql = "insert into zy_user_picture_favorite(picture_id,user_id,add_time)values($articleId,$userId,'$create_time')";            
            $insertResult = $dbOperation->saveBySql($insertSql);
            
            if($insertResult){
                
                $resultArr = array('status'=>'1','msg'=>'收藏成功');
            
                //文章收藏数加1
                $updateFavoriteSql = "update zy_picture set favorite_count=favorite_count+1 where id=$articleId";
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
     * 取消收藏
     */
    public function actionRemoveFavoritePicture(){
        
            $articleId = $_GET['pictureId'];
            $productId = $_GET['appId'];
            $userId  = $_GET['userId'];

            
            if($articleId ==NULL || $productId==NULL){
                
                $resultArr = array('status'=>'0','msg'=>'参数缺失');
            
                echo json_encode($resultArr);
            
                return; 
            }
                        
            $dbOperation = new class_DBOperation(DataBaseConfig::$dbhost,DataBaseConfig::$username,DataBaseConfig::$password,$productId,DataBaseConfig::$charset);
            
            //不允许重复收藏
            $favoriteExistSql = "select id from zy_user_picture_favorite where picture_id=$articleId and user_id=$userId";
            $favoriteExist = $dbOperation->queryBySql($favoriteExistSql);
            if(!$favoriteExist){
              
                $resultArr = array('status'=>'0','msg'=>'你没有收藏过该图片');
                
                echo json_encode($resultArr);
                
                return;
                
            } 
            
            
            $insertSql = "delete from zy_user_picture_favorite where picture_id = $articleId and user_id=$userId";            
            $insertResult = $dbOperation->saveBySql($insertSql);
            
            if($insertResult){
                
                $resultArr = array('status'=>'1','msg'=>'取消成功');
            
                //文章收藏数加1
                $updateFavoriteSql = "update zy_picture set favorite_count=favorite_count-1 where id=$articleId";
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
     * 查询某图片是否已经收藏
     */
    public function  actionIsFavoritePicture(){
        
        $articleId = $_GET['pictureId'];
        $productId = $_GET['appId'];
        $userId  = $_GET['userId'];
        
        if(!$articleId || !$productId || !$userId){
                
                $resultArr = array('status'=>'0','msg'=>'参数缺失');
            
                echo json_encode($resultArr);
            
                return; 
            }
                        
            $dbOperation = new class_DBOperation(DataBaseConfig::$dbhost,DataBaseConfig::$username,DataBaseConfig::$password,$productId,DataBaseConfig::$charset);
            
            //不允许重复收藏
            $favoriteExistSql = "select id from zy_user_picture_favorite where picture_id=$articleId and user_id=$userId";
            $favoriteExist = $dbOperation->queryBySql($favoriteExistSql);
            if($favoriteExist){
              
                $resultArr = array('status'=>'1','msg'=>'你收藏过该图片');
                
                echo json_encode($resultArr);
                
                return;
                
            }else{
                
                $resultArr = array('status'=>'0','msg'=>'你没有收藏过该图片');
                
                echo json_encode($resultArr);
                
                return;
                
            }
        
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
            $sqlCheck = "select id from zy_picture_comment_support where comment_id=$commentId and user_id=$userId";
             
            $checkResult = $dbOperation->queryBySql($sqlCheck);
             
            if($checkResult){
            	 
            	$josnArr = array('status'=>'0','msg'=>'已经支持过了');
            	 
            	echo json_encode($josnArr);
            	 
            	return ;
            }
            
            
            $sqlInsert = "insert into zy_picture_comment_support(comment_id,user_id)values($commentId,$userId)";
            
            $inserResult = $dbOperation->saveBySql($sqlInsert);
            
            if($inserResult){
                $sql = "update zy_picture_comment set support_count=support_count+1 where comment_id = $commentId";
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
            
            $sqlDelete = "delete from zy_picture_comment_support where user_id=$userId and comment_id=$commentId";
            
            $deleteResult = $dbOperation->saveBySql($sqlDelete);
            
            if($deleteResult){
                $sql = "update zy_picture_comment set support_count=support_count-1 where comment_id = $commentId";
            
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
         * 图片某个Category下得所有子Tab分类
         */
        public function actionTabTypesByCategoryId(){
        	
        	$productId = $_GET['appId'];
        	$categoryId = $_GET['categoryId'];
        	
        	if($productId==NULL||$categoryId==NULL){
        		
        		$resultArr = array('status'=>'0','msg'=>'参数缺失');
        		
        		echo json_encode($resultArr);
        		
        		return;
        	}
        	
        	$dbOperation = new class_DBOperation(DataBaseConfig::$dbhost,DataBaseConfig::$username,DataBaseConfig::$password,$productId,DataBaseConfig::$charset);
        	 
        	$sqlCheck="select * from zy_picture_tab_type where category_id = $categoryId";
        	
        	$resultArr = $dbOperation->queryAllBySql($sqlCheck);
        	
        	if ($resultArr) {
        		
        		$jsonArr = array('status'=>'1','data'=>$resultArr);
        		
        		echo json_encode($jsonArr);
        		
        		return ;
        		
        	}else{
        		
        		$jsonArr = array('status'=>'0','msg'=>'服务器繁忙');
        		
        		echo json_encode($jsonArr);
        		
        		return ;
        	}
        	
        }
        
        /*
         * 获取图片详情
         */
        public function actionPictureDetail(){
        	
        	$productId = $_GET['pictureId'];
        	$appId = $_GET['appId'];
        	$userId = $_GET['userId'];
        	
        	if($productId == NULL || $appId==NULL || $userId==NULL){
        	
        		$resultArr = array('status'=>'0','msg'=>'参数缺失');
        	
        		echo json_encode($resultArr);
        	
        		return;
        	}
        	
        	//是否存在缓存
        	$cacheManager = new CacheManager($productId);
        	$isCached = $cacheManager->isPictureDetailCacheExist($productId);
        	if($isCached){
        		
        		$cacheObj = $cacheManager->returnPictureDetailCache($productId);
        		
        		echo $cacheObj;
        		
        		return ;
        	}
        	//查询
        	$dbOperation = new class_DBOperation(DataBaseConfig::$dbhost,DataBaseConfig::$username,DataBaseConfig::$password,$appId,DataBaseConfig::$charset);
        	
        	$sql = "select * from zy_picture where id=$productId";
        	
        	$resultObj = $dbOperation->queryBySql($sql);
        	
        	if($resultObj){
        	
        		$resultArr = array('status'=>'1','data'=>$resultObj);
        	
        		echo json_encode($resultArr);
        		
        		//缓存
        		$cacheManager->cachePictureDetail($productId,$resultArr);
        	
        	}else{
        	
        		$resultArr = array ('status'=>'0','msg'=>'查询失败');
        	
        		echo json_encode($resultArr);
        	
        	}
        	
        }
    
}

?>
