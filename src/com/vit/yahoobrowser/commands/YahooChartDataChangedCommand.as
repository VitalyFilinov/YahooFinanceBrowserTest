/**
 * YahooChartDataChangedCommand listen for the YahooChartEvent.CHART_DATA_CHANGED event.
 * YahooChartEvent.CHART_DATA_CHANGED event dispatches when the chart data is changed.
 * The command tries to set current company by using received event.symbol.
 */
package com.vit.yahoobrowser.commands
{
	import com.vit.yahoobrowser.events.YahooChartEvent;
	import com.vit.yahoobrowser.models.IYahooDataModel;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class YahooChartDataChangedCommand extends Command
	{
		
		[Inject]
		public var dataModel:IYahooDataModel;
		
		[Inject]
		public var event:YahooChartEvent;
		
		override public function execute():void
		{
			dataModel.setCurrentCompanyBySymbol(event.symbol);
		}
	}
}