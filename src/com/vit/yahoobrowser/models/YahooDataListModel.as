package com.vit.yahoobrowser.models
{
	import com.vit.yahoobrowser.events.YahooCompanyEvent;
	import com.vit.yahoobrowser.events.YahooFavoritesEvent;
	import com.vit.yahoobrowser.events.YahooIndustryEvent;
	import com.vit.yahoobrowser.events.YahooLoadDataEvent;
	import com.vit.yahoobrowser.models.vo.ICompanyVO;
	import com.vit.yahoobrowser.models.vo.IIndustryVO;
	
	import flash.events.IEventDispatcher;
	
	import mx.collections.ArrayList;

	public class YahooDataListModel implements IYahooDataModel
	{
		[Inject]
		public var eventDispatcher:IEventDispatcher;
		
		private var industries:ArrayList;
		private var companies:ArrayList;
		private var companiesStock:Object = {};
		private var currentSearch:ArrayList;
		
		private var currentSector:IIndustryVO;
		private var currentIndustry:IIndustryVO;
		private var currentCompany:ICompanyVO;
		
		private var favorites:ArrayList = new ArrayList();
		private var tmpFavorites:ArrayList;
		
		private var chartStartDate:Date;
		private var chartEndDate:Date;
		
		public function setIndustries(data:Object):void
		{
			industries = data as ArrayList;
			eventDispatcher.dispatchEvent(new YahooIndustryEvent(YahooIndustryEvent.INDUSTRIES_CHANGED));
		}
		
		public function getIndustries():ArrayList
		{
			return industries;
		}
		
		public function setCompanies(data:Object):void
		{
			companies = data.data as ArrayList;
			eventDispatcher.dispatchEvent(new YahooCompanyEvent(YahooCompanyEvent.COMPANIES_CHANGED));
		}
		
		public function getCompanies():ArrayList
		{
			return companies;
		}
		
		public function setCurrentIndustry(industry:IIndustryVO):void
		{
			if(currentIndustry == industry)
			{
				return; // Industry was not changed
			}
			
			if(currentIndustry)
			{
				currentIndustry.isCurrent = false;
				favorites.itemUpdated(currentIndustry);
			}
			
			currentIndustry = industry;
			currentIndustry.isCurrent = true;
			favorites.itemUpdated(currentIndustry);
			
			if(companies)
			{
				companies.removeAll();
			}
			
			eventDispatcher.dispatchEvent(new YahooLoadDataEvent(YahooLoadDataEvent.LOAD_DATA, YahooLoaderDataTypes.COMPANIES, {id:currentIndustry.id}));
		}
		
		public function setCurrentCompany(company:ICompanyVO):void
		{
			if(currentCompany == company)
			{
				return; // Company was not changed
			}
			
			if(currentCompany)
			{
				currentCompany.isCurrent = false;
				companies.itemUpdated(currentCompany);
			}
			
			currentCompany = company;
			currentCompany.isCurrent = true;
			companies.itemUpdated(currentCompany);
			
			eventDispatcher.dispatchEvent(new YahooCompanyEvent(YahooCompanyEvent.COMPANY_CHANGED, currentCompany));
		}
		
		public function openItem(source:ArrayList, index:int):void
		{
			var _sector:IIndustryVO = source.getItemAt(index) as IIndustryVO;
			_sector.isOpened = true;
			source.addAllAt(_sector.children, index + 1);
		}
		
		public function closeItem(source:ArrayList, index:int):void
		{
			var _sector:IIndustryVO = source.getItemAt(index) as IIndustryVO;
			_sector.isOpened = false;
			
			var i:int = _sector.children.length;
			
			while(i--)
			{
				source.removeItemAt(index + 1);
			}
		}
		
		///////////////////////////////// SEARCH /////////////////////////////////
		
		public function getSearch(searchString:String):ArrayList
		{
			if(currentSearch)
			{
				if(currentSearch.length > 0)
				{
					currentSearch.removeAll();
				}
			}
			else
			{
				currentSearch = new ArrayList();
			}
			
			if(searchString.length == 0)
			{
				return currentSearch;
			}
			
			var aLen:int = industries.length;
			var bLen:int;
			var _sector:IIndustryVO;
			var tmpSector:IIndustryVO;
			var tmpIndustry:IIndustryVO;
			for(var a:int = 0; a<aLen; a++)
			{
				_sector = industries.getItemAt(a) as IIndustryVO;
				
				if(!_sector.children) continue;
				
				bLen = _sector.children.length;
				for(var b:int = 0; b<bLen; b++)
				{
					tmpIndustry = _sector.children.getItemAt(b) as IIndustryVO;
					if(tmpIndustry.name.toLowerCase().indexOf(searchString.toLowerCase()) > -1)
					{
						tmpSector ||= _sector.clone(true);
						tmpSector.children.addItem(tmpIndustry);
					}
					tmpIndustry = null;
				}
				
				if(tmpSector != null)
				{
					currentSearch.addItem(tmpSector);
					openItem(currentSearch, currentSearch.length - 1);
				}
				tmpSector = null;
			}
			
			return currentSearch;
		}
		
		///////////////////////////////// FAVORITES /////////////////////////////////
		
		public function addFavorite(item:IIndustryVO):void
		{
			tmpFavorites ||= new ArrayList(favorites? favorites.source.slice(0):null);
			tmpFavorites.addItem(item);
			
			item.isFavorite = true;
			industries.itemUpdated(item);
		}
		
		public function removeFavorite(item:IIndustryVO, complete:Boolean = false):void
		{
			if(complete)
			{
				favorites.removeItem(item);
			}
			else
			{
				tmpFavorites ||= new ArrayList(favorites.source.slice(0));
				tmpFavorites.removeItem(item);
			}
			
			item.isFavorite = false;
			industries.itemUpdated(item);
		}
		
		public function saveFavorites():void
		{
			if(tmpFavorites == null) return; // favorites was not been changed
			
			favorites ||= new ArrayList();
			
			var i:int = favorites.length;
			var item:IIndustryVO;
			while(i--)
			{
				item = favorites.getItemAt(i) as IIndustryVO;
				item.isFavorite = false;
				favorites.itemUpdated(item);
				industries.itemUpdated(item);
			}
			
			i = tmpFavorites.length;
			while(i--)
			{
				item = tmpFavorites.getItemAt(i) as IIndustryVO;
				item.isFavorite = true;
				industries.itemUpdated(item);
			}
			
			favorites = tmpFavorites;
			//tmpFavorites.removeAll();
			tmpFavorites = null;
			eventDispatcher.dispatchEvent(new YahooFavoritesEvent(YahooFavoritesEvent.CHANGED));
		}
		
		public function resetFavorites():void
		{
			if(tmpFavorites == null) return; // favorites was not been changed
			
			var i:int = tmpFavorites.length;
			var item:IIndustryVO;
			while(i--)
			{
				item = tmpFavorites.getItemAt(i) as IIndustryVO;
				item.isFavorite = false;
				industries.itemUpdated(item);
			}
			
			i = favorites.length;
			while(i--)
			{
				item = favorites.getItemAt(i) as IIndustryVO;
				item.isFavorite = true;
				favorites.itemUpdated(item);
				industries.itemUpdated(item);
			}
			
			tmpFavorites.removeAll();
			tmpFavorites = null;
		}
		
		public function getFavorites():ArrayList
		{
			return favorites;
		}
	}
}