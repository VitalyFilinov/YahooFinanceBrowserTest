 /**
 * YahooChartDataUpdateCommand listen for YahooChartEvent.CHART_DATA_UPDATE.
 * YahooChartEvent.CHART_DATA_UPDATE dispatches when symbol, startDate or endDate changed.
 * Command updates startDate and endDate on iYahooChartModel,
 * tries to set current company by event.symbol and
 * dispatches YahooLoadDataEvent.LOAD_DATA to load quotes data.
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