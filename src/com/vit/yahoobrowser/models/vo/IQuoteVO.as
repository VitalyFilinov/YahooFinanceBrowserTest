/**
 * IQuoteVO is value object interface used to store the quote data.
 */
package com.vit.yahoobrowser.models.vo
{
	public interface IQuoteVO
	{
		/**
		 * Returns the date of the quote.
		 */
		function get date():Date;
		/**
		 * Returns the open price of the quote.
		 */
		function get open():Number;
		/**
		 * Returns the high price of the quote.
		 */
		function get high():Number;
		/**
		 * Returns the low price of the quote.
		 */
		function get low():Number;
		/**
		 * Returns the close price of the quote.
		 */
		function get close():Number;
		/**
		 * Returns the volume value of the quote.
		 */
		function get volume():Number;
		/**
		 * Returns the adjust price of the quote.
		 */
		function get adjClose():Number;
		/**
		 * Returns the string representing a date of the quote.
		 */
		function get dateString():String;
	}
}