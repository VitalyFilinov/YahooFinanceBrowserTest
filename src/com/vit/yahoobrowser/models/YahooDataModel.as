package com.vit.yahoobrowser.models
{
	import com.vit.yahoobrowser.events.YahooDataEvent;
	import com.vit.yahoobrowser.models.vo.IIndustryVO;
	import com.vit.yahoobrowser.models.vo.ISectorVO;
	import com.vit.yahoobrowser.models.vo.ICompanyVO;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;

	public class YahooDataModel
	{
		[Inject]
		public var eventDispatcher:IEventDispatcher;
		
		private var sectors:Vector.<ISectorVO>;
		private var currentSectors:Array = [];
		
		private var currentSector:ISectorVO;
		private var currentIndustry:IIndustryVO;
		private var currentCompany:ICompanyVO;
		
		public function setSectors(data:Object):void
		{
			sectors = data as Vector.<ISectorVO>;
			
			updateCurrentSectorsList();
			
			eventDispatcher.dispatchEvent(new Event(YahooDataEvent.SECTORS_CHANGED));
		}
		
		public function getCurrentSectorsList():Array
		{
			return currentSectors;
		}
		
		private function updateCurrentSectorsList():void
		{
			currentSectors = [];
			var aMax:int = sectors.length;
			var bMax:int;
			for(var a:int = 0; a<aMax; a++)
			{
				currentSectors[currentSectors.length] = sectors[a];
				if(sectors[a].selected)
				{
					bMax = sectors[a].industries.length;
					for(var b:int = 0; b<bMax; a++)
					{
						currentSectors[currentSectors.length] = sectors[a].industries[b];
					}
				}
			}
		}
		
		public function setCurrentSector(sector:ISectorVO):void
		{
			if(currentSector)
			{
				currentSector.selected = false;
			}
			
			currentSector = sector;
			currentSector.selected = true;
			
			updateCurrentSectorsList();
			
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
			
			updateCurrentSectorsList();
			
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
			
			updateCurrentSectorsList();
			
			eventDispatcher.dispatchEvent(new Event(YahooDataEvent.CURRENT_COMPANY_CHANGED));
		}
	}
}