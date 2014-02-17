package com.vit.yahoobrowser.models
{
	import com.vit.yahoobrowser.events.YahooDataEvent;
	import com.vit.yahoobrowser.events.YahooFavoritesEvent;
	import com.vit.yahoobrowser.models.vo.ICompanyVO;
	import com.vit.yahoobrowser.models.vo.IIndustryVO;
	import com.vit.yahoobrowser.models.vo.ISectorVO;
	import com.vit.yahoobrowser.models.vo.IndustryVO;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;

	public class YahooDataModel
	{
		[Inject]
		public var eventDispatcher:IEventDispatcher;
		
		private var sectors:Array = [];
		private var currentSearch:Array = [];
		
		private var currentSector:ISectorVO;
		private var currentIndustry:IIndustryVO;
		private var currentCompany:ICompanyVO;
		
		private var favorites:Array = [];
		private var tmpFavorites:Array;
		
		public function setIndustries(data:Object):void
		{
			sectors = data as Array;
			eventDispatcher.dispatchEvent(new Event(YahooDataEvent.INDUSTRIES_CHANGED));
		}
		
		public function getIndustries():Array
		{
			return sectors;
		}
		
		public function setCurrentIndustry(industry:IIndustryVO):void
		{
			if(currentIndustry)
			{
				currentIndustry.selected = false;
			}
			
			currentIndustry = industry;
			currentIndustry.selected = true;
			
			eventDispatcher.dispatchEvent(new Event(YahooDataEvent.CURRENT_INDUSTRY_CHANGED));
		}
		
		public function setCurrentCompany(company:ICompanyVO):void
		{
			if(currentCompany)
			{
				currentCompany.selected = false;
			}
			
			currentCompany = company;
			currentCompany.selected = true;
			
			eventDispatcher.dispatchEvent(new Event(YahooDataEvent.CURRENT_COMPANY_CHANGED));
		}
		
		///////////////////////////////// SEARCH /////////////////////////////////
		
		public function getSearch(searchString:String):Array
		{
			// TODO clean
			currentSearch = [];
			var a:int = sectors.length;
			var b:int;
			var tmpSector:ISectorVO;
			var tmpIndustry:IIndustryVO;
			while(a--)
			{
				if(sectors[a] is IndustryVO)
				{
					trace("SOMETHING WRONG!");
					return [];
				}
				b = sectors[a].industries.source.length;
				while(b--)
				{
					tmpIndustry = sectors[a].industries.getItemAt(b);
					if(sectors[a].name == "Conglomerates")
					{
						trace(tmpIndustry.name, searchString, tmpIndustry.name.toLowerCase().indexOf(searchString.toLowerCase()));
					}
					
					if(tmpIndustry.name.toLowerCase().indexOf(searchString.toLowerCase()) > -1)
					{
						tmpSector ||= sectors[a].clone(true);
						tmpSector.industries.addItem(tmpIndustry);
					}
					
					tmpIndustry = null;
					
				}
				
				if(tmpSector != null)
				{	
					tmpSector.isOpened = true;
					tmpSector.industries.source.reverse();
					currentSearch[currentSearch.length] = tmpSector;
				}
				
				tmpSector = null;
			}
			
			currentSearch.reverse();
			
			return currentSearch;
		}
		
		///////////////////////////////// FAVORITES /////////////////////////////////
		
		public function addFavorite(item:IIndustryVO):void
		{
			tmpFavorites ||= favorites.slice(0);
			tmpFavorites[tmpFavorites.length] = item;
		}
		
		public function removeFavorite(item:IIndustryVO, complete:Boolean = false):void
		{
			if(complete)
			{
				removeFavoriteFrom(favorites, item);
				item.selected = false;
				eventDispatcher.dispatchEvent(new YahooFavoritesEvent(YahooFavoritesEvent.CHANGED));
			}
			else
			{
				tmpFavorites ||= favorites.slice(0);
				removeFavoriteFrom(tmpFavorites, item);
			}
		}
		
		private function removeFavoriteFrom(source:Array, item:IIndustryVO):void
		{
			var i:int = source.length;
			while(i--)
			{
				if(source[i] == item)
				{
					source.splice(i,1);
					return;
				}
			}
		}
		
		public function saveFavorites():void
		{
			if(tmpFavorites == null) return; // favorites was not been changed
			
			var i:int = favorites.length;
			while(i--)
			{
				favorites[i].selected = false;
			}
			
			i = tmpFavorites.length;
			while(i--)
			{
				tmpFavorites[i].selected = true;
			}
			
			favorites = tmpFavorites.splice(0);
			tmpFavorites = null;
			
			eventDispatcher.dispatchEvent(new YahooFavoritesEvent(YahooFavoritesEvent.CHANGED));
		}
		
		public function resetFavorites():void
		{
			if(tmpFavorites == null) return; // favorites was not been changed
			
			var i:int = tmpFavorites.length;
			while(i--)
			{
				tmpFavorites[i].selected = false;
			}
			
			i = favorites.length;
			while(i--)
			{
				favorites[i].selected = true;
			}
			
			tmpFavorites = [];
			tmpFavorites = null;
		}
		
		public function getFavorites():Array
		{
			return favorites;
		}
	}
}