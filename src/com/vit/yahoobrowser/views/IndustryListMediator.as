package com.vit.yahoobrowser.views
{
	import com.vit.yahoobrowser.events.YahooDataEvent;
	import com.vit.yahoobrowser.events.YahooDataSearchEvent;
	import com.vit.yahoobrowser.events.YahooFavoritesEvent;
	import com.vit.yahoobrowser.events.YahooIndustryEvent;
	import com.vit.yahoobrowser.events.YahooViewEvent;
	import com.vit.yahoobrowser.models.IYahooDataModel;
	
	import mx.collections.ArrayList;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class IndustryListMediator extends Mediator
	{
		[Inject]
		public var dataModel:IYahooDataModel;
		
		[Inject]
		public var view:IndustryListView;
		
		override public function initialize():void
		{
			addViewListener(YahooFavoritesEvent.ADD, onFavoriteAdd, YahooFavoritesEvent);
			addViewListener(YahooFavoritesEvent.REMOVE, onFavoriteRemove, YahooFavoritesEvent);
			addViewListener(YahooFavoritesEvent.COMPLETE_REMOVE, onFavoriteRemove, YahooFavoritesEvent);
			addViewListener(YahooFavoritesEvent.SAVE, onFavoritesSave, YahooFavoritesEvent);
			addViewListener(YahooFavoritesEvent.RESET, onFavoritesReset, YahooFavoritesEvent);
			
			addViewListener(YahooDataEvent.SECTOR_OPEN, onSectorOpen, YahooDataEvent);
			addViewListener(YahooDataEvent.SECTOR_CLOSE, onSectorClose, YahooDataEvent);
			
			addViewListener(YahooIndustryEvent.INDUSTRY_SELECTED, onIndustrySelected, YahooIndustryEvent);
			
			addContextListener(YahooIndustryEvent.INDUSTRIES_CHANGED, setIndustries, YahooIndustryEvent);
			addContextListener(YahooDataSearchEvent.SEARCH, setSearch, YahooDataSearchEvent);
			addContextListener(YahooFavoritesEvent.CHANGED, setFavorites, YahooFavoritesEvent);
			
			addContextListener(YahooViewEvent.INVOKE_INDUSTRY_BROWSER, onIndustryBrowserInvoke, YahooViewEvent);
			
			setIndustries();
			setFavorites();
		}
		
		private function onIndustrySelected(event:YahooIndustryEvent):void
		{
			dataModel.setCurrentIndustry(event.vo);
		}
		
		private function onSectorOpen(event:YahooDataEvent):void
		{
			dataModel.openItem(view.getIndustriesDataProvider() as ArrayList, event.target.itemIndex);
			event.stopImmediatePropagation();
		}
		
		private function onSectorClose(event:YahooDataEvent):void
		{
			dataModel.closeItem(view.getIndustriesDataProvider() as ArrayList, event.target.itemIndex);
			event.stopImmediatePropagation();
		}
		
		private function onIndustryBrowserInvoke(event:YahooViewEvent):void
		{
			view.invokeIndustriesState();
		}
		
		private function onFavoritesReset(event:YahooFavoritesEvent):void
		{
			dataModel.resetFavorites();
		}
		
		private function onFavoritesSave(event:YahooFavoritesEvent):void
		{
			dataModel.saveFavorites();
		}
		
		private function onFavoriteAdd(event:YahooFavoritesEvent):void
		{
			dataModel.addFavorite(event.item);
			event.stopImmediatePropagation();
		}
		
		private function onFavoriteRemove(event:YahooFavoritesEvent):void
		{
			dataModel.removeFavorite(event.item, event.type == YahooFavoritesEvent.COMPLETE_REMOVE);
			event.stopImmediatePropagation();
		}
		
		private function setFavorites(event:YahooFavoritesEvent = null):void
		{
			view.setFavoritesDataProvider(dataModel.getFavorites());
		}
		
		private function setIndustries(event:YahooIndustryEvent = null):void
		{
			view.setIndustriesDataProvider(dataModel.getIndustries());
		}
		
		private function setSearch(event:YahooDataSearchEvent):void
		{
			if(event.searchString.length > 0)
			{
				view.setIndustriesDataProvider(dataModel.getSearch(event.searchString), true);
			}
			else
			{
				setIndustries();
			}
		}
	}
}