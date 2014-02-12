package com.vit.yahoobrowser.commands
{
	import com.vit.yahoobrowser.events.YahooLoadDataEvent;
	import com.vit.yahoobrowser.services.app.IYahooDataSertvice;
	import com.vit.yahoobrowser.services.strategies.app.YahooDataServiceStrategy;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class YahooLoadDataCommand extends Command
	{
		[Inject]
		public var dataService:IYahooDataSertvice;
		
		[Inject]
		public var event:YahooLoadDataEvent;
		
		override public function execute():void
		{
			dataService.load(new YahooDataServiceStrategy(event.dataType));
		}
	}
}