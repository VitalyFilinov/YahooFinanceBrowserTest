package com.vit.yahoobrowser
{
	import com.vit.yahoobrowser.commands.YahooCompanyChangeCommand;
	import com.vit.yahoobrowser.commands.YahooFinanceBrowserInitCommand;
	import com.vit.yahoobrowser.commands.YahooLoadDataCommand;
	import com.vit.yahoobrowser.commands.YahooLoadedDataCommand;
	import com.vit.yahoobrowser.events.DataLoaderEvent;
	import com.vit.yahoobrowser.events.YahooCompanyEvent;
	import com.vit.yahoobrowser.events.YahooLoadDataEvent;
	import com.vit.yahoobrowser.models.IYahooChartModel;
	import com.vit.yahoobrowser.models.IYahooDataModel;
	import com.vit.yahoobrowser.models.YahooChartModel;
	import com.vit.yahoobrowser.models.YahooDataListModel;
	import com.vit.yahoobrowser.services.app.IYahooDataSertvice;
	import com.vit.yahoobrowser.services.app.YahooDataService;
	import com.vit.yahoobrowser.views.CompaniesListMediator;
	import com.vit.yahoobrowser.views.CompaniesListView;
	import com.vit.yahoobrowser.views.CompanyChartManagerMediator;
	import com.vit.yahoobrowser.views.CompanyChartManagerView;
	import com.vit.yahoobrowser.views.CompanyChartMediator;
	import com.vit.yahoobrowser.views.CompanyChartView;
	import com.vit.yahoobrowser.views.IndustryListMediator;
	import com.vit.yahoobrowser.views.IndustryListView;
	import com.vit.yahoobrowser.views.IndustryManagerMediator;
	import com.vit.yahoobrowser.views.IndustryManagerView;
	
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
			commandMap.map(YahooCompanyEvent.COMPANY_CHANGED, YahooCompanyEvent).toCommand(YahooCompanyChangeCommand);
			
			commandMap.map(DataLoaderEvent.EVENT_DATA_LOADED, DataLoaderEvent).toCommand(YahooLoadedDataCommand);
			commandMap.map(DataLoaderEvent.EVENT_DATA_FAILED, DataLoaderEvent).toCommand(YahooLoadedDataCommand);
			
			injector.map(IYahooDataSertvice).toSingleton(YahooDataService);
			injector.map(IYahooDataModel).toSingleton(YahooDataListModel);
			injector.map(IYahooChartModel).toSingleton(YahooChartModel);
			
			mediatorMap.map(IndustryManagerView).toMediator(IndustryManagerMediator);
			mediatorMap.map(IndustryListView).toMediator(IndustryListMediator);
			mediatorMap.map(CompaniesListView).toMediator(CompaniesListMediator);
			mediatorMap.map(CompanyChartView).toMediator(CompanyChartMediator);
			mediatorMap.map(CompanyChartManagerView).toMediator(CompanyChartManagerMediator);
			
			context.afterInitializing(init);
		}
		
		private function init():void
		{
			eventDispatcher.dispatchEvent(new Event(Event.INIT));
		}
	}
}