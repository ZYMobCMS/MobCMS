<?php

class UserController extends Controller {
	
	/**
	 * 注册接口
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
	
		if(!$this->validateParams($loginName, $password)){
			return ;
		}
	
		//检查是否已经存在用户
		$userExist = User::model()->findByAttributes(array('login_name'=>$loginName));
	
		if($userExist){
				
			$resultArr = array('status'=>'0','msg'=>'用户已存在');
				
			echo json_encode($resultArr);
				
			return ;
				
		}else{
				
			$newUser = new User();
			$newUser->login_name = $loginName;
			$newUser->password = $password;
				
			$rigistResult = $newUser->save();
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
	 * @params $loginName ,$password
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
	
		if(!$this->validateParams($loginName, $password)){
			return ;
		}
	
		$userExist = User::model()->findByAttributes(array('login_name'=>$loginName));
	
		if(!$userExist){
				
			$resultArr = array('status'=>'0','msg'=>'用户不存在');
				
			echo json_encode($resultArr);
				
			return ;
				
		}else{
				
			if($userExist->validatePassword($password)){
	
				$resultArr = array('status'=>'1','msg'=>'登陆成功');
	
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
	
}

?>