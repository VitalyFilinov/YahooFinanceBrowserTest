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
	
	public class YahooDataService implements IYahooDataSertvice
	{
		[Inject]
		public var eventDispatcher:IEventDispatcher;
		
		private var stock:Vector.<DataLoader>;
		
		public function YahooDataService()
		{
		}
		
		public function load(strategy:IDataLoaderStrategy):void
		{
			if(stock)
			{
				// check if strategy is already processing
				var i:int = stock.length;
				while(i--)
				{
					if(stock[i].strategy.id == strategy.id)
					{
						//return;
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
		
		private function createListeners(dispatcher:IEventDispatcher):void
		{
			dispatcher.addEventListener(Event.COMPLETE, completeHandler);
			dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			dispatcher.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
		}
		
		private function removeListeners(dispatcher:IEventDispatcher):void
		{
			dispatcher.removeEventListener(Event.COMPLETE, completeHandler);
			dispatcher.removeEventListener(ProgressEvent.PROGRESS, progressHandler);
			dispatcher.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			dispatcher.removeEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			dispatcher.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
		}
		
		protected function completeHandler(event:Event):void
		{
			var loader:DataLoader = event.target as DataLoader;
			removeListeners(loader);
			
			var i:int = stock.length;
			while(i--)
			{
				if(stock[i].strategy.id == loader.strategy.id)
				{
					stock.splice(i, 1);
				}
			}
			
			eventDispatcher.dispatchEvent(new DataLoaderEvent(DataLoaderEvent.EVENT_DATA_LOADED, loader.strategy.parse(loader.data), loader.strategy.id));
		}
		
		private function progressHandler(event:ProgressEvent):void
		{
			var loader:DataLoader  = event.target as DataLoader;
			eventDispatcher.dispatchEvent(
				new DataLoaderProgressEvent(
					DataLoaderEvent.EVENT_DATA_LOADED, loader.strategy.id, false, false, event.bytesLoaded, event.bytesTotal
				)
			);
		}
		
		private function httpStatusHandler(event:HTTPStatusEvent):void
		{
			var loader:DataLoader = event.target as DataLoader;
			trace(this, "httpStatusHandler >> ", loader.strategy.id, event.type, event.status);
		}
		
		private function securityErrorHandler(event:SecurityErrorEvent):void
		{
			var loader:DataLoader  = event.target as DataLoader;
			eventDispatcher.dispatchEvent(new DataLoaderEvent(DataLoaderEvent.EVENT_DATA_FAILED, null, loader.strategy.id, event.text));
		}
		
		private function ioErrorHandler(event:IOErrorEvent):void
		{
			var loader:DataLoader  = event.target as DataLoader;
			eventDispatcher.dispatchEvent(new DataLoaderEvent(DataLoaderEvent.EVENT_DATA_FAILED, null, loader.strategy.id, event.text));
		}
	}
}