package com.vit.yahoobrowser.commands
{
	import com.vit.yahoobrowser.events.DataLoaderEvent;
	import com.vit.yahoobrowser.models.IYahooChartModel;
	import com.vit.yahoobrowser.models.IYahooDataModel;
	import com.vit.yahoobrowser.models.YahooLoaderDataTypes;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class YahooLoadedDataCommand extends Command
	{
		[Inject]
		public var dataModel:IYahooDataModel;
		
		[Inject]
		public var chartModel:IYahooChartModel;
		
		[Inject]
		public var event:DataLoaderEvent;
		
		override public function execute():void
		{
			if(event.type == DataLoaderEvent.EVENT_DATA_LOADED)
			{
				if(event.loaderID == YahooLoaderDataTypes.INDUSTRIES)
				{
					dataModel.setIndustries(event.loadedData);
				}
				else if(event.loaderID == YahooLoaderDataTypes.COMPANIES)
				{
					dataModel.setCompanies(event.loadedData);
				}
				else if(event.loaderID == YahooLoaderDataTypes.QUOTES)
				{
					chartModel.setChartData(event.loadedData);
				}
			}
			else if(event.type == DataLoaderEvent.EVENT_DATA_FAILED)
			{
				trace(this, "ERROR >> ", event.errorMessage);	
			}
		}
		
		private function setCurrentChartData(loadedData:Object):void
		{
			// TODO Auto Generated method stub
			
		}
	}
}