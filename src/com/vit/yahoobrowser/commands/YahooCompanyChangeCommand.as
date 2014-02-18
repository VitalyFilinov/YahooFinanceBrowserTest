package com.vit.yahoobrowser.commands
{
	import com.vit.yahoobrowser.events.YahooCompanyEvent;
	import com.vit.yahoobrowser.events.YahooLoadDataEvent;
	import com.vit.yahoobrowser.models.IYahooChartModel;
	import com.vit.yahoobrowser.models.IYahooDataModel;
	import com.vit.yahoobrowser.models.YahooLoaderDataTypes;
	
	import flash.events.IEventDispatcher;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class YahooCompanyChangeCommand extends Command
	{
		[Inject]
		public var eventDispatcher:IEventDispatcher;
		
		[Inject]
		public var chartModel:IYahooChartModel;
		
		[Inject]
		public var dataModel:IYahooDataModel;
		
		[Inject]
		public var event:YahooCompanyEvent;
		
		override public function execute():void
		{
			eventDispatcher.dispatchEvent(new YahooLoadDataEvent(YahooLoadDataEvent.LOAD_DATA, YahooLoaderDataTypes.QUOTES,
					{ symbol:dataModel.getCurrentCompany().symbol, startDate:chartModel.getStartDate(), endDate:chartModel.getEndDate() } ));
		}
	}
}