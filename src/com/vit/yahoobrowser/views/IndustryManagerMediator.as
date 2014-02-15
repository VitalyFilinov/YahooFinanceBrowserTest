package com.vit.yahoobrowser.views
{
	import com.vit.yahoobrowser.events.YahooDataEvent;
	import com.vit.yahoobrowser.events.YahooDataSearchEvent;
	import com.vit.yahoobrowser.events.YahooFavoritesEvent;
	import com.vit.yahoobrowser.events.YahooLoadDataEvent;
	import com.vit.yahoobrowser.models.YahooDataModel;
	
	import flash.events.Event;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class IndustryManagerMediator extends Mediator
	{
		[Inject]
		public var dataModel:YahooDataModel;
		
		[Inject]
		public var view:IndustryManagerView;
		
		override public function initialize():void
		{
			addViewListener(YahooLoadDataEvent.LOAD_DATA, dispatch, YahooLoadDataEvent);
			
			addViewListener(YahooFavoritesEvent.ADD, onListCompleted, YahooFavoritesEvent);
			addViewListener(YahooDataSearchEvent.SEARCH, setSearchResult, YahooDataSearchEvent);
			
			setSectors();
			addContextListener(YahooDataEvent.SECTORS_CHANGED, setSectors, Event);
		}
		
		private function onListCompleted(event:YahooFavoritesEvent):void
		{
			dataModel.addFavorites(event.items);
		}
		
		private function setSectors(event:Event = null):void
		{
			view.setSectors(dataModel.getSectors());
		}
		
		private function setSearchResult(event:YahooDataSearchEvent):void
		{
			if(event.searchString.length > 0)
			{
				view.setSearchResult(dataModel.getSearch(event.searchString));
			}
			else
			{
				view.setSectors(dataModel.getSectors());
			}
		}
	}
}