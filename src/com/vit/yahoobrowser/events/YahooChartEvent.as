package com.vit.yahoobrowser.events
{
	import flash.events.Event;
	
	public class YahooChartEvent extends Event
	{
		/**
		 * Dispatches when the new chart data is set
		 */
		public static const CHART_DATA_CHANGED:String = "chart_data_changed";
		/**
		 * Dispatches when the chart parameters (symbol, start/end date) are changed
		 */
		public static const CHART_DATA_UPDATE:String = "chart_data_update";
		/**
		 * Dispatches when chart data loading error detected
		 */
		public static const CHART_DATA_ERROR:String = "chart_data_error";
		/**
		 * The chart symbol.
		 */
		private var _symbol:String;
		/**
		 * The chart start date.
		 */
		private var _startDate:Date;
		/**
		 * The chart end date.
		 */
		private var _endDate:Date;
		
		/**
		 * Events related to the charts.
		 * @param type:String - event.type.
		 * @param symbol:String - the chart symbol.
		 * @param startDate:Date - the chart start date.
		 * @param endDate:Date - the chart end date.
		 * @param bubbles:Boolean
		 * @param cancelable:Boolean
		 */
		public function YahooChartEvent(type:String, symbol:String = null, startDate:Date = null, endDate:Date = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_symbol = symbol;
			_startDate = startDate;
			_endDate = endDate;
		}

		/**
		 * Returns the chart symbol.
		 */
		public function get symbol():String
		{
			return _symbol;
		}
		
		/**
		 * Returns chart start date.
		 */
		public function get startDate():Date
		{
			return _startDate;
		}
		
		/**
		 * Returns chart end date.
		 */
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