package com.vit.yahoobrowser.events
{
	import flash.events.Event;
	
	public class DataLoaderEvent extends Event
	{
		public static const EVENT_DATA_LOADED:String = "event_data_loaded";
		public static const EVENT_DATA_FAILED:String = "event_data_failed";
		
		private var _loadedData:Object;
		private var _loaderID:String;
		private var _errorMessage:String;
		
		public function DataLoaderEvent(type:String, loadedData:Object, loaderID:String, errorMessage:String = "", bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_loadedData = loadedData;
			_loaderID = loaderID;
			_errorMessage = errorMessage;
		}
		
		public function get loadedData():Object
		{
			return _loadedData;
		}
		
		public function get loaderID():String
		{
			return _loaderID;
		}
		
		public function get errorMessage():String
		{
			return _errorMessage;
		}
		
		override public function clone():Event
		{
			return new DataLoaderEvent(type, loadedData, loaderID, errorMessage, bubbles, cancelable);
		}
	}
}