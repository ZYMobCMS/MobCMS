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
        $userId = $_GET['userId'];
        $categoryId = $_GET['categoryId'];
        $tabTypeId = $_GET['tabTypeId'];
        
        if($appId==NULL || $userId == NULL){
            
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
           
        //查询缓存是否存在
        $cacheManager = new CacheManager($appId);
        $isCached = $cacheManager->isProductListCacheExist($categoryId,$tabTypeId,$pageIndex);
        if($isCached){
        
        	$resultArr = $cacheManager->returnProductCacheListByPageIndex($categoryId,$tabTypeId,$pageIndex);
        
        	//加重服务器负担
//         	foreach ($resultArr as $key=>$value){
        
//         		//是否已经收藏过图片
//         		if(is_array($value)){
//         			$currentRecord = current($value);
                			
//         			while ($currentRecord){
        				 
//         				$articleId = $currentRecord['id'];
//         				$checkIfUserSupport = "select id from zy_user_product_favorite where product_id = $articleId and user_id=$userId";
        
//         				$resultCheck = $dbOperation->queryBySql($checkIfUserSupport);
//         				if ($resultCheck) {
//         					$currentRecord['isFavorited']="1";
//         				}else{
//         					$currentRecord['isFavorited']="0";
//         				}
//         				$currentRecord = next($value);
        
//         			}
//         		}
//         	}
        
        	echo $resultArr;
        
        	return ;
        }
        
        $truePageIndex = ($pageIndex-1)>=0? $pageIndex-1:$pageIndex;
        $startIndex = $truePageIndex*$pageSize;
        
        //查询
        $dbOperation = new Class_DBOperation(DataBaseConfig::$dbhost,DataBaseConfig::$username,DataBaseConfig::$password,$appId,DataBaseConfig::$charset);
         
        $sql = "select id,title,summary,support_count,images from zy_product order by id desc limit $startIndex,$pageSize";
        
        $resultArr = $dbOperation->queryAllBySql($sql);
        
        //是否已经收藏过这个图片,加重服务器负担
//         $currentRecord = current($resultArr);
//         while ($currentRecord){
        
//         	$checkIfUserSupport = "select id from zy_user_product_favorite where product_id = $currentRecord->id and user_id=$userId";
        
//         	$resultCheck = $dbOperation->queryBySql($checkIfUserSupport);
//         	if ($resultCheck) {
//         		$currentRecord->isFavorited="1";
//         	}else{
//         		$currentRecord->isFavorited="0";
//         	}
//         	$currentRecord = next($resultArr);
//         }
        
        $jsonArr = array('status'=>'1','data'=>$resultArr);
        
        echo json_encode($jsonArr);
        
        //缓存数据
        $cacheManager->cacheProductNewList($categoryId, $tabTypeId,$pageIndex,$jsonArr);
    }
    
    /*
     * 获取产品详情
     * @param productId,appId
     */
    public function actionProductDetail(){
        
        
        $productId = $_GET['productId'];
        $appId = $_GET['appId'];
        $userId = $_GET['userId'];
        
        if($productId == NULL || $appId==NULL || $userId==NULL){
            
            $resultArr = array('status'=>'0','msg'=>'参数缺失');
            
            echo json_encode($resultArr);
            
            return;
        }
        
        //查询
        $dbOperation = new Class_DBOperation(DataBaseConfig::$dbhost,DataBaseConfig::$username,DataBaseConfig::$password,$appId,DataBaseConfig::$charset);
        
        //是否存在缓存
        $cacheManager = new CacheManager($appId);
        $isCached = $cacheManager->isProductDetailCacheExist($productId);
        if($isCached){
        
        	$cacheObj = $cacheManager->returnProductDetailCache($productId);
        
        	//是否已经收藏过该产品
        	//查询是否收藏该文章
        	$checkFavorite = "select id from zy_user_product_favorite where product_id=$productId and user_id=$userId";
        	$checkResult = $dbOperation->queryBySql($checkFavorite);
        	$resultType = $checkResult?  1:0;
        	$cacheObj['data']['isFavorited']=$resultType;
        	        	
        	echo json_encode($cacheObj);
        
        	return ;
        }
        
        
        $sql = "select * from zy_product where id=$productId";
        
        $resultObj = $dbOperation->queryBySql($sql);
        
        //是否已经收藏过该产品
        //查询是否收藏该文章
        $checkFavorite = "select id from zy_user_product_favorite where product_id=$productId and user_id=$userId";
        $checkResult = $dbOperation->queryBySql($checkFavorite);
        $resultType = $checkResult?  1:0;
        $resultObj->isFavorited=$resultType;
        
        if($resultObj){
            
            $resultArr = array('status'=>'1','data'=>$resultObj);
            
            echo json_encode($resultArr);
            
            //缓存
            $cacheManager->cacheProductDetail($productId,$resultArr);
            
        }else{
            
            $resultArr = array ('status'=>'0','msg'=>'查询失败');
            
            echo json_encode($resultArr);
            
        }
        
    }
    
    /*
     * 产品评论
     */
    public function actionProductCommentList(){
        
            $pictureId = $_GET['productId'];
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
            $dbOperation = new Class_DBOperation(DataBaseConfig::$dbhost,DataBaseConfig::$username,DataBaseConfig::$password,$productId,DataBaseConfig::$charset);
            
            //文章是否还存在
            $checkSql = "select id from zy_product where id=$pictureId";
            $checkResult = $dbOperation->queryAllBySql($checkSql);
            if(!$checkResult){
                $resultArr = array('status'=>'0','msg'=>'产品已经被删除');
                echo json_encode($resultArr);
                return;
            }
            
            $truePageIndex = ($pageIndex-1)>=0? $pageIndex-1:$pageIndex;
            $startIndex = $truePageIndex*$pageSize;
            $sql = "select zy_product_comment.*,zy_user.login_name,zy_user.nick_name,zy_user.location from zy_product_comment inner join zy_user on zy_product_comment.create_user = zy_user.id where product_id=$pictureId order by comment_id desc limit $startIndex,$pageSize";
            
            $commentArr = $dbOperation->queryAllBySql($sql);
            
            //是否已经支持
            $newResultArray = array();
            $currentRecord = current($commentArr);
            while ($currentRecord){
            	 
            	$currentCommentId = $currentRecord->comment_id;
            	$checkIfUserSupport = "select id from zy_product_comment_support where comment_id = $currentCommentId and user_id=$userId";
            	 
            	$resultCheck = $dbOperation->queryBySql($checkIfUserSupport);
            	if ($resultCheck) {
            		$currentRecord->isSupported="1";
            	}else{
            		$currentRecord->isSupported="0";
            	}
            	$newResultArray[]=$currentRecord;
            	 
            	$currentRecord = next($commentArr);
            }
            
            $resultArr = array('status'=>'1','data'=>$newResultArray);
            
            echo json_encode($resultArr);
        
    }
    
    /*
     * 评论该产品
     */
    public function actionCommentProduct(){
        
            $pictureId = $_GET['productId'];
            $productId = $_GET['appId'];
            $content = $_GET['content'];
            $userId  = $_GET['userId'];
            $userActiveOpen = $_GET['userActiveOpen'];
            
            if(!$pictureId || !$productId || !$content || !$userId){
                
                $resultArr = array('status'=>'0','msg'=>'参数缺失');
            
                echo json_encode($resultArr);
            
                return; 
            }
            
            $create_time = date('y-m-d H:i:s');
            
            $dbOperation = new Class_DBOperation(DataBaseConfig::$dbhost,DataBaseConfig::$username,DataBaseConfig::$password,$productId,DataBaseConfig::$charset);
            //文章是否还存在
            $checkSql = "select id from zy_product where id=$pictureId";
            $checkResult = $dbOperation->queryAllBySql($checkSql);
            if(!$checkResult){
                $resultArr = array('status'=>'0','msg'=>'产品已经被删除');
                echo json_encode($resultArr);
                return;
            }
            
            $insertSql = "insert into zy_product_comment(product_id,create_user,content,create_time)values($pictureId,$userId,'$content','$create_time')";            
            $insertResult = $dbOperation->saveBySql($insertSql);
            
            if($insertResult){
                
                $resultArr = array('status'=>'1','msg'=>'评论成功');
                
                //为该文章增加一条评论数
                $updateSql = "update zy_product set comment_count=comment_count+1 where id=$pictureId";
                $updateResult = $dbOperation->saveBySql($updateSql);
                if($updateResult){
                    
                }
            
                echo json_encode($resultArr);
            
                //插入一条活动纪录
                $activeRecordManager = new UserActiveRecordManager($productId,$userActiveOpen);
                $activeRecordManager->createAnProductCommentRecord($content,$userId,'','',$pictureId);

                return;
                
            }else{
                
                $resultArr = array('status'=>'0','msg'=>'评论失败');
            
                echo json_encode($resultArr);
            
                return;
            }
        
    }
    
    /*
     * 收藏该图片
     */
    public function actionFavoriteProduct(){
        
            $articleId = $_GET['productId'];
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
            $favoriteExistSql = "select id from zy_user_product_favorite where product_id=$articleId and user_id=$userId";
            $favoriteExist = $dbOperation->queryBySql($favoriteExistSql);
            if($favoriteExist){
              
                $resultArr = array('status'=>'0','msg'=>'已经收藏过该产品');
                
                echo json_encode($resultArr);
                
                return;
                
            } 
            
            
            $insertSql = "insert into zy_user_product_favorite(product_id,user_id,add_time)values($articleId,$userId,'$create_time')";            
            $insertResult = $dbOperation->saveBySql($insertSql);
            
            if($insertResult){
                
                $resultArr = array('status'=>'1','msg'=>'收藏成功');
            
                //文章收藏数加1
                $updateFavoriteSql = "update zy_product set favorite_count=favorite_count+1 where id=$articleId";
                $dbOperation->saveBySql($updateFavoriteSql);
                
                echo json_encode($resultArr);
            
                //插入一条活动纪录
               	$activeRecordManager = new UserActiveRecordManager($productId,$userActiveOpen);
                $activeRecordManager->createFavProductRecord('',$userId,'','',$articleId);

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
    public function actionRemoveFavoriteProduct(){
        
        $articleId = $_GET['productId'];
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
            $favoriteExistSql = "select id from zy_user_product_favorite where product_id=$articleId and user_id=$userId";
            $favoriteExist = $dbOperation->queryBySql($favoriteExistSql);
            if(!$favoriteExist){
              
                $resultArr = array('status'=>'0','msg'=>'你没有收藏过该图片');
                
                echo json_encode($resultArr);
                
                return;
                
            } 
            
            
            $insertSql = "delete from zy_user_product_favorite where product_id = $articleId and user_id = $userId";            
            $insertResult = $dbOperation->saveBySql($insertSql);
            
            if($insertResult){
                
                $resultArr = array('status'=>'1','msg'=>'取消成功');
            
                //文章收藏数加1
                $updateFavoriteSql = "update zy_product set favorite_count=favorite_count-1 where id=$articleId";
                $dbOperation->saveBySql($updateFavoriteSql);
                
                echo json_encode($resultArr);
            
                //插入一条活动纪录
                $activeRecordManager = new UserActiveRecordManager($productId,$userActiveOpen);
                $activeRecordManager->createUnFavProductRecord('',$userId,'','',$articleId);
                
                
                return;
                
            }else{
                
                $resultArr = array('status'=>'0','msg'=>'取消失败');
            
                echo json_encode($resultArr);
            
                return;
            }
        
    }
    
    /*
     * 查询是否收藏过某个产品
     */
    public function actionIsFavoriteProduct(){
        
        $articleId = $_GET['productId'];
            $productId = $_GET['appId'];
            $userId  = $_GET['userId'];
            
            if(!$articleId || !$productId || !$userId){
                
                $resultArr = array('status'=>'0','msg'=>'参数缺失');
            
                echo json_encode($resultArr);
            
                return; 
            }
                        
            $dbOperation = new Class_DBOperation(DataBaseConfig::$dbhost,DataBaseConfig::$username,DataBaseConfig::$password,$productId,DataBaseConfig::$charset);
            
            //不允许重复收藏
            $favoriteExistSql = "select id from zy_user_product_favorite where product_id=$articleId and user_id=$userId";
            $favoriteExist = $dbOperation->queryBySql($favoriteExistSql);
            if(!$favoriteExist){
              
                $resultArr = array('status'=>'0','msg'=>'你没有收藏过该图片');
                
                echo json_encode($resultArr);
                
                return;
                
            }else{
                
               $resultArr = array('status'=>'1','msg'=>'你收藏过该图片');
                
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
               $userActiveOpen = $_GET['userActiveOpen'];
                
               if($appId==NULL || $commentId == NULL || $userId==NULL){
                   $resultArr = array('status'=>'0','msg'=>'参数缺失');
            
                    echo json_encode($resultArr);
            
                    return;
               }
                    
            $dbOperation = new Class_DBOperation(DataBaseConfig::$dbhost,DataBaseConfig::$username,DataBaseConfig::$password,$appId,DataBaseConfig::$charset);
            
            //是否已经支持过了
            $sqlCheck = "select id from zy_product_comment_support where comment_id=$commentId and user_id=$userId";
             
            $checkResult = $dbOperation->queryBySql($sqlCheck);
             
            if($checkResult){
            	 
            	$josnArr = array('status'=>'0','msg'=>'已经支持过了');
            	 
            	echo json_encode($josnArr);
            	 
            	return ;
            }
            
            $sqlInsert = "insert into zy_product_comment_support(comment_id,user_id)values($commentId,$userId)";
            
            $inserResult = $dbOperation->saveBySql($sqlInsert);
            
            if($inserResult){
                $sql = "update zy_product_comment set support_count=support_count+1 where comment_id = $commentId";
                $resultObj = $dbOperation->saveBySql($sql);
                
                if($resultObj){
                   $josnArr = array('status'=>'1','data'=>'支持成功');
                   echo json_encode($josnArr);
                   
                   //插入一条活动纪录
                	$sql = "select content,product_id from zy_product_comment where comment_id = $commentId";
                   	$resultObj = $dbOperation->queryBySql($sql);
                   	if($resultObj){
                   		$activeRecordManager = new UserActiveRecordManager($appId,$userActiveOpen);
                   		$activeRecordManager->createSupportAnProductCommentRecord($resultObj->content,$userId,'','',$resultObj->product_id);
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
            
            $sqlDelete = "delete from zy_product_comment_support where user_id=$userId and comment_id=$commentId";
            
            $deleteResult = $dbOperation->saveBySql($sqlDelete);
            
            if($deleteResult){
                $sql = "update zy_product_comment set support_count=support_count-1 where comment_id = $commentId";
            
                $resultObj = $dbOperation->saveBySql($sql);
            
                if($resultObj){
                   $josnArr = array('status'=>'1','data'=>'支持成功');
                   echo json_encode($josnArr);
                   
                   //插入一条活动纪录
                	$sql = "select content,product_id from zy_product_comment where comment_id = $commentId";
                   	$resultObj = $dbOperation->queryBySql($sql);
                   	if($resultObj){
                   		$activeRecordManager = new UserActiveRecordManager($appId,$userActiveOpen);
                   		$activeRecordManager->createUnSupportAnProductCommentRecord($resultObj->content,$userId,'','',$resultObj->product_id);
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
         * 查询某个产品下面得所有Category分类
         */
        public function actionTabTypesByCategoryId(){
        	
        	$productId = $_GET['appId'];
        	$categoryId = $_GET['categoryId'];
        	 
        	if($productId==NULL||$categoryId==NULL){
        	
        		$resultArr = array('status'=>'0','msg'=>'参数缺失');
        	
        		echo json_encode($resultArr);
        	
        		return;
        	}
        	
        	//是否有缓存
        	$cacheManager = new CacheManager($productId);
        	$isCached = $cacheManager->isProductTabTypesCacheExist($categoryId);
        	if($isCached){
        	
        		$resultArr = $cacheManager->returnProductTabTypes($categoryId);
        	
        		echo $resultArr;
        	
        		return ;
        	}
        	 
        	$dbOperation = new Class_DBOperation(DataBaseConfig::$dbhost,DataBaseConfig::$username,DataBaseConfig::$password,$productId,DataBaseConfig::$charset);
        	
        	$sqlCheck="select * from zy_product_tab_type where category_id = $categoryId";
        	 
        	$resultArr = $dbOperation->queryAllBySql($sqlCheck);
        	 
        	if ($resultArr) {
        	
        		$jsonArr = array('status'=>'1','data'=>$resultArr);
        	
        		echo json_encode($jsonArr);
        	
        		//缓存
        		$cacheManager->cacheProductTabTypes($categoryId,$jsonArr);
        		
        		return ;
        	
        	}else{
        	
        		$jsonArr = array('status'=>'0','msg'=>'服务器繁忙');
        	
        		echo json_encode($jsonArr);
        	
        		return ;
        	}
        	
        }
        
}

?>
