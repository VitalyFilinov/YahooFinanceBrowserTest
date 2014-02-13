package com.vit.yahoobrowser.models
{
	import com.vit.yahoobrowser.events.YahooDataEvent;
	import com.vit.yahoobrowser.models.vo.ICompanyVO;
	import com.vit.yahoobrowser.models.vo.IIndustryVO;
	import com.vit.yahoobrowser.models.vo.ISectorVO;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;

	public class YahooDataModel
	{
		[Inject]
		public var eventDispatcher:IEventDispatcher;
		
		private var sectors:Array = [];
		
		private var currentSector:ISectorVO;
		private var currentIndustry:IIndustryVO;
		private var currentCompany:ICompanyVO;
		
		public function setSectors(data:Object):void
		{
			sectors = data as Array;
			
			eventDispatcher.dispatchEvent(new Event(YahooDataEvent.SECTORS_CHANGED));
		}
		
		public function getSectors():Array
		{
			return sectors;
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
	}
}