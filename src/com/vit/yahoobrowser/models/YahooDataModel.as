package com.vit.yahoobrowser.models
{
	import com.vit.yahoobrowser.events.YahooDataEvent;
	import com.vit.yahoobrowser.models.vo.ICompanyVO;
	import com.vit.yahoobrowser.models.vo.IIndustryVO;
	import com.vit.yahoobrowser.models.vo.ISectorVO;
	import com.vit.yahoobrowser.models.vo.IndustryVO;
	import com.vit.yahoobrowser.models.vo.SectorVO;
	
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
		
		public function setSectors(data:Object):void
		{
			sectors = data as Array;
			eventDispatcher.dispatchEvent(new Event(YahooDataEvent.SECTORS_CHANGED));
		}
		
		public function getSectors():Array
		{
			return sectors;
		}
		
		public function resetSectors():void
		{
			var a:int = sectors.length;
			var b:int;
			while(a--)
			{
				sectors[a].isOpened = false;
				b = sectors[a].industries.length;
				while(b--)
				{
					sectors[a].industries[b].selected = false;
				}
			}
		}
		
		public function setCurrentSector(sector:ISectorVO):void
		{
			
			currentSector = sector;
			
			eventDispatcher.dispatchEvent(new Event(YahooDataEvent.CURRENT_SECTOR_CHANGED));
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
		
		public function addFavorites(items:Array):void
		{
			favorites = favorites.concat(items);
			favorites.sortOn("name");
		}
		
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
	}
}