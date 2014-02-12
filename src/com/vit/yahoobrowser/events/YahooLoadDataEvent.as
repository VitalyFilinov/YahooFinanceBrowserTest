package com.vit.yahoobrowser.events
{
	import flash.events.Event;
	
	public class YahooLoadDataEvent extends Event
	{
		public static const LOAD_DATA:String = "yahoo_load_data";
		
		private var _dataType:String;
		
		public function YahooLoadDataEvent(type:String, dataType:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_dataType = dataType;
		}
		
		public function get dataType():String{
			return _dataType;
		}
		
		override public function clone():Event
		{
			return new YahooLoadDataEvent(type, dataType, bubbles, cancelable);
		}
	}
}