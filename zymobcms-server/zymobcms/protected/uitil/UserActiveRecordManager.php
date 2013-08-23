<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of UserActiveRecordManager
 *
 * @author barfoo
 */
class UserActiveRecordManager {
    //put your code here
    private $_appId = '';
    private $dbOperation;
    
    public function __construct($appId) {
        $this->_appId = $appId;
        //创建数据库链接
        $this->dbOperation = new class_DBOperation(DataBaseConfig::$dbhost,DataBaseConfig::$username,DataBaseConfig::$password,$this->_appId,DataBaseConfig::$charset);
    }
    
    /*
     * 公共方法，创建一条活动记录
     */
    private function createNewActiveRecordWith($typeId,$content,$createUserId,$relationId,$createLoginName,$createNickName){
        
        if($typeId==NULL||$content==NULL||$createUserId==NULL){
            print '无法记录一条活动，参数不够';
            return;
        }
        
        //找到active_type_id要查询的表
        $findActiveTypeTable = "select relation_table,type_name,type_point where id = $typeId";
        $findResultTable = $findActiveTypeTable->relation_table;
        //如果查到了关联内容的表
        $buildRecordContent = '';
        if($findActiveTypeTable){
            //查找关联的字段创建记录内容
            $findRelation = "select title,images from '$findResultTable' where id='$relationId'";
            
            $findUserInfo = "select id,login_name,nick_name from zy_user where user_id = $createUserId";
            
            $findRelationResult = $this->dbOperation->queryBySql($findRelation);
            $findUserInfoResult = $this->dbOperation->queryBySql($findUserInfo);
            
            //创建活动记录内容
            if($findRelationResult && $findUserInfoResult){
                
                $userName = '';
                if($findUserInfoResult->user_id){
                    $userName = '用户ID('.$findUserInfoResult->user_id.')';
                }
                if($findUserInfoResult->login_name){
                    $userName = '用户名('.$findUserInfoResult->login_name.')';
                }
                if($findUserInfoResult->nick_name){
                    $userName = '用户昵称('.$findUserInfoResult->nick_name.')';
                }
                
                //获取当前时间
                $currentDateTime = date('y-m-d H:i:s');
                
                $buildRecordContent = $userName.'\t 于'.$currentDateTime.'\t'.$findActiveTypeTable->type_name.'\t'.$content.'\n相关内容:\t'.$findRelationResult->title.'
                    \t';
                $findRelationImages = $findRelationResult->images;
                $findRelationTable = $findActiveTypeTable->relation_table;
                
            }
        }else{
            return FALSE;
        }
        
        //插入一条记录
        if($createLoginName!=NULL &&$createNickName!=NULL){
            
           $creatSql = "insert into zy_user_active(content,active_type_id,create_user,create_login_name,create_nick_name,relation_id,relation_table,create_time,relation_images)value('$buildRecordContent',$typeId,$createUserId,$createLoginName,$createNickName,$relationId,'$findRelationTable',$currentDateTime,'$findRelationImages')";

        }
        
        if($createLoginName!=NULL&&$createNickName==NULL){
           $creatSql = "insert into zy_user_active(content,active_type_id,create_user,create_login_name,relation_id,relation_table,create_time,relation_images)value('$buildRecordContent',$typeId,$createUserId,'$createLoginName',$relationId,'$findRelationTable',$currentDateTime,'$findRelationImages')";

        }
        
        if($createLoginName==NULL&&$createNickName!=NULL){
           $creatSql = "insert into zy_user_active(content,active_type_id,create_user,create_nick_name,relation_id,relation_table,create_time,relation_images)value('$buildRecordContent',$typeId,$createUserId,'$createNickName',$relationId,'$findRelationTable',$currentDateTime,'$findRelationImages')";

        }
        
        if($createLoginName==NULL&&$createNickName==NULL){
           $creatSql = "insert into zy_user_active(content,active_type_id,create_user,relation_id,relation_table,create_time,relation_images)value('$buildRecordContent',$typeId,$createUserId,$relationId,'$findRelationTable',$currentDateTime,'$findRelationImages')";

        }
        
        //插入记录
        $createResult = $this->dbOperation->saveBySql($creatSql);
        
        if($createResult){
            return TRUE;
        }else{
            //尝试10次
            $i = 1;
            $retry = 11;
            while ($i<$retry){
               $retryResult = $this->dbOperation->saveBySql($creatSql);
               if($retryResult){
                   return TRUE;
               }else{
                   return FALSE;
               }
               $i++;
            }
            return FALSE;
        }
       
    }
    
    
    /*
     *插入一条新闻评论活动记录
     */
    public function  createFavNewsRecord($content,$createUserId,$createLoginName,$createNickName,$articleId){
        $content='新闻';
        $typeId=1;
        $this->createNewActiveRecordWith($typeId, $content, $createUserId,$articleId,$createLoginName,$createNickName);
    }
    public function createUnFavNewsRecord($content,$createUserId,$createLoginName,$createNickName,$articleId){
        $content='新闻';
        $typeId=2;
        $this->createNewActiveRecordWith($typeId, $content, $createUserId,$articleId,$createLoginName,$createNickName);
    }
    public function createAnCommentNewsRecord(){
        
    }
    public function createSupportAnNewsCommentRecord(){
        
    }
    public function createUnSupportAnNewsCommentRecord(){
        
    }
    public function createFavPictureRecord(){
        
    }
    public function createUnFavPictureRecord(){
        
    }
    public function createAnCommentPictureRecord(){
        
    }
    public function createSupportAnPictureCommentRecord(){
        
    }
    public function createUnSupportAnPictureCommentRecord(){
        
    }
    public function createFavProductRecord(){
        
    }
    public function createUnFavProductRecord(){
        
    }
    public function createAnProductCommentRecord(){
        
    }
    public function createSupportAnProductCommentRecord(){
        
    }
    public function createUnSupportAnProductCommentRecord(){
        
    }
    
    
    
    
}

?>
