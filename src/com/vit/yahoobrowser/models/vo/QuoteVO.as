package com.vit.yahoobrowser.models.vo
{
	import mx.formatters.DateFormatter;

	public class QuoteVO
	{
		private var _date:Date;
		private var _open:Number;
		private var _high:Number;
		private var _low:Number;
		private var _close:Number;
		private var _volume:Number;
		private var _adjClose:Number;
		
		private var _dateString:String;
		
		public function QuoteVO(date:Date, open:Number, high:Number, low:Number, close:Number, volume:Number, adjClose:Number)
		{
			_date = date;
			_open = open;
			_close = close;
			_high = high;
			_low = low;
			_volume = volume;
			_adjClose = adjClose;
		}

		public function get date():Date
		{
			return _date;
		}
		
		public function get dateString():String
		{
			if(!_dateString)
			{
				var dateFormatter:DateFormatter = new DateFormatter();
				dateFormatter.formatString = "YYYY-MM-DD";
				_dateString = dateFormatter.format(_date);
			}
			return _dateString;
		}

		public function get open():Number
		{
			return _open;
		}

		public function get high():Number
		{
			return _high;
		}

		public function get low():Number
		{
			return _low;
		}
		
		public function get close():Number
		{
			return _close;
		}

		public function get volume():Number
		{
			return _volume;
		}

		public function get adjClose():Number
		{
			return _adjClose;
		}

	}
}