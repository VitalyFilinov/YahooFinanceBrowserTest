package com.vit.yahoobrowser.events
{
	import flash.events.Event;
	
	public class DataLoaderEvent extends Event
	{
		public static const EVENT_DATA_LOADED:String = "event_data_loaded";
		public static const EVENT_DATA_FAILED:String = "event_data_failed";
		
		private var _loadedData:Object;
		private var _dataType:String;
		private var _errorMessage:String;
		
		public function DataLoaderEvent(type:String, loadedData:Object, dataType:String, errorMessage:String = "", bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_loadedData = loadedData;
			_dataType = dataType;
			_errorMessage = errorMessage;
		}
		
		public function get loadedData():Object
		{
			return _loadedData;
		}
		
		public function get dataType():String
		{
			return _dataType;
		}
		
		public function get errorMessage():String
		{
			return _errorMessage;
		}
		
		override public function clone():Event
		{
			return new DataLoaderEvent(type, loadedData, dataType, errorMessage, bubbles, cancelable);
		}
	}
}