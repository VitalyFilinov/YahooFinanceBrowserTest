package com.vit.yahoobrowser.events
{
	import flash.events.Event;
	
	public class YahooLoadDataEvent extends Event
	{
		/**
		 * Dispatches when needs data loading.
		 */
		public static const LOAD_DATA:String = "yahoo_load_data";
		
		/**
		 * The type of data to be loaded.
		 */
		private var _dataType:String;
		/**
		 * The loading parameters.
		 */
		private var _params:Object;
		
		/**
		 * Events related to the load data invoke.
		 * @param type:String - the event type.
		 * @param dataType:String - the type of data to be loaded.
		 * @param params:Object - the loading parameters.
		 * @param bubbles:Boolean
		 * @param cancelable:Boolean
		 */
		public function YahooLoadDataEvent(type:String, dataType:String, params:Object = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_dataType = dataType;
			_params = params;
		}
		
		/**
		 * Returns the type of data to be loaded.
		 */
		public function get dataType():String
		{
			return _dataType;
		}
		
		/**
		 * Returns the loading parameters.
		 */
		public function get params():Object
		{
			return _params;
		}
		
		override public function clone():Event
		{
			return new YahooLoadDataEvent(type, dataType, params, bubbles, cancelable);
		}
	}
}