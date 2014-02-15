package com.vit.yahoobrowser
{
	import com.vit.yahoobrowser.commands.YahooFinanceBrowserInitCommand;
	import com.vit.yahoobrowser.commands.YahooLoadDataCommand;
	import com.vit.yahoobrowser.commands.YahooLoadedDataCommand;
	import com.vit.yahoobrowser.commands.YahooFinanceBrowserInitCommand;
	
	import com.vit.yahoobrowser.events.DataLoaderEvent;
	import com.vit.yahoobrowser.events.YahooLoadDataEvent;
	import com.vit.yahoobrowser.models.YahooDataModel;
	import com.vit.yahoobrowser.services.app.IYahooDataSertvice;
	import com.vit.yahoobrowser.services.app.YahooDataService;
	import com.vit.yahoobrowser.views.IndustryManagerMediator;
	import com.vit.yahoobrowser.views.IndustryManagerView;
	import com.vit.yahoobrowser.views.SectorsListMediator;
	import com.vit.yahoobrowser.views.SectorsListView;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	import robotlegs.bender.framework.api.IConfig;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.api.IInjector;
	
	public class YahooFinanceBrowserConfig implements IConfig
	{
		[Inject]
		public var context:IContext;
		
		[Inject]
		public var injector:IInjector;
		
		[Inject]
		public var mediatorMap:IMediatorMap;
		
		[Inject]
		public var commandMap:IEventCommandMap;
		
		[Inject]
		public var eventDispatcher:IEventDispatcher;
		
		public function configure():void
		{
			commandMap.map(Event.INIT).toCommand(YahooFinanceBrowserInitCommand);
			commandMap.map(YahooLoadDataEvent.LOAD_DATA, YahooLoadDataEvent).toCommand(YahooLoadDataCommand);
			
			commandMap.map(DataLoaderEvent.EVENT_DATA_LOADED, DataLoaderEvent).toCommand(YahooLoadedDataCommand);
			commandMap.map(DataLoaderEvent.EVENT_DATA_FAILED, DataLoaderEvent).toCommand(YahooLoadedDataCommand);
			
			injector.map(IYahooDataSertvice).toSingleton(YahooDataService);
			injector.map(YahooDataModel).asSingleton();
			
			mediatorMap.map(IndustryManagerView).toMediator(IndustryManagerMediator);
			//mediatorMap.map(SectorsListView).toMediator(SectorsListMediator);
			
			context.afterInitializing(init);
		}
		
		private function init():void
		{
			eventDispatcher.dispatchEvent(new Event(Event.INIT));
		}
	}
}