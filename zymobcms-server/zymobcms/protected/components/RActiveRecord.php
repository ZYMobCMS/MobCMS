<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of RActiveRecord
 *
 * @author barfoo
 */
class RActiveRecord extends CActiveRecord {
    //put your code here
    
    private static $dbadvert = null;
 
    protected static function getAdvertDbConnection()
    {
 
        if (self::$dbadvert !== null)
            return self::$dbadvert;
        else
        {
             $db_name = Yii::app()->user->db_name;
 
             self::$dbadvert = Yii::createComponent(array(
             'class' => 'CDbConnection',
            // other config properties...
             'connectionString'=>"mysql:host=localhost;dbname=".$db_name, //dynamic database name here
              'enableProfiling' => true,
              'enableParamLogging' => true,
              'username'=>'root',
              'password'=> '123', //password here
              'charset'=>'utf8',
              'emulatePrepare' => true,
              'enableParamLogging'=>true,
              'enableProfiling' => true,
             ));
            Yii::app()->setComponent('dbadvert', self::$dbadvert);
 
            if (self::$dbadvert instanceof CDbConnection)
            {   
                Yii::app()->db->setActive(false);
                Yii::app()->dbadvert->setActive(true);
                return self::$dbadvert;
            }
            else{
                throw new CDbException(Yii::t('yii','Active Record requires a "db" CDbConnection application component.'));
            }
 
        }
    }
    
}

?>
