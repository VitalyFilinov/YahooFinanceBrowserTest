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