package com.vit.yahoobrowser.models
{
	import com.vit.yahoobrowser.models.vo.ICompanyVO;
	import com.vit.yahoobrowser.models.vo.IIndustryVO;
	
	import mx.collections.ArrayList;

	public interface IYahooDataModel
	{
		function setIndustries(data:Object):void;
		function getIndustries():ArrayList;

		function setCompanies(data:Object):void;
		function getCompanies():ArrayList;
		
		function setCurrentIndustry(industry:IIndustryVO):void;
		function setCurrentCompany(company:ICompanyVO):void;
		function getCurrentCompany():ICompanyVO;
		function setCurrentCompanyBySymbol(symbol:String):void;
			
		function getSearch(searchString:String):ArrayList;
		function clearSearch():void;
		
		function addFavorite(item:IIndustryVO):void;
		function removeFavorite(item:IIndustryVO, complete:Boolean = false):void;
		function saveFavorites():void;
		function resetFavorites():void;
		function getFavorites():ArrayList;
		function openItem(source:ArrayList, index:int):void;
		function closeItem(source:ArrayList, index:int):void;
	}
}