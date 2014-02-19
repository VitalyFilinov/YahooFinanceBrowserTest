/**
 * YahooStartupCommand is created and used as a Command of the project robotlegs structure.
 * YahooStartupCommand is listen for Event.INIT event.
 * Event.INIT event dispatches when the main context initialized.
 * The command dispatches the YahooLoadDataEvent.LOAD_DATA event to load
 * the industries list from the data provider.
 */
package com.vit.yahoobrowser.commands
{
	import com.vit.yahoobrowser.events.YahooLoadDataEvent;
	import com.vit.yahoobrowser.models.YahooLoaderDataTypes;
	
	import flash.events.IEventDispatcher;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class YahooStartupCommand extends Command
	{
		[Inject]
		public var eventDispatcher:IEventDispatcher;
		
		override public function execute():void
		{
			eventDispatcher.dispatchEvent(new YahooLoadDataEvent(YahooLoadDataEvent.LOAD_DATA, YahooLoaderDataTypes.INDUSTRIES));
		}
	}
}