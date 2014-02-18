package com.vit.yahoobrowser.models.vo
{
	public class ChartVO implements IChartVO
	{
		private var _symbol:String;
		private var _startDate:Date;
		private var _endDate:Date;
		private var _minimum:Number;
		private var _maximum:Number;
		private var _quotes:Array;
		
		public function ChartVO(symbol:String, startDate:Date, endDate:Date, minimum:Number, maximum:Number, quotes:Array)
		{
			_symbol = symbol;
			_startDate = startDate;
			_endDate = endDate;
			_minimum = minimum;
			_maximum = maximum;
			_quotes = quotes;
		}
		
		public function set symbol(value:String):void
		{
			_symbol= value;
		}

		public function get symbol():String
		{
			return _symbol;
		}
		
		public function set startDate(value:Date):void
		{
			_startDate = value;
		}

		public function get startDate():Date
		{
			return _startDate;
		}
		
		public function set endDate(value:Date):void
		{
			_endDate = value;
		}

		public function get endDate():Date
		{
			return _endDate;
		}
		
		public function get minimum():Number
		{
			return _minimum;
		}
		
		public function get maximum():Number
		{
			return _maximum;
		}

		public function get quotes():Array
		{
			return _quotes;
		}

	}
}