/**
 * YahooIndustrySelectedCommand is created and used as a Command of the project robotlegs structure.
 * YahooIndustrySelectedCommand is listen for YahooIndustryEvent.INDUSTRY_SELECTED event.
 * YahooIndustryEvent.INDUSTRY_SELECTED event dispatches when current industry is selected.
 * The command dispatches the YahooLoadDataEvent.LOAD_DATA event to load
 * the companies list from the data provider according to current selected industry using event.id.
 */
package com.vit.yahoobrowser.commands
{
	import com.vit.yahoobrowser.events.YahooIndustryEvent;
	import com.vit.yahoobrowser.events.YahooLoadDataEvent;
	import com.vit.yahoobrowser.models.IYahooDataModel;
	import com.vit.yahoobrowser.models.YahooLoaderDataTypes;
	
	import flash.events.IEventDispatcher;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class YahooIndustrySelectedCommand extends Command
	{
		[Inject]
		public var eventDispatcher:IEventDispatcher;
		
		[Inject]
		public var dataModel:IYahooDataModel;
		
		[Inject]
		public var event:YahooIndustryEvent;
		
		override public function execute():void
		{
			dataModel.setCurrentIndustry(event.vo);
			
			eventDispatcher.dispatchEvent(new YahooLoadDataEvent(YahooLoadDataEvent.LOAD_DATA, YahooLoaderDataTypes.COMPANIES,
					{ id:event.vo.id } ));
		}
	}
}