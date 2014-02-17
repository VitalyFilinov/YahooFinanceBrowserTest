package com.vit.yahoobrowser.events
{
	import flash.events.Event;
	
	public class YahooLoadDataEvent extends Event
	{
		public static const LOAD_DATA:String = "yahoo_load_data";
		
		private var _dataType:String;
		private var _params:Object;
		
		public function YahooLoadDataEvent(type:String, dataType:String, params:Object = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_dataType = dataType;
			_params = params;
		}
		
		public function get dataType():String
		{
			return _dataType;
		}
		
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