/**
 * YahooLoadDataCommand is created and used as a Command of the project robotlegs structure.
 * YahooLoadDataCommand is listen for the YahooLoadDataEvent.LOAD_DATA event.
 * YahooLoadDataEvent.LOAD_DATA event event dispatches to initialize download any data
 * from the data provider.
 * The command call IYahooDataSertvice.load method using YahooDataServiceStrategy instance as parameter.
 * YahooDataServiceStrategy are used Strategy pattern to provide access to the specific strategy,
 * according to the event.dataType.
 */
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
			dataService.load(new YahooDataServiceStrategy(event.dataType, event.params));
		}
	}
}