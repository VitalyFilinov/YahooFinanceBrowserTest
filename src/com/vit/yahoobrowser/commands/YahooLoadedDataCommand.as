/**
 * YahooLoadedDataCommand is created and used as a Command of the project robotlegs structure.
 * YahooLoadedDataCommand is listen for the YahooDataLoaderEvent.EVENT_DATA_LOADED or
 * YahooDataLoaderEvent.EVENT_DATA_FAILED event.
 * Above mentioning events dispatches when downloading process is finished.
 * 
 * If YahooDataLoaderEvent.EVENT_DATA_LOADED is received the command
 * sets the data according to event.dataType.
 * 
 * If YahooDataLoaderEvent.EVENT_DATA_FAILED is received the command
 * dispatches appropriate error event.
 */
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
				/**
				 * Industries list are loaded.
				 * Sets industries data to the IYahooDataModel.
				 */
				if(event.dataType == YahooLoaderDataTypes.INDUSTRIES)
				{
					dataModel.setIndustries(event.loadedData);
				}
				/**
				 * Companies list are loaded.
				 * Sets companies data to the IYahooDataModel.
				 */
				else if(event.dataType == YahooLoaderDataTypes.COMPANIES)
				{
					dataModel.setCompanies(event.loadedData);
				}
				/**
				 * Quotes are loaded.
				 * Sets Quotes data to the IYahooChartModel.
				 */
				else if(event.dataType == YahooLoaderDataTypes.QUOTES)
				{
					chartModel.setChartData(event.loadedData);
				}
			}
			else if(event.type == DataLoaderEvent.EVENT_DATA_FAILED)
			{
				if(event.dataType == YahooLoaderDataTypes.INDUSTRIES)
				{
					eventDispatcher.dispatchEvent(new YahooIndustryEvent(YahooIndustryEvent.CURRENT_INDUSTRY_ERROR));
				}
				else if(event.dataType == YahooLoaderDataTypes.COMPANIES)
				{
					eventDispatcher.dispatchEvent(new YahooCompanyEvent(YahooCompanyEvent.COMPANIES_ERROR));
				}
				else if(event.dataType == YahooLoaderDataTypes.QUOTES)
				{
					eventDispatcher.dispatchEvent(new YahooChartEvent(YahooChartEvent.CHART_DATA_ERROR));
				}	
			}
		}
	}
}