<?php


/*
 * 数据库操作基础类
 * 作者: 胡涛
 * 创建时间:2012年3月15日
 * 修改时间:2013年7月29日
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
			die('数据库链接失败'.mysql_errno()) ;
			exit();
		}
	
		
		$conn = mysql_connect($this->host,$this->user_name,$this->user_pwd) or die('数据库链接失败'.mysql_error());
	
		
		mysql_select_db($this->dest_db,$conn)or die('数据库选择失败'.mysql_error());
	
		//设置字符集
		mysql_query("set names utf8") or die('数据库字符集设置失败'.mysql_error());
	}
	function __call($function_name, $args)
	{
		echo "<br><font color=#ff0000>成功调用方法 $function_name /font><br>\n";
	}
	//ִ执行查询
	function  query($sql){
		$result = mysql_query($sql)or die('数据库查询失败'.mysql_error());
                
                
		return $result;
	} 
	
	function queryByPk($table,$params){
		
		if(!is_array($params) || count($params)>1 || !$table){
			return FALSE;
		}
                		
		//
                $pk = "";
                $pkValue = "";
		foreach ($params as $key=>$value){
				
			$pk = $key;
            $pkValue = $value;
                        
		}
		if(is_string($pkValue)){
			echo 'is pkValue string !';
		}
		
		$sqlString = "select * from $table where $pk = $pkTypeValue";
		
		echo $sqlString;
		
		$queryResult = $this->query($sqlString);
                                
		$resultObj = $this->fetch_obj($queryResult);
		                
		return $resultObj;
	}
	
        function queryValuesByConditions($table,$params,$properties,$startIndex,$pageSize){
            
            if(!is_array($params) || !$table || !$params || !is_array($properties) || !$properties || $startIndex<0){
			return FALSE;
            }
                        
                //
		$paramString = "";
                $n = count($params);
                $i = 0;
		foreach ($params as $key=>$value){
			
			if($i!=$n-1){
				$paramString = $paramString."$key='$value' and";
			}else{
				$paramString = $paramString."$key='$value'";
			}
                        $i=$i+1;
		}
                
                $propertyString = "";
                $pn = count($properties);
                $pi = 0;
                foreach ($properties as $key){
                    
                   if($pi!=$pn-1){
                            
                       $propertyString = $propertyString."$key,";

                   }else{
                            
                       $propertyString = $propertyString.$key;
                   }
                   $pi++; 
                }
                
		$sqlString = "select $propertyString from $table where $paramString limit $startIndex,$pageSize";
		
		$resultArr = $this->fetch_obj_arr($sqlString);
		
		return $resultArr;
                
        }
                
        function queryValuesByAttributes($table,$params,$properties){
            
            if(!is_array($params) || !$table || !$params || !is_array($properties) || !$properties){
			return FALSE;
		}
            
                //
		$paramString = "";
                $n = count($params);
                $i = 0;
		foreach ($params as $key=>$value){
			
			if($i!=$n-1){
				$paramString = $paramString."$key='$value' and";
			}else{
				$paramString = $paramString."$key='$value'";
			}
                        $i=$i+1;
		}
                
                $propertyString = "";
                $pn = count($properties);
                $pi = 0;
                foreach ($properties as $key){
                    
                   if($pi!=$pn-1){
                            
                       $propertyString = $propertyString."$key,";

                   }else{
                            
                       $propertyString = $propertyString.$key;
                   }
                   $pi++; 
                }
                
		$sqlString = "select $propertyString from $table where $paramString";
		
		$resultArr = $this->fetch_obj_arr($sqlString);
		
		return $resultArr;
            
        }
                
        function queryAllByAttributes($table,$params){
            
            if(!is_array($params) || !$table || !$params){
				return FALSE;
			}
		
		//
		$paramString = "";
        $n = count($params);
        $i = 0;
		foreach ($params as $key=>$value){
			
			if($i!=$n-1){
				$paramString = $paramString."$key='$value' and ";
			}else{
				$paramString = $paramString."$key='$value'";
			}
            $i=$i+1;
		}
		$sqlString = "select * from $table where $paramString";
		echo '<br>';
		echo $sqlString;
		$resultArr = $this->fetch_obj_arr($sqlString);
		
		return $resultArr;
        }
                
	function queryByAttributes($table,$params){
		
		if(!is_array($params) || !$table || !$params){
			return FALSE;
		}
		
		//
		$paramString = "";
                $n = count($params);
                $i = 0;
		foreach ($params as $key=>$value){
			
			if($i!=$n-1){
				$paramString = $paramString."$key='$value' and";
			}else{
				$paramString = $paramString."$key='$value'";
			}
                        $i=$i+1;
		}
		$sqlString = "select * from $table where $paramString";
		
		$resultArr = $this->fetch_obj($sqlString);
		
		return $resultArr;
	}
        
        function queryAllBySql($sql){
            
            $queryResult = $this->query($sql);
            $resultArr = $this->fetch_obj_arr($queryResult);
            
            return $resultArr;
        }
        
        function queryBySql($sql){
            
            $queryResult = $this->query($sql);
            $resultObj = $this->fetch_obj($queryResult);
            
            return $resultObj;
        }
                
	function saveAttributes($table,$isNewRecord,$attributes,$keyattributes){
		
		if(!$attributes || !is_array($attributes) || !$table){
			return  FALSE;
		}
                		
		if($isNewRecord){
			
                    //
                    $properties = "";
                    $vaules = "";
                    $n = count($attributes);
                    $i = 0;
                    foreach ($attributes as $property=>$value){
                        
  
                        if($i!=$n-1){
                            
                            $properties = $properties."$property,";
                            $vaules = $vaules."'$value',";

                        }else{
                            
                            $properties = $properties.$property;
                            $vaules = $vaules."'$value'";
                        }
                        $i++;
                    }
			
                    //
                    $insertSql = "insert into $table($properties) values($vaules)";

                    $insertResult = $this->query($insertSql);
                    
                    
                    if($insertResult){
                        
                        return TRUE;
                    }else{
                        return FALSE; 
                    }
                    
			
		}else{
		
                    if(!$keyattributes || !is_array($keyattributes)){
                        return FALSE;
                    }
                    
                   //
                   $paramString = "";
                   $n = count($attributes);
                   $i = 0;
                   foreach ($attributes as $key=>$value){
			
                            if($i!=$n-1){
				$paramString = $paramString."$key='$value' and";
                            }else{
				$paramString = $paramString."$key='$value'";
                            }
                            $i++;
                    } 
                    
                    //
                    $pk = key($keyattributes[0]);
                    $pkValue = current($keyattributes[0]);
                    $updateSql = "update $table set $paramString where '$pk'='$pkValue'";
                    
                    $updateResult = $this->query($updateSql);
                
                    if($updateResult){
                        return TRUE;
                    }else{
                        return FALSE;
                    }
                    
                    
                }
		
	}
	
	function  fetch_array($sql){
		$result = mysql_query($sql) or die('返回查询数组失败'.mysql_error());
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