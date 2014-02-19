package com.vit.yahoobrowser.events
{
	import flash.events.Event;
	
	public class DataLoaderEvent extends Event
	{
		/**
		 * Dispatches when data loaded successfully
		 */
		public static const EVENT_DATA_LOADED:String = "event_data_loaded";
		/**
		 * Dispatches when data not loaded or loaded with error
		 */
		public static const EVENT_DATA_FAILED:String = "event_data_failed";
		/**
		 * The data loaded.
		 */
		private var _loadedData:Object;
		/**
		 * The type of data loaded.
		 */
		private var _dataType:String;
		/**
		 * The error message.
		 */
		private var _errorMessage:String;
		
		/**
		 * Events related to the data loaded.
		 * @param type:String - the event type.
		 * @param loadedData:Object - the data created by YahooDataServiceStrategy.
		 * @param dataType:String - the type of data loaded.
		 * @param errorMessage:String - the error message if error is detected.
		 * @param bubbles:Boolean
		 * @param cancelable:Boolean
		 */
		public function DataLoaderEvent(type:String, loadedData:Object, dataType:String, errorMessage:String = "", bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_loadedData = loadedData;
			_dataType = dataType;
			_errorMessage = errorMessage;
		}
		
		/**
		 * Returns the loaded data.
		 */
		public function get loadedData():Object
		{
			return _loadedData;
		}
		
		/**
		 * Returns type of the loaded data.
		 */
		public function get dataType():String
		{
			return _dataType;
		}
		
		/**
		 * Returns the error message.
		 */
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