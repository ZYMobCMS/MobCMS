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
    
    /*
     * 产品评论
     */
    public function actionProductCommentList(){
        
            $pictureId = $_GET['productId'];
            $productId = $_GET['appId'];
            $pageIndex = $_GET['pageIndex'];
            $pageSize  = $_GET['pageSize'];
            
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
            $checkSql = "select id from zy_product where id=$pictureId";
            $checkResult = $dbOperation->queryAllBySql($checkSql);
            if(!$checkResult){
                $resultArr = array('status'=>'0','msg'=>'产品已经被删除');
                echo json_encode($resultArr);
                return;
            }
            
            $truePageIndex = ($pageIndex-1)>=0? $pageIndex-1:$pageIndex;
            $startIndex = $truePageIndex*$pageSize;
            $sql = "select zy_product_comment.*,zy_user.login_name,zy_user.nick_name,zy_user.location from zy_product_comment inner join zy_user on create_user = id where product_id=$pictureId limit $startIndex,$pageSize";
            
            $commentArr = $dbOperation->queryAllBySql($sql);
            
            $resultArr = array('status'=>'1','data'=>$commentArr);
            
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
            
            if(!$pictureId || !$productId || !$content || !$userId){
                
                $resultArr = array('status'=>'0','msg'=>'参数缺失');
            
                echo json_encode($resultArr);
            
                return; 
            }
            
            $create_time = date('y-m-d h:i:s');
            
            $dbOperation = new class_DBOperation(DataBaseConfig::$dbhost,DataBaseConfig::$username,DataBaseConfig::$password,$productId,DataBaseConfig::$charset);
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
            
            if(!$articleId || !$productId || !$userId){
                
                $resultArr = array('status'=>'0','msg'=>'参数缺失');
            
                echo json_encode($resultArr);
            
                return; 
            }
            
            $create_time = date('y-m-d h:i:s');
            
            $dbOperation = new class_DBOperation(DataBaseConfig::$dbhost,DataBaseConfig::$username,DataBaseConfig::$password,$productId,DataBaseConfig::$charset);
            
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
            
            if(!$articleId || !$productId || !$userId){
                
                $resultArr = array('status'=>'0','msg'=>'参数缺失');
            
                echo json_encode($resultArr);
            
                return; 
            }
                        
            $dbOperation = new class_DBOperation(DataBaseConfig::$dbhost,DataBaseConfig::$username,DataBaseConfig::$password,$productId,DataBaseConfig::$charset);
            
            //不允许重复收藏
            $favoriteExistSql = "select id from zy_user_product_favorite where product_id=$articleId and user_id=$userId";
            $favoriteExist = $dbOperation->queryBySql($favoriteExistSql);
            if(!$favoriteExist){
              
                $resultArr = array('status'=>'0','msg'=>'你没有收藏过该图片');
                
                echo json_encode($resultArr);
                
                return;
                
            } 
            
            
            $insertSql = "delete from zy_user_product_favorite where product_id = $articleId";            
            $insertResult = $dbOperation->saveBySql($insertSql);
            
            if($insertResult){
                
                $resultArr = array('status'=>'1','msg'=>'取消成功');
            
                //文章收藏数加1
                $updateFavoriteSql = "update zy_product set favorite_count=favorite_count-1 where id=$articleId";
                $dbOperation->saveBySql($updateFavoriteSql);
                
                echo json_encode($resultArr);
            
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
                        
            $dbOperation = new class_DBOperation(DataBaseConfig::$dbhost,DataBaseConfig::$username,DataBaseConfig::$password,$productId,DataBaseConfig::$charset);
            
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
    
}

?>
