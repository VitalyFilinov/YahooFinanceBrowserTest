package com.vit.yahoobrowser.events
{
	import flash.events.ProgressEvent;
	import flash.events.Event;
	
	public class DataLoaderProgressEvent extends ProgressEvent
	{
		private var _loaderID:String;
		
		public function DataLoaderProgressEvent(type:String, loaderID:String, bubbles:Boolean=false, cancelable:Boolean=false, bytesLoaded:Number=0, bytesTotal:Number=0)
		{
			super(type, bubbles, cancelable, bytesLoaded, bytesTotal);
		}
		
		public function get loaderID():String
		{
			return _loaderID;
		}
		
		override public function clone():Event
		{
			return new DataLoaderProgressEvent(type, loaderID, bubbles, cancelable, bytesLoaded, bytesTotal);
		}
	}
}