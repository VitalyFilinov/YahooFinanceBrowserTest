package com.vit.yahoobrowser.events
{
	import flash.events.Event;
	
	public class YahooChartEvent extends Event
	{
		public static const CHART_DATA_CHANGED:String = "chart_data_changed";
		public static const CHART_DATA_UPDATE:String = "chart_data_update";
		public static const CHART_DATA_ERROR:String = "chart_data_error";
		
		private var _symbol:String;
		private var _startDate:Date;
		private var _endDate:Date;
		
		public function YahooChartEvent(type:String, symbol:String = null, startDate:Date = null, endDate:Date = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_symbol = symbol;
			_startDate = startDate;
			_endDate = endDate;
		}

		public function get symbol():String
		{
			return _symbol;
		}
		
		public function get startDate():Date
		{
			return _startDate;
		}
		
		public function get endDate():Date
		{
			return _endDate;
		}
		
		override public function clone():Event
		{
			return new YahooChartEvent(type, symbol, startDate, endDate, bubbles, cancelable);
		}

	}
}