package com.vit.yahoobrowser.commands
{
	import com.vit.yahoobrowser.events.DataLoaderEvent;
	import com.vit.yahoobrowser.models.YahooDataModel;
	import com.vit.yahoobrowser.models.YahooLoaderDataTypes;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class YahooLoadedDataCommand extends Command
	{
		[Inject]
		public var dataModel:YahooDataModel;
		
		[Inject]
		public var event:DataLoaderEvent;
		
		override public function execute():void
		{
			if(event.type == DataLoaderEvent.EVENT_DATA_LOADED)
			{
				if(event.loaderID == YahooLoaderDataTypes.SECTORS)
				{
					dataModel.setSectors(event.loadedData);
				}
			}
			else if(event.type == DataLoaderEvent.EVENT_DATA_FAILED)
			{
				trace(this, "ERROR >> ", event.errorMessage);	
			}
			
		}
	}
}