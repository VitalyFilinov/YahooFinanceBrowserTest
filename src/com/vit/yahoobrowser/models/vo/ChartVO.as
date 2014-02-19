package com.vit.yahoobrowser.models.vo
{
	public class ChartVO implements IChartVO
	{
		/**
		 * The symbol name of current chart data.
		 */
		private var _symbol:String;
		/**
		 * The start date of current chart data time period.
		 */
		private var _startDate:Date;
		/**
		 * The end date of current chart data time period.
		 */
		private var _endDate:Date;
		/**
		 * The minimum value of current chart data quotes.
		 */
		private var _minimum:Number;
		/**
		 * The maximum value of current chart data quotes.
		 */
		private var _maximum:Number;
		/**
		 * The quotes list of current chart data.
		 */
		private var _quotes:Array;
		
		/**
		 * ChartVO is value object used to store current chart data.
		 * @param symbol:String		- the symbol name of current chart data.
		 * @param startDate:Date	- the start date of current chart data time period.
		 * @param endDate:Date		- the end date of current chart data time period.
		 * @param minimum:Number	- the minimum value of current chart data quotes.
		 * @param maximum:Number	- the maximum value of current chart data quotes.
		 * @param quotes:Array		- the quotes list of current chart data.
		 */
		public function ChartVO(symbol:String, startDate:Date, endDate:Date, minimum:Number, maximum:Number, quotes:Array)
		{
			_symbol = symbol;
			_startDate = startDate;
			_endDate = endDate;
			_minimum = minimum;
			_maximum = maximum;
			_quotes = quotes;
		}
		
		/**
		 * Sets the symbol name of current chart data.
		 */
		public function set symbol(value:String):void
		{
			_symbol= value;
		}

		/**
		 * Returns the symbol name of current chart data time period.
		 */
		public function get symbol():String
		{
			return _symbol;
		}
		
		/**
		 * Sets the start date of current chart data time period.
		 */
		public function set startDate(value:Date):void
		{
			_startDate = value;
		}
		
		/**
		 * Returns the start date of current chart data time period.
		 */
		public function get startDate():Date
		{
			return _startDate;
		}
		
		/**
		 * Sets the end date of current chart data time period.
		 */
		public function set endDate(value:Date):void
		{
			_endDate = value;
		}

		/**
		 * Returns the end date of current chart data time period.
		 */
		public function get endDate():Date
		{
			return _endDate;
		}
		
		/**
		 * Returns the minimum value of current chart data quotes.
		 */
		public function get minimum():Number
		{
			return _minimum;
		}
		
		/**
		 * Returns the maximum value of current chart data quotes.
		 */
		public function get maximum():Number
		{
			return _maximum;
		}

		/**
		 * Returns the quotes list of current chart data.
		 */
		public function get quotes():Array
		{
			return _quotes;
		}

	}
}