 /**
 * YahooChartDataUpdateCommand listen for the YahooChartEvent.CHART_DATA_UPDATE event.
 * YahooChartEvent.CHART_DATA_UPDATE event dispatches when symbol, startDate or endDate changed.
 * The command updates startDate and endDate on iYahooChartModel,
 * tries to set current company by event.symbol and
 * dispatches the YahooLoadDataEvent.LOAD_DATA event to load 
 * current selected company quotes data using event.symbol as as a simbol name.
 */
package com.vit.yahoobrowser.commands
{
	import com.vit.yahoobrowser.events.YahooChartEvent;
	import com.vit.yahoobrowser.events.YahooLoadDataEvent;
	import com.vit.yahoobrowser.models.IYahooChartModel;
	import com.vit.yahoobrowser.models.IYahooDataModel;
	import com.vit.yahoobrowser.models.YahooLoaderDataTypes;
	
	import flash.events.IEventDispatcher;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class YahooChartDataUpdateCommand extends Command
	{
		[Inject]
		public var eventDispatcher:IEventDispatcher;
		
		[Inject]
		public var dataModel:IYahooDataModel;
		
		[Inject]
		public var chartModel:IYahooChartModel;
		
		[Inject]
		public var event:YahooChartEvent;
		
		override public function execute():void
		{
			chartModel.setStartDate(event.startDate);
			chartModel.setEndDate(event.endDate);
			
			if(event.symbol.length > 0)
			{
				dataModel.setCurrentCompanyBySymbol(event.symbol);
				
				eventDispatcher.dispatchEvent(new YahooLoadDataEvent(YahooLoadDataEvent.LOAD_DATA, YahooLoaderDataTypes.QUOTES,
					{ symbol:event.symbol, startDate:event.startDate, endDate:event.endDate } ));
			}

		}
	}
}