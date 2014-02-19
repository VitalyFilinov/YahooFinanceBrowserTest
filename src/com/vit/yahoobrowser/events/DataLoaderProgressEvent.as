package com.vit.yahoobrowser.events
{
	import flash.events.ProgressEvent;
	import flash.events.Event;
	
	public class DataLoaderProgressEvent extends ProgressEvent
	{
		private var _dataType:String;
		
		public function DataLoaderProgressEvent(type:String, dataType:String, bubbles:Boolean=false, cancelable:Boolean=false, bytesLoaded:Number=0, bytesTotal:Number=0)
		{
			super(type, bubbles, cancelable, bytesLoaded, bytesTotal);
			_dataType = dataType;
		}
		
		public function get dataType():String
		{
			return _dataType;
		}
		
		override public function clone():Event
		{
			return new DataLoaderProgressEvent(type, dataType, bubbles, cancelable, bytesLoaded, bytesTotal);
		}
	}
}