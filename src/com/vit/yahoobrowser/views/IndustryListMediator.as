/**
 * IndustryListMediator is created and used as a Mediator of the project robotlegs structure
 * to connect IndustryListView to the project. 
 */
package com.vit.yahoobrowser.views
{
	import com.vit.yahoobrowser.events.DataLoaderEvent;
	import com.vit.yahoobrowser.events.YahooIndustryEvent;
	import com.vit.yahoobrowser.events.YahooDataSearchEvent;
	import com.vit.yahoobrowser.events.YahooFavoritesEvent;
	import com.vit.yahoobrowser.events.YahooIndustryEvent;
	import com.vit.yahoobrowser.events.YahooViewEvent;
	import com.vit.yahoobrowser.models.IYahooDataModel;
	import com.vit.yahoobrowser.models.YahooLoaderDataTypes;
	
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
			
			addViewListener(YahooIndustryEvent.SECTOR_OPEN, onSectorOpen, YahooIndustryEvent);
			addViewListener(YahooIndustryEvent.SECTOR_CLOSE, onSectorClose, YahooIndustryEvent);
			
			addContextListener(YahooIndustryEvent.INDUSTRIES_CHANGED, setIndustries, YahooIndustryEvent);
			addContextListener(YahooFavoritesEvent.CHANGED, setFavorites, YahooFavoritesEvent);
			
			addContextListener(YahooDataSearchEvent.SEARCH, setSearch, YahooDataSearchEvent);
			
			addContextListener(YahooViewEvent.INVOKE_INDUSTRY_BROWSER, onIndustryBrowserInvoke, YahooViewEvent);
			addContextListener(DataLoaderEvent.EVENT_DATA_LOADED, onDataLoaded, DataLoaderEvent);
			
			addViewListener(YahooIndustryEvent.INDUSTRY_SELECTED, dispatch, YahooIndustryEvent);
			
			setIndustries();
			setFavorites();
		}
		
		/**
		 * Handles YahooFavoritesEvent.ADD event dispatched by the view item renderer using bubbles.
		 * Calls IYahooDataModel.addFavorite method and stops immediate propagation of the event.
		 */
		private function onFavoriteAdd(event:YahooFavoritesEvent):void
		{
			dataModel.addFavorite(event.item);
			event.stopImmediatePropagation();
		}
		
		/**
		 * Handles YahooFavoritesEvent.REMOVE or YahooFavoritesEvent.COMPLETE_REMOVE event
		 * dispatched by the view item renderer using bubbles.
		 * Calls IYahooDataModel.removeFavorite method and stops immediate propagation of the event.
		 */
		private function onFavoriteRemove(event:YahooFavoritesEvent):void
		{
			dataModel.removeFavorite(event.item, event.type == YahooFavoritesEvent.COMPLETE_REMOVE);
			event.stopImmediatePropagation();
		}
		
		/**
		 * Handles YahooFavoritesEvent.SAVE event dispatched by the view.
		 * Calls IYahooDataModel.saveFavorites method.
		 */
		private function onFavoritesSave(event:YahooFavoritesEvent):void
		{
			dataModel.saveFavorites();
		}
		
		/**
		 * Handles YahooFavoritesEvent.RESET event dispatched by the view.
		 * Calls IYahooDataModel.resetFavorites method.
		 */
		private function onFavoritesReset(event:YahooFavoritesEvent):void
		{
			dataModel.resetFavorites();
		}
		
		/**
		 * Handles YahooIndustryEvent.SECTOR_OPEN event dispatched by the view item renderer using bubbles.
		 * Calls IYahooDataModel.openItem method and stops immediate propagation of the event.
		 */
		private function onSectorOpen(event:YahooIndustryEvent):void
		{
			dataModel.openItem(view.getIndustriesDataProvider() as ArrayList, event.target.itemIndex);
			event.stopImmediatePropagation();
		}
		
		/**
		 * Handles YahooIndustryEvent.SECTOR_CLOSE event dispatched by the view item renderer using bubbles.
		 * Calls IYahooDataModel.closeItem method and stops immediate propagation of the event.
		 */
		private function onSectorClose(event:YahooIndustryEvent):void
		{
			dataModel.closeItem(view.getIndustriesDataProvider() as ArrayList, event.target.itemIndex);
			event.stopImmediatePropagation();
		}
		
		/**
		 * Handles YahooIndustryEvent.INDUSTRIES_CHANGED event dispatched by the context
		 * when the industries list is changed.
		 * Calls view.setIndustriesDataProvider method with the industries list
		 * provided by IYahooDataModel.
		 */
		private function setIndustries(event:YahooIndustryEvent = null):void
		{
			view.setIndustriesDataProvider(dataModel.getIndustries());
		}
		
		/**
		 * Handles YahooFavoritesEvent.CHANGED event dispatched by the context
		 * when the favorites list is changed.
		 * Calls view.setFavoritesDataProvider method with the favorites list
		 * provided by IYahooDataModel.
		 */
		private function setFavorites(event:YahooFavoritesEvent = null):void
		{
			view.setFavoritesDataProvider(dataModel.getFavorites());
		}
		
		/**
		 * Handles YahooDataSearchEvent.SEARCH event dispatched by the context
		 * when the search is processed by the user.
		 * If event.searchString is not empty calls view.setIndustriesDataProvider with found industries list,
		 * provided by IYahooDataModel.
		 * 
		 * Otherwise sets the full industries list.
		 */
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
		
		/**
		 * Handles YahooViewEvent.INVOKE_INDUSTRY_BROWSER event dispatched by the context.
		 * The state of the view will be switched by calling view.invokeIndustriesState method.
		 */
		private function onIndustryBrowserInvoke(event:YahooViewEvent):void
		{
			view.invokeIndustriesState();
		}
		
		/**
		 * Handles DataLoaderEvent.EVENT_DATA_LOADED  event dispatched by the context,
		 * calls the appropriate method in the view and remmves listener.
		 * 
		 * In our case the industries data is loaded only once.
		 * When the industries data is loaded the DataLoaderEvent.EVENT_DATA_LOADED event listener
		 * has to be removed at all.
		 * @param	event
		 */
		private function onDataLoaded(event:DataLoaderEvent):void
		{
			if(event.dataType == YahooLoaderDataTypes.INDUSTRIES)
			{
				view.setDataLoaded();
				removeContextListener(DataLoaderEvent.EVENT_DATA_LOADED, onDataLoaded, DataLoaderEvent);
			}
		}
	}
}