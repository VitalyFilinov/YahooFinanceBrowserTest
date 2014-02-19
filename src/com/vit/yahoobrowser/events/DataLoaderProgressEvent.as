package com.vit.yahoobrowser.events
{
	import flash.events.ProgressEvent;
	import flash.events.Event;
	
	public class DataLoaderProgressEvent extends ProgressEvent
	{
		/**
		 * The type of data loaded
		 */
		private var _dataType:String;
		
		/**
		 * Events related to the loading process.
		 * @param type:String - the event type.
		 * @param dataType:String - the type of data loaded.
		 * @param bubbles:Boolean
		 * @param cancelable:Boolean
		 * @param bytesLoaded:Number
		 * @param bytesTotal:Number
		 */
		public function DataLoaderProgressEvent(type:String, dataType:String, bubbles:Boolean=false, cancelable:Boolean=false, bytesLoaded:Number=0, bytesTotal:Number=0)
		{
			super(type, bubbles, cancelable, bytesLoaded, bytesTotal);
			_dataType = dataType;
		}
		
		/**
		 * Returns the type of data loaded.
		 */
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