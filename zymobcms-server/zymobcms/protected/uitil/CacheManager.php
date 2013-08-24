<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of CacheManager
 *
 * @author ZYVincent
 */
class CacheManager {
    //put your code here
    
    private $_cache;
    private $_appId;

    public function __construct($appId){
        
        $cacheName = $appId;
        $this->_appId = $appId;
        $cachePath = 'cache/'.$cacheName.'/';
        $cacheExtension = '.cache';
        $cacheConfig = array('name'=>$cacheName,'path'=>$cachePath,'extension'=>$cacheExtension);
        
        $this->_cache = new Cache($cacheConfig);
        
//        //是否过期,去数据库查询过期时间,备用需求
//            $dbOperation = new class_DBOperation(DataBaseConfig::$dbhost,DataBaseConfig::$username,DataBaseConfig::$password,$this->_appId,DataBaseConfig::$charset);
//            $findOverTime = "select cache_over_time from zy_application_owner";
//            $resultObject = $dbOperation->queryBySql($findOverTime);
//            
//            $currentTime = date('Y-m-d h:i:s');
//            if(strtotime($resultObject->cache_over_time)<strtotime($currentTime)){ 
//                
//                //清除所有缓存
//                $this->_cache->eraseAll();
//                
//                //重新设置10天后为缓存清除时间
//                $newClearTime = $this->AddDay($currentTime,10);
//                $updateCacheClearTime = "update zy_application_owner set cache_over_time = $newClearTime";
//                $saveNewUpdate = $dbOperation->saveBySql($updateCacheClearTime);
//                if($saveNewUpdate){
//                    
//                } 
//            }
        
    }
    
    /*
     * 为新闻类别创建缓存
     */
    public function cacheNewsListByCategoryAndTabType($categoryId,$tabTypeId,$pageIndex,$data){
        
        $cacheKey = $categoryId.'_'.$tabTypeId.'_'.$pageIndex;
        
        //直接保存json数据
        $this->_cache->store($cacheKey,json_encode($data));
        
        
    }   
    
    public function isCacheDataForCategoryIdAndTabType($categoryId,$tabTypeId,$pageIndex){
        
        $cacheKey = $categoryId.'_'.$tabTypeId.'_'.$pageIndex;

        $isNewsCached = $this->_cache->isCached($cacheKey);
        
        if ($isNewsCached) {
                        
            return TRUE;
        }else{
            return FALSE;
        }
    }
    
    public function returnCacheDataForCategoryIdAndTabType($categoryId,$tabTypeId,$pageIndex){
        
        
        $cacheKey = $categoryId.'_'.$tabTypeId.'_'.$pageIndex;
        
        $cacheData = $this->_cache->retrieve($cacheKey);
            
        return $cacheData;
             
    }
    
    //取当前时间后几天，天数增加单位为1
    function AddDay($ntime,$aday)
    {
        $dayst = 3600 * 24;
        $oktime = $ntime + ($aday * $dayst);
        return $oktime;
    }
    
    /*
     * 为图片列表创建缓存
     */
    public function isPictureListCacheExist($mainCategoryId,$subTabTypeId,$pageIndex){
        
        $cacheKey = 'picture_list_'.$mainCategoryId.'_'.$subTabTypeId.'_'.$pageIndex;
        
        $isNewsCached = $this->_cache->isCached($cacheKey);
        
        if ($isNewsCached) {
                                    
            return TRUE;

        }else{
            return FALSE;
        }
    }
    
    public function cachePictureNewList($mainCategoryId,$subTabTypeId,$pageIndex,$data){
        
        $cacheKey = 'picture_list_'.$mainCategoryId.'_'.$subTabTypeId.'_'.$pageIndex;
    	        
        $this->_cache->store($cacheKey,json_encode($data));
        
    }
    
    public function returnPictureCacheListByPageIndex($mainCategoryId,$subTabTypeId,$pageIndex){
        
        $cacheKey = 'picture_list_'.$mainCategoryId.'_'.$subTabTypeId.'_'.$pageIndex;
    	        
        $cacheData = $this->_cache->retrieve($cacheKey);
        
        return $cacheData;
    }
    
    /*
     * 为产品列表创建缓存
     */
    public function isProductListCacheExist($mainCategoryId,$subTabTypeId,$pageIndex){
        
        $cacheKey = 'product_list_'.$mainCategoryId.'_'.$subTabTypeId.'_'.$pageIndex;
    	        
        $isNewsCached = $this->_cache->isCached($cacheKey);
        
        if ($isNewsCached) {
                                    
            return TRUE;

        }else{
            return FALSE;
        }
    }
    
    public function cacheProductNewList($mainCategoryId,$subTabTypeId,$pageIndex,$data){
        
        $cacheKey = 'product_list_'.$mainCategoryId.'_'.$subTabTypeId.'_'.$pageIndex;
    	        
        $this->_cache->store($cacheKey,json_encode($data));
        
    }
    
    public function returnProductCacheListByPageIndex($mainCategoryId,$subTabTypeId,$pageIndex){
        
        $cacheKey = 'product_list_'.$mainCategoryId.'_'.$subTabTypeId.'_'.$pageIndex;
    	        
        $cacheData = $this->_cache->retrieve($cacheKey);
        
        return $cacheData;
    }
    
    /*
     * 为热门跟贴创建缓存
     */
    public function isHotCommentListCacheExist($pageIndex){
        
        $cacheKey = 'hot_comment_list_'.$pageIndex;
        
        $isNewsCached = $this->_cache->isCached($cacheKey);
        
        if ($isNewsCached) {
                                    
            return TRUE;

        }else{
            return FALSE;
        }
    }
    
    public function cacheHotCommentNewList($pageIndex,$data){
        
        $cacheKey = 'hot_comment_list_'.$pageIndex;
        
        $this->_cache->store($cacheKey,json_encode($data));
        
    }
    
    public function returnHotCommentCacheListByPageIndex($pageIndex){
        
        $cacheKey = 'hot_comment_list_'.$pageIndex;
        
        $cacheData = $this->_cache->retrieve($cacheKey);
        
        return $cacheData;
    }
    
    /*
     * 为文章详情创建缓存
     */
    public function isArticleDetailCacheExist($articleId){
    	
    	$cacheKey = 'article_detail_'.$articleId;
    	
    	$isNewsCached = $this->_cache->isCached($cacheKey);
    	
    	if ($isNewsCached) {
    	
    		return TRUE;
    	
    	}else{
    		return FALSE;
    	}
    }
    
    public function returnArticleDetailCache($articleId){
    	
    	$cacheKey = 'article_detail_'.$articleId;
    	 
    	$cacheData = $this->_cache->retrieve($cacheKey);
    	
    	return $cacheData;
    }
    
    public function cacheArticleDetail($articleId,$data){
    	
    	$cacheKey = 'article_detail_'.$articleId;
    	    	
    	$this->_cache->store($cacheKey,$data);
    }
    
    /*
     * 为图片详情创建缓存
     */
    public function isPictureDetailCacheExist($pictureId){
    	
    	$cacheKey = 'picture_detail_'.$pictureId;
    	 
    	$isNewsCached = $this->_cache->isCached($cacheKey);
    	 
    	if ($isNewsCached) {
    		 
    		return TRUE;
    		 
    	}else{
    		return FALSE;
    	}
    }
    
    public function returnPictureDetailCache($pictureId){
    	
    	$cacheKey = 'picture_detail_'.$pictureId;
    	    	
    	$cacheData = $this->_cache->retrieve($cacheKey);
    	 
    	return $cacheData;
    }
    
    public function cachePictureDetail($pictureId,$data){
    	
    	$cacheKey = 'picture_detail_'.$pictureId;
    	    	
    	$this->_cache->store($cacheKey,$data);
    }
    
    /*
     * 为产品详情创建缓存
     */
    public function isProductDetailCacheExist($productId){
    	
    	$cacheKey = 'product_detail_'.$productId;
    	 
    	$isNewsCached = $this->_cache->isCached($cacheKey);
    	
    	if ($isNewsCached) {
    		 
    		return TRUE;
    		 
    	}else{
    		return FALSE;
    	}
    }
    
    public function returnProductDetailCache($productId){
    	
    	$cacheKey = 'product_detail_'.$productId;
    	    	
    	$cacheData = $this->_cache->retrieve($cacheKey);
    	
    	return $cacheData;
    }
    
    public function cacheProductDetail($productId,$data){
    	
    	$cacheKey = 'product_detail_'.$productId;
    	    	
    	$this->_cache->store($cacheKey,$data);
    	
    }
    
    /*
     * 为Article模块的TabType创建缓存
     */
    public function isNewsListTabTypesCachedExist($categoryId){
    	
    	$preKey = 'newsList';
    	
    	$this->isCacheTabTypesExist($preKey, $categoryId);
    	
    }
    public function cacheNewsListTabTypes($categoryId,$data){
    	
    	$preKey = 'newsList';
    	 
    	$this->cacheTabTypes($preKey, $categoryId,$data);
    }
    public function returnNewsListTabTypes($categoryId){
    	$preKey = 'newsList';
    	
    	$this->returnTabTypes($preKey, $categoryId);
    }
    
    /*
     * 为图片模块的TabType创建缓存
     */
    public function isPictureTabTypesCacheExist($categoryId){
    	$preKey = 'picture';
    	 
    	$this->isCacheTabTypesExist($preKey, $categoryId);
    }
    public function cachePictureTabTypes($categoryId,$data){
    	$preKey = 'picture';
    	
    	$this->cacheTabTypes($preKey, $categoryId,$data);
    }
    public function returnPictureTabTypes($categoryId){
    	$preKey = 'picture';
    	 
    	$this->returnTabTypes($preKey, $categoryId);
    }
    
    /*
     * 为产品模块的TabType创建缓存
     */
    public function isProductTabTypesCacheExist($categoryId){
    	$preKey = 'product';
    	
    	$this->isCacheTabTypesExist($preKey, $categoryId);
    }
    public function cacheProductTabTypes($categoryId,$data){
    	$preKey = 'product';
    	 
    	$this->cacheTabTypes($preKey, $categoryId,$data);
    }
    public function returnProductTabTypes($categoryId){
    	$preKey = 'product';
    	
    	$this->returnTabTypes($preKey, $categoryId);
    }
    
    private function isCacheTabTypesExist($preKey,$categoryId){
    	
    	$cacheKey = $preKey.'_'.$categoryId;
    	
    	$isNewsCached = $this->_cache->isCached($cacheKey);
    	 
    	if ($isNewsCached) {
    		 
    		return TRUE;
    		 
    	}else{
    		return FALSE;
    	}
    }
    private function cacheTabTypes($preKey,$categoryId,$data){
    	$cacheKey = $preKey.'_'.$categoryId;
    	
    	$this->_cache->store($cacheKey,json_encode($data));
    }
    private function returnTabTypes($preKey,$categoryId){
    	
    	$cacheKey = $preKey.'_'.$categoryId;
    	
    	$cacheData = $this->_cache->retrieve($cacheKey);
    	
    	return $cacheData;
    }
}

?>
