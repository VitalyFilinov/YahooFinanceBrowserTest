package com.vit.yahoobrowser.commands
{
	import com.vit.yahoobrowser.events.YahooDataSearchEvent;
	import com.vit.yahoobrowser.models.IYahooDataModel;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class YahooSearchCommand extends Command
	{
		
		[Inject]
		public var dataModel:IYahooDataModel;
		
		[Inject]
		public var event:YahooDataSearchEvent;
		
		override public function execute():void
		{
			if(event.searchString.length == 0)
			{
				dataModel.clearSearch();
			}
		}
	}
}