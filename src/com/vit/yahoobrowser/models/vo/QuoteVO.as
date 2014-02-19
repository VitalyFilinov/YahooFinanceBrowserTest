package com.vit.yahoobrowser.models.vo
{
	import mx.formatters.DateFormatter;

	public class QuoteVO
	{
		/**
		 * The date of the quote
		 */
		private var _date:Date;
		/**
		 * The open price of the quote
		 */
		private var _open:Number;
		/**
		 * The high price of the quote.
		 */
		private var _high:Number;
		/**
		 * The low price of the quote.
		 */
		private var _low:Number;
		/**
		 * The close price of the quote.
		 */
		private var _close:Number;
		/**
		 * The volume value of the quote.
		 */
		private var _volume:Number;
		/**
		 * The adjust close value of the quote.
		 */
		private var _adjClose:Number;
		/**
		 * The string representing a date of the quote.
		 */
		private var _dateString:String;
		
		/**
		 * QuoteVO is value object used to store the quote data.
		 * @param date:Date			- the date of the quote.
		 * @param open:Number		- the open price of the quote.
		 * @param high:Number		- the high price of the quote.
		 * @param low:Number		- the low price of the quote.
		 * @param close:Number		- the close price of the quote.
		 * @param volume:Number		- the volume value of the quote.
		 * @param adjClose:Number	- the adjust close value of the quote.
		 */
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

		/**
		 * Returns the date of the quote.
		 */
		public function get date():Date
		{
			return _date;
		}
		
		/**
		 * Returns the open price of the quote.
		 */
		public function get open():Number
		{
			return _open;
		}
		
		/**
		 * Returns the high price of the quote.
		 */
		public function get high():Number
		{
			return _high;
		}
		
		/**
		 * Returns the low price of the quote.
		 */
		public function get low():Number
		{
			return _low;
		}
		
		/**
		 * Returns the close price of the quote.
		 */
		public function get close():Number
		{
			return _close;
		}
		
		/**
		 * Returns the volume value of the quote.
		 */
		public function get volume():Number
		{
			return _volume;
		}
		
		/**
		 * Returns the adjust price of the quote.
		 */
		public function get adjClose():Number
		{
			return _adjClose;
		}
		
		/**
		 * Returns the string representing a date of the quote in YYYY-MM-DD format.
		 */
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

	}
}