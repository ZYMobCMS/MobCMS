<?php


/*
 * 
 */

class class_DBOperation{	
	
	private $host;
	private $user_name;
	private $user_pwd;
	private $dest_db;
	private $charset;
	
	
	function class_DBOperation($host,$user,$pwd,$db,$charset){
	
		//
		$this->host = $host;
		$this->user_name = $user;
		$this->user_pwd = $pwd;
		$this->dest_db = $db;
		$this->charset = $charset;
			
		//
		if (!mysql_connect($this->host,$this->user_name,$this->user_pwd)){
			echo '�޷�����������';
			exit();
		}
	
		
		$conn = mysql_connect($this->host,$this->user_name,$this->user_pwd) or die('������Ϣ'.mysql_error());
	
		
		mysql_select_db($this->dest_db,$conn)or die('������Ϣ'.mysql_error());
	
		//�����ַ�
		mysql_query("set names utf8") or die('������Ϣ'.mysql_error());
	}
	function __call($function_name, $args)
	{
		echo "<br><font color=#ff0000>������õķ��� $function_name ������</font><br>\n";
	}
	//ִ��sql��䷽��
	function  query($sql){
		$result = mysql_query($sql)or die('������Ϣ'.mysql_error());
		return $result;
	} 
	
	function queryByPk($table,$params){
		
		if(!is_array($params) || count($params)>1 || !$table){
			return ;
		}
		
		//
		$paramString = "";
		for($i = 0,$n=count($params);$i<$n;$i++){
				
			$keyValue = key($params[$i]);
		
			if($i!=$n-1){
				$paramString = $paramString."$keyValue=$params[$i] and";
			}else{
				$paramString = $paramString."$keyValue=$params[$i]";
			}
		}
		$sqlString = "select * from $table where $paramString";
		
		$queryResult = $this->query($sqlString);
		$resultObj = $this->fetch_obj($queryResult);
		
		return $resultObj;
	}
	
	function queryByAttributes($table,$params){
		
		if(!is_array($params) || !$table || !$params){
			return ;
		}
		
		//
		$paramString = "";
		for($i = 0,$n=count($params);$i<$n;$i++){
			
			$keyValue = key($params[$i]);
				
			if($i!=$n-1){
				$paramString = $paramString."$keyValue=$params[$i] and";
			}else{
				$paramString = $paramString."$keyValue=$params[$i]";
			}
		}
		$sqlString = "select * from $table where $paramString";
		
		$resultArr = $this->fetch_obj_arr($sqlString);
		
		return $resultArr;
	}
	
	function saveAttributes($table,$isNewRecord,$attributes,$keyattributes){
		
		if(!$attributes || !is_array($attributes) || !$table || !$keyattributes || !is_array($keyattributes)){
			return ;
		}
		
		if($isNewRecord){
			
                    //
                    $properties = "";
                    $vaules = "";
                    for($i=0,$n=count($attributes);$i<$n;$i++){
                        
                        $property = key($attributes[$i]);
                        
                        if($i!=$n-1){
                            
                            $properties = $properties."$property,";
                            $vaules = $vaules."$attributes[$i],";

                        }else{
                            
                            $properties = $properties.$property;
                            $vaules = $vaules.$attributes[$i];
                        }
                    }
			
                    //
                    $insertSql = "insert $table($properties)value($values)";
                    $insertResult = $this->query($insertSql);
                    
                    if($insertResult){
                        
                    }else{
                        
                    }
                    
			
		}else{
		
                   //
                   $paramString = "";
                    for($i = 0,$n=count($attributes);$i<$n;$i++){
			
                            $keyValue = key($attributes[$i]);
				
                            if($i!=$n-1){
				$paramString = $paramString."$keyValue=$attributes[$i] and";
                            }else{
				$paramString = $paramString."$keyValue=$attributes[$i]";
                            }
                    } 
                    
                    //
                    $pk = key($keyattributes[0]);
                    $updateSql = "update $table set $paramString where $pk=$keyattributes[0]";
                    
                    $updateResult = $this->query($updateSql);
                
                    if($updateResult){
                    
                    }else{
                    
                    }
                    
                    
                }
		
	}
	
	function  fetch_array($sql){
		$result = mysql_query($sql) or die('������Ϣ'.mysql_error());
		$result_arry = mysql_fetch_array($result);
		return $result_arry;
	}
	function fetch_obj_arr($sql)
	{
		$obj_arr=array();
		$res=$this->query($sql);
		while($row=mysql_fetch_object($res))
		{
			$obj_arr[]=$row;
		}
		return $obj_arr;
	}
	function fetch_obj($result){
		return mysql_fetch_object($result);
	}
}
?>