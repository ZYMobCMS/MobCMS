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
                $dbOperation = new class_DBOperation(DataBaseConfig::$dbhost,DataBaseConfig::$username,DataBaseConfig::$password,$appName,DataBaseConfig::$charset);
		$sql = "select login_name from zy_user where login_name='$loginName'";
                $userExist = $dbOperation->queryBySql($sql);                
                
		if($userExist){
				
			$resultArr = array('status'=>'0','msg'=>'用户已存在');
				
			echo json_encode($resultArr);
				
			return ;
				
		}else{
			
                        $insertSql = "insert into zy_user(login_name,password)values('$loginName','$password')";
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
                $dbOperation = new class_DBOperation(DataBaseConfig::$dbhost,DataBaseConfig::$username,DataBaseConfig::$password,$appName,DataBaseConfig::$charset);
		$sql = "select * from zy_user where login_name='$loginName'";
                $userExist = $dbOperation->queryBySql($sql);               
	
		if(!$userExist){
				
			$resultArr = array('status'=>'0','msg'=>'用户不存在');
				
			echo json_encode($resultArr);
				
			return ;
				
		}else{
				
			if($userExist->password == $this->enypt($password)){
	
				$resultArr = array('status'=>'1','data'=>$userExist);
	
				echo json_encode($resultArr);
	
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
            
            $dbOperation = new class_DBOperation(DataBaseConfig::$dbhost,DataBaseConfig::$username,DataBaseConfig::$password,$appId,DataBaseConfig::$charset);

            $truePageIndex = ($pageIndex-1)>=0? $pageIndex-1:$pageIndex;
            $startIndex = $truePageIndex*$pageSize;
            
            $sql = "select zy_user_favorite.*,zy_article.title,zy_article.summary,zy_article.publish_time,zy_article.source,zy_article.images from zy_user_favorite inner join zy_article on zy_article.id=zy_user_favorite.article_id  where user_id=$userId limit $startIndex,$pageSize";
            
            $resultArr = $dbOperation->queryAllBySql($sql);
            
            $jsonArr = array('status'=>'1','data'=>$resultArr);
            
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
            
            $dbOperation = new class_DBOperation(DataBaseConfig::$dbhost,DataBaseConfig::$username,DataBaseConfig::$password,$appId,DataBaseConfig::$charset);

            $truePageIndex = ($pageIndex-1)>=0? $pageIndex-1:$pageIndex;
            $startIndex = $truePageIndex*$pageSize;
            
            $sql = "select zy_comment.*,zy_article.title,zy_article.publish_time,zy_article.source from zy_comment inner join zy_article on zy_comment.article_id=zy_article.id where create_user=$userId limit $startIndex,$pageSize";
            
            $resultArr = $dbOperation->queryAllBySql($sql);
            
            $jsonArr = array('status'=>'1','data'=>$resultArr);
            
            echo json_encode($jsonArr);
            
        }
}

?>