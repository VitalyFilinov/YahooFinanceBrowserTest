package com.vit.yahoobrowser.commands
{
	import com.vit.yahoobrowser.events.YahooLoadDataEvent;
	import com.vit.yahoobrowser.models.YahooLoaderDataTypes;
	
	import flash.events.IEventDispatcher;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class YahooFinanceBrowserInitCommand extends Command
	{
		[Inject]
		public var eventDispatcher:IEventDispatcher;
		
		override public function execute():void
		{
			eventDispatcher.dispatchEvent(new YahooLoadDataEvent(YahooLoadDataEvent.LOAD_DATA, YahooLoaderDataTypes.INDUSTRIES));
		}
	}
}