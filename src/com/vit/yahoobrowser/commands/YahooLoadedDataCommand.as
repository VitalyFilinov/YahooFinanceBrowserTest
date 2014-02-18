package com.vit.yahoobrowser.commands
{
	import com.vit.yahoobrowser.events.DataLoaderEvent;
	import com.vit.yahoobrowser.events.YahooChartEvent;
	import com.vit.yahoobrowser.events.YahooCompanyEvent;
	import com.vit.yahoobrowser.events.YahooIndustryEvent;
	import com.vit.yahoobrowser.models.IYahooChartModel;
	import com.vit.yahoobrowser.models.IYahooDataModel;
	import com.vit.yahoobrowser.models.YahooLoaderDataTypes;
	
	import flash.events.IEventDispatcher;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class YahooLoadedDataCommand extends Command
	{
		[Inject]
		public var dataModel:IYahooDataModel;
		
		[Inject]
		public var chartModel:IYahooChartModel;
		
		[Inject]
		public var event:DataLoaderEvent;
		
		[Inject]
		public var eventDispatcher:IEventDispatcher;
		
		override public function execute():void
		{
			if(event.type == DataLoaderEvent.EVENT_DATA_LOADED)
			{
				if(event.loaderID == YahooLoaderDataTypes.INDUSTRIES)
				{
					dataModel.setIndustries(event.loadedData);
				}
				else if(event.loaderID == YahooLoaderDataTypes.COMPANIES)
				{
					dataModel.setCompanies(event.loadedData);
				}
				else if(event.loaderID == YahooLoaderDataTypes.QUOTES)
				{
					chartModel.setChartData(event.loadedData);
				}
			}
			else if(event.type == DataLoaderEvent.EVENT_DATA_FAILED)
			{
				if(event.loaderID == YahooLoaderDataTypes.INDUSTRIES)
				{
					eventDispatcher.dispatchEvent(new YahooIndustryEvent(YahooIndustryEvent.CURRENT_INDUSTRY_ERROR));
				}
				else if(event.loaderID == YahooLoaderDataTypes.COMPANIES)
				{
					eventDispatcher.dispatchEvent(new YahooCompanyEvent(YahooCompanyEvent.COMPANIES_ERROR));
				}
				else if(event.loaderID == YahooLoaderDataTypes.QUOTES)
				{
					eventDispatcher.dispatchEvent(new YahooChartEvent(YahooChartEvent.CHART_DATA_ERROR));
				}	
			}
		}
		
		private function setCurrentChartData(loadedData:Object):void
		{
			// TODO Auto Generated method stub
			
		}
	}
}