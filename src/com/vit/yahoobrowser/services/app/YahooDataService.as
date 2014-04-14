/**
* YahooDataService is created and used as a Service of the project robotlegs structure.
* YahooDataService provides loading of data from YQL.
* 
* Any count of loaders could be used to load the data asynchronously.
* Loaders (DataLoaders) are indetified by loader strategies id parameter.
* 
* If loader with the same id will be used, the previous loader will be closed before.
*/
package com.vit.yahoobrowser.services.app
{
	import com.vit.yahoobrowser.events.DataLoaderEvent;
	import com.vit.yahoobrowser.services.base.DataLoader;
	import com.vit.yahoobrowser.services.strategies.base.IDataLoaderStrategy;
	
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import com.vit.yahoobrowser.events.DataLoaderProgressEvent;
	
	public class YahooDataService implements IYahooDataService
	{
		[Inject]
		public var eventDispatcher:IEventDispatcher;
		
		/**
		 * The stock of the loaders used.
		 */
		private var stock:Vector.<DataLoader>;
		
		/**
		 * Loads the data by using the strategy request.
		 * If the loader with the same strategy ID is already in use, it will be closed.
		 * Stores new loaders in the stock.
		 * @param strategy:IDataLoaderStrategy - strategy to be used to load the data
		 */
		public function load(strategy:IDataLoaderStrategy):void
		{
			if(stock)
			{
				var i:int = stock.length;
				while(i--)
				{
					if(stock[i].strategy.id == strategy.id)
					{
						DataLoader(stock[i]).close();
						stock.splice(i, 1);
					}
				}
			}
			else
			{
				stock = new Vector.<DataLoader>();
			}
			
			var loader:DataLoader = new DataLoader(strategy);
			stock[stock.length] = loader;
			createListeners(loader);
			trace(this, "LOAD", strategy.request.url);
			loader.load(strategy.request);
		}
		
		/**
		 * Creates listeners for loader
		 * @param dispatcher:IEventDispatcher - DataLoader instance
		 */
		private function createListeners(dispatcher:IEventDispatcher):void
		{
			dispatcher.addEventListener(Event.COMPLETE, completeHandler);
			dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			dispatcher.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
		}
		
		/**
		 * Removes listeners for loader
		 * @param dispatcher:IEventDispatcher - DataLoader instance
		 */
		private function removeListeners(dispatcher:IEventDispatcher):void
		{
			dispatcher.removeEventListener(Event.COMPLETE, completeHandler);
			dispatcher.removeEventListener(ProgressEvent.PROGRESS, progressHandler);
			dispatcher.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			dispatcher.removeEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			dispatcher.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
		}
		
		/**
		 * Handles complete.
		 * Dispatches event with the loader data parsed by loader strategy
		 * and removes the loader.
		 */
		protected function completeHandler(event:Event):void
		{
			var loader:DataLoader = event.target as DataLoader;
			removeListeners(loader);
			
			eventDispatcher.dispatchEvent(new DataLoaderEvent(DataLoaderEvent.EVENT_DATA_LOADED, loader.strategy.parse(loader.data), loader.strategy.id));
			
			trace("VF", "YahooDataService::completeHandler", loader.data);
			
			removeLoader(loader);
		}
		
		/**
		 * Handles progress.
		 * Dispatches DataLoaderProgressEvent event.
		 */
		private function progressHandler(event:ProgressEvent):void
		{
			var loader:DataLoader = event.target as DataLoader;
//			eventDispatcher.dispatchEvent(
//				new DataLoaderProgressEvent(
//					DataLoaderEvent.EVENT_DATA_LOADED, loader.strategy.id, false, false, event.bytesLoaded, event.bytesTotal
//				)
//			);
		}
		
		/**
		 * Handles http status.
		 */
		private function httpStatusHandler(event:HTTPStatusEvent):void
		{
			var loader:DataLoader = event.target as DataLoader;
			trace(this, "httpStatusHandler >> ", loader.strategy.id, event.type, event.status);
		}
		
		/**
		 * Handles sequrity error and
		 * Dispatches DataLoaderEvent.EVENT_DATA_FAILED with the loader strategy id
		 * and removes the loader.
		 */
		private function securityErrorHandler(event:SecurityErrorEvent):void
		{
			trace("VF", "YahooDataService::securityErrorHandler");
			var loader:DataLoader  = event.target as DataLoader;
			eventDispatcher.dispatchEvent(new DataLoaderEvent(DataLoaderEvent.EVENT_DATA_FAILED, null, loader.strategy.id, event.text));
			removeLoader(loader);
		}
		
		/**
		 * Handles IOError
		 * Dispatches DataLoaderEvent.EVENT_DATA_FAILED with the loader strategy id
		 * and removes the loader.
		 */
		private function ioErrorHandler(event:IOErrorEvent):void
		{
			trace("VF", "YahooDataService::ioErrorHandler");
			var loader:DataLoader  = event.target as DataLoader;
			eventDispatcher.dispatchEvent(new DataLoaderEvent(DataLoaderEvent.EVENT_DATA_FAILED, null, loader.strategy.id, event.text));
			removeLoader(loader);
		}
		
		/**
		 * Removes loader from stock.
		 * @param loader:DataLoader - loader to be removed.
		 */
		private function removeLoader(loader:DataLoader):void
		{
			var i:int = stock.length;
			while(i--)
			{
				if(stock[i].strategy.id == loader.strategy.id)
				{
					stock.splice(i, 1);
				}
			}
		}
	}
}