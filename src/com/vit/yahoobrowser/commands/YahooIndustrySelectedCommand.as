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