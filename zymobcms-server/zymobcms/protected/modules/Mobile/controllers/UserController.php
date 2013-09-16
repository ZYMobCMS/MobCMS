<?php

class UserController extends Controller {
	
    
        /**
	 * 注册接口
         * @params loginName,password,productId
	 */
	public function actionRigist(){
	
		/**
		 * 检验参数有效性
		 */
		if(!isset($_GET['loginName']) || !isset($_GET['password'])){
				
			$resultArr = array('status'=>'0','msg'=>'用户名或密码缺失');
	
			echo json_encode($resultArr);
	
			return ;
		}
	
		//接收参数
		$loginName = $_GET['loginName'];
		$password = $_GET['password'];
		$appName = $_GET['appId'];
	
		if(!$this->validateParams($loginName, $password)){
			return ;
		}
	
		//检查是否已经存在用户
                $dbOperation = new Class_DBOperation(DataBaseConfig::$dbhost,DataBaseConfig::$username,DataBaseConfig::$password,$appName,DataBaseConfig::$charset);
		$sql = "select login_name from zy_user where login_name='$loginName'";
                $userExist = $dbOperation->queryBySql($sql);                
                
		if($userExist){
				
			$resultArr = array('status'=>'0','msg'=>'用户已存在');
				
			echo json_encode($resultArr);
				
			return ;
				
		}else{
			
			$enypassword = $this->enypt($password);
                        $insertSql = "insert into zy_user(login_name,password,user_type_id)values('$loginName','$enypassword',1)";
                        $rigistResult = $dbOperation->saveBySql($insertSql);
			if($rigistResult){
	
				$resultArr = array('status'=>'1','msg'=>'注册成功');
	
				echo json_encode($resultArr);
	
				return ;
			}else{
	
				$resultArr = array('status'=>'0','msg'=>'注册失败，服务器忙');
	
				echo json_encode($resultArr);
	
				return ;
	
			}
				
		}
	
	}
	
	/**
	 * 用户登陆
	 * @params $loginName ,$password,productId
	 */
	public function actionLogin(){
	
		/**
		 * 检测参数有效性
		 */
		if(!isset($_GET['loginName']) || !isset($_GET['password'])){
	
			$resultArr = array('status'=>'0','msg'=>'用户名或密码缺失');
	
			echo json_encode($resultArr);
	
			return ;
		}
	
		//接收参数
		$loginName = $_GET['loginName'];
		$password = $_GET['password'];
		$appName = $_GET['appId'];
	
		if(!$this->validateParams($loginName, $password)){
                                    
                	return ;
		}
	
		//检查是否已经存在用户
        $dbOperation = new Class_DBOperation(DataBaseConfig::$dbhost,DataBaseConfig::$username,DataBaseConfig::$password,$appName,DataBaseConfig::$charset);
		$sql = "select zy_user.*,zy_user_type.type_name from zy_user inner join zy_user_type on zy_user.user_type_id = zy_user_type.id where login_name='$loginName'";
        $userExist = $dbOperation->queryBySql($sql);               
	
		if(!$userExist){
				
			$resultArr = array('status'=>'0','msg'=>'用户不存在');
				
			echo json_encode($resultArr);
				
			return ;
				
		}else{
				
			if($userExist->password == $this->enypt($password)){
	
				$resultArr = array('status'=>'1','data'=>$userExist);
	
				echo json_encode($resultArr);
				
				//纪录用户操作
				$newUserRecord = new UserActiveRecordManager($appName,'1');
				$newUserRecord->createUserLoginRecord('no','',$userExist->id,$userExist->login_name,$userExist->nick_name);
	
				return ;
	
			}else{
	
				$resultArr = array('status'=>'0','msg'=>'密码错误');
	
				echo json_encode($resultArr);
	
				return ;
	
			}
				
		}
	
	}
	
	/**
	 * 参数合法性
	 */
	private function validateParams($loginName,$password){
	
		//用户名长度
		if (strlen($loginName)>20) {
	
			$resultArr = array('status'=>'0','msg'=>'用户名长度不能超过20');
	
			echo json_encode($resultArr);
	
			return false;
		}
	
		//密码长度
		if(strlen($password)>12){
	
			$resultArr = array('status'=>'0','msg'=>'密码长度不能超过12');
	
			echo json_encode($resultArr);
	
			return false;
		}
	
		return true;
	}
	
        /**
         * MD5 password
         * 
         */
        public function enypt($password){
            return md5($password);
        }
        
        
        /*
         * 用户收藏列表
         * @param user_id,appId
         */
        public function actionFavoriteList(){
            
            $userId = $_GET['userId'];
            $appId = $_GET['appId'];
            $pageIndex = $_GET['pageIndex'];
            $pageSize = $_GET['pageSize'];
            
            if(!$userId || !$appId){
                
                $resultArr = array('status'=>'0','msg'=>'参数缺失');
            
                echo json_encode($resultArr);
            
                return; 
            }
            
            if($pageIndex<0){
                $pageIndex = 0;
            }
            
            if($pageSize>10){
                $pageSize = 10;
            }
            
            $dbOperation = new Class_DBOperation(DataBaseConfig::$dbhost,DataBaseConfig::$username,DataBaseConfig::$password,$appId,DataBaseConfig::$charset);

            $truePageIndex = ($pageIndex-1)>=0? $pageIndex-1:$pageIndex;
            $startIndex = $truePageIndex*$pageSize;
            
            $sql = "select zy_user_favorite.*,zy_article.title,zy_article.summary,zy_article.publish_time,zy_article.source,zy_article.images from zy_user_favorite inner join zy_article on zy_article.id=zy_user_favorite.article_id  where user_id=$userId limit $startIndex,$pageSize";
            
            $resultArr = $dbOperation->queryAllBySql($sql);
            
            if($resultArr){
                $jsonArr = array('status'=>'1','data'=>$resultArr);

            }else{
                $jsonArr = array('status'=>'0','msg'=>'服务器繁忙');

            }
            
            echo json_encode($jsonArr);
            
        }
        
        /*
         * 用户评论列表
         * @param user_id,appId
         */
        public function actionCommentList(){
            
            $userId = $_GET['userId'];
            $appId = $_GET['appId'];
            $pageIndex = $_GET['pageIndex'];
            $pageSize = $_GET['pageSize'];
            
            if(!$userId || !$appId){
                
                $resultArr = array('status'=>'0','msg'=>'参数缺失');
            
                echo json_encode($resultArr);
            
                return; 
            }
            
            if($pageIndex<0){
                $pageIndex = 0;
            }
            
            if($pageSize>10){
                $pageSize = 10;
            }
            
            $dbOperation = new Class_DBOperation(DataBaseConfig::$dbhost,DataBaseConfig::$username,DataBaseConfig::$password,$appId,DataBaseConfig::$charset);

            $truePageIndex = ($pageIndex-1)>=0? $pageIndex-1:$pageIndex;
            $startIndex = $truePageIndex*$pageSize;
            
            $sql = "select zy_comment.*,zy_article.title,zy_article.publish_time,zy_article.source from zy_comment inner join zy_article on zy_comment.article_id=zy_article.id where create_user=$userId order by comment_id desc limit $startIndex,$pageSize";
            
            $resultArr = $dbOperation->queryAllBySql($sql);
            
            $jsonArr = array('status'=>'1','data'=>$resultArr);
            
            echo json_encode($jsonArr);
            
        }
        
        /*
         * 用户图片评论
         */
        public function actionPictureCommentList(){
            
            $userId = $_GET['userId'];
            $appId = $_GET['appId'];
            $pageIndex = $_GET['pageIndex'];
            $pageSize = $_GET['pageSize'];
            
            if(!$userId || !$appId){
                
                $resultArr = array('status'=>'0','msg'=>'参数缺失');
            
                echo json_encode($resultArr);
            
                return; 
            }
            
            if($pageIndex<0){
                $pageIndex = 0;
            }
            
            if($pageSize>10){
                $pageSize = 10;
            }
            
            $dbOperation = new Class_DBOperation(DataBaseConfig::$dbhost,DataBaseConfig::$username,DataBaseConfig::$password,$appId,DataBaseConfig::$charset);

            $truePageIndex = ($pageIndex-1)>=0? $pageIndex-1:$pageIndex;
            $startIndex = $truePageIndex*$pageSize;
            
            $sql = "select zy_picture_comment.*,zy_picture.title,zy_picture.create_time,zy_picture.source,zy_picture.summary,zy_picture.images from zy_picture_comment inner join zy_picture on zy_picture_comment.picture_id=zy_picture.id where zy_picture_comment.create_user=$userId order by comment_id desc limit $startIndex,$pageSize";
            
            $resultArr = $dbOperation->queryAllBySql($sql);
            
            $jsonArr = array('status'=>'1','data'=>$resultArr);
            
            echo json_encode($jsonArr);
            
        }
        
        /*
         * 用户产品评论
         */
        public function actionProductCommentList(){
            
            $userId = $_GET['userId'];
            $appId = $_GET['appId'];
            $pageIndex = $_GET['pageIndex'];
            $pageSize = $_GET['pageSize'];
            
            if(!$userId || !$appId){
                
                $resultArr = array('status'=>'0','msg'=>'参数缺失');
            
                echo json_encode($resultArr);
            
                return; 
            }
            
            if($pageIndex<0){
                $pageIndex = 0;
            }
            
            if($pageSize>10){
                $pageSize = 10;
            }
            
            $dbOperation = new Class_DBOperation(DataBaseConfig::$dbhost,DataBaseConfig::$username,DataBaseConfig::$password,$appId,DataBaseConfig::$charset);

            $truePageIndex = ($pageIndex-1)>=0? $pageIndex-1:$pageIndex;
            $startIndex = $truePageIndex*$pageSize;
            
            $sql = "select zy_product_comment.*,zy_product.title,zy_product.create_time,zy_product.source from zy_product_comment inner join zy_product on zy_product_comment.product_id=zy_product.id where zy_product_comment.create_user=$userId order by comment_id desc limit $startIndex,$pageSize";
            
            $resultArr = $dbOperation->queryAllBySql($sql);
            
            $jsonArr = array('status'=>'1','data'=>$resultArr);
            
            echo json_encode($jsonArr);
            
        }
        
        /*
         * 用户图片收藏列表
         */
        public function actionPictureFavoriteList(){
            
            $userId = $_GET['userId'];
            $appId = $_GET['appId'];
            $pageIndex = $_GET['pageIndex'];
            $pageSize = $_GET['pageSize'];
            
            if(!$userId || !$appId){
                
                $resultArr = array('status'=>'0','msg'=>'参数缺失');
            
                echo json_encode($resultArr);
            
                return; 
            }
            
            if($pageIndex<0){
                $pageIndex = 0;
            }
            
            if($pageSize>10){
                $pageSize = 10;
            }
            
            $dbOperation = new Class_DBOperation(DataBaseConfig::$dbhost,DataBaseConfig::$username,DataBaseConfig::$password,$appId,DataBaseConfig::$charset);

            $truePageIndex = ($pageIndex-1)>=0? $pageIndex-1:$pageIndex;
            $startIndex = $truePageIndex*$pageSize;
            
            $sql = "select zy_user_picture_favorite.*,zy_picture.title,zy_picture.summary,zy_picture.create_time,zy_picture.source,zy_picture.images from zy_user_picture_favorite inner join zy_picture on zy_picture.id=zy_user_picture_favorite.picture_id  where user_id=$userId order by id desc limit $startIndex,$pageSize";
            
            $resultArr = $dbOperation->queryAllBySql($sql);
            
            if($resultArr){
                $jsonArr = array('status'=>'1','data'=>$resultArr);

            }else{
                $jsonArr = array('status'=>'0','msg'=>'服务器繁忙');

            }            
            echo json_encode($jsonArr);
        }
        
        /*
         * 用户产品收藏列表
         */
        public function actionProductFavoriteList(){
            
            $userId = $_GET['userId'];
            $appId = $_GET['appId'];
            $pageIndex = $_GET['pageIndex'];
            $pageSize = $_GET['pageSize'];
            
            if(!$userId || !$appId){
                
                $resultArr = array('status'=>'0','msg'=>'参数缺失');
            
                echo json_encode($resultArr);
            
                return; 
            }
            
            if($pageIndex<0){
                $pageIndex = 0;
            }
            
            if($pageSize>10){
                $pageSize = 10;
            }
            
            $dbOperation = new Class_DBOperation(DataBaseConfig::$dbhost,DataBaseConfig::$username,DataBaseConfig::$password,$appId,DataBaseConfig::$charset);

            $truePageIndex = ($pageIndex-1)>=0? $pageIndex-1:$pageIndex;
            $startIndex = $truePageIndex*$pageSize;
            
            $sql = "select zy_user_product_favorite.*,zy_product.title,zy_product.summary,zy_product.create_time,zy_product.source,zy_product.images from zy_user_product_favorite inner join zy_product on zy_product.id=zy_user_product_favorite.product_id   where user_id=$userId order by id desc limit $startIndex,$pageSize";
            
            $resultArr = $dbOperation->queryAllBySql($sql);
            
            if($resultArr){
                $jsonArr = array('status'=>'1','data'=>$resultArr);

            }else{
                $jsonArr = array('status'=>'0','msg'=>'服务器繁忙');

            }
            
            echo json_encode($jsonArr);
            
        }
        
        /*
         * 保存用户推送token
         */
        public function actionSaveUserDeviceToken(){
            
            $deviceToken = $_GET['token'];
            $deviceType  = $_GET['type'];
            $appId = $_GET['appId'];
            $loginName = $_GET['loginName'];
            
            if($deviceToken==NULL){
                
                $resultArr = array('status'=>'0','msg'=>'参数缺失');
            
                echo json_encode($resultArr);
            
                return; 
            }
            
            if($deviceType==NULL){
                
                $deviceType = 0;
            }
            
            $dbOperation = new Class_DBOperation(DataBaseConfig::$dbhost,DataBaseConfig::$username,DataBaseConfig::$password,$appId,DataBaseConfig::$charset);

            //处理用户token去空格
            $subToken = substr($deviceToken,1,strlen($deviceToken)-2);
            $token = str_replace(' ','',$subToken);
            if($loginName != NULL){
                $insertSql = "insert into zy_device(token,type_id,login_name)value('$token',$deviceType,'$loginName')";

            }else{
                $insertSql = "insert into zy_device(token,type_id)value('$token',$deviceType)";

            }
            
            $saveResult = $dbOperation->saveBySql($insertSql);
            
            if($saveResult){
                
               $jsonArr = array('status'=>'1','data'=>'注册设备成功');
               echo json_encode($jsonArr);
               
            }else{
                $jsonArr = array('status'=>'0','msg'=>'注册设备失败');
                echo json_encode($jsonArr);
            }
            
        }
        
        /*
         * 用户活动记录
         */
        
        
        /*
         * 用户每天活动记录，作为公共主页模块上线
         */
        public function actionUserPublicHome(){
            
            $appId = $_GET['appId'];
            $pageIndex = $_GET['pageIndex'];
            $pageSize = $_GET['pageSize'];
            $userActiveOpen = $_GET['userActiveOpen'];
            
            if($pageSize>10){
            	$pageSize=10;
            }
            $truePageIndex = ($pageIndex-1)>=0? $pageIndex-1:$pageIndex;
            $startIndex = $truePageIndex*$pageSize;
            
            if($appId==NULL){
            	$resultArr = array('status'=>'0','msg'=>'参数缺失');
            	
            	echo json_encode($resultArr);
            	
            	return;
            }
            
            $dbOperation = new Class_DBOperation(DataBaseConfig::$dbhost,DataBaseConfig::$username,DataBaseConfig::$password,$appId,DataBaseConfig::$charset);
            
            $checksql = "select zy_user_active.*,zy_user.login_name,zy_user.nick_name from zy_user_active inner join zy_user on zy_user.id = zy_user_active.create_user where zy_user_active.user_active_open = 1 and zy_user_active.active_type_id in ( select id from zy_active_type where can_show_detail=1) order by id desc limit $truePageIndex,$pageSize";
            
            $recordsArr = $dbOperation->queryAllBySql($checksql);
            
            if($recordsArr){
            	
            	$resultArr = array('status'=>'1','data'=>$recordsArr);
            	 
            	echo json_encode($resultArr);
            	 
            	return;
            	
            }else{
            	$resultArr = array('status'=>'0','msg'=>'获取失败');
            	
            	echo json_encode($resultArr);
            	
            	return;
            }
            
            
        }
        
        /*
         * 用户登出
         */
        public function actionUserLoginOut(){
        	
        	$appId = $_GET['appId'];
        	$userId = $_GET['userId'];
        	$userLoginName = $_GET['loginName'];
        	$userNickName = $_GET['nickName'];
        	
        	if($appId==NULL||$userId==NULL){
        		$resultArr = array('status'=>'0','msg'=>'参数缺失');
        		 
        		echo json_encode($resultArr);
        		 
        		return;
        	}
        	
        	$newUserRecord = new UserActiveRecordManager($appId,1);
        	
        	$newUserRecord->createUserLoginOutRecord('', $userId, $userLoginName, $userNickName);
        	
        }
        
        /*
         * 用户分享纪录接口
         */
        public function actionUserShareRecord(){
        	
        	$appId = $_GET['appId'];
        	$userId = $_GET['userId'];
        	$typeId = $_GET['typeId'];
        	$relationId = $_GET['relationId'];
        	$userActiveOpen = $_GET['userActiveOpen'];
        	
        	$newRecord = new UserActiveRecordManager($appId, $userActiveOpen);
        	switch ($typeId){
        		
        		case 1:
        			{
        				$newRecord->createShareNewsRecord('','',$userId,$relationId,'','');
        			}
        		break;
        		
        		case 2:
        		{
        			$newRecord->createSharePictureRecord('','',$userId,$relationId,'','');
        		}
        		break;
        		
        		case 3:
        			{
        				$newRecord->createShareProductRecord('','',$userId,$relationId,'','');
        			}
        		break;
        		
        		default:
        			{
        				
        			}
        	}
        }
        
}

?>