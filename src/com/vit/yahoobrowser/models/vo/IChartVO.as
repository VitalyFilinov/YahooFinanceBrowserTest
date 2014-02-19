/**
 * IChartVO is value object interface used to store current chart data.
 */
package com.vit.yahoobrowser.models.vo
{
	public interface IChartVO
	{
		/**
		 * Sets the symbol name of current chart data.
		 * @param value:String - the symbol name of current chart data.
		 */
		function set symbol(value:String):void;
		/**
		 * Returns the symbol name of current chart data time period.
		 */
		function get symbol():String;
		/**
		 * Sets the start date of current chart data time period.
		 * @param value:Date - the start date of current chart data time period.
		 */
		function set startDate(value:Date):void;
		/**
		 * Returns the start date of current chart data time period.
		 */
		function get startDate():Date;
		/**
		 * Sets the end date of current chart data time period.
		 * @param value:Date - the end date of current chart data time period.
		 */
		function set endDate(value:Date):void;
		/**
		 * Returns the end date of current chart data time period.
		 */
		function get endDate():Date;
		/**
		 * Returns the minimum value of current chart data quotes.
		 */
		function get minimum():Number;
		/**
		 * Returns the maximum value of current chart data quotes.
		 */
		function get maximum():Number;
		/**
		 * Returns the quotes list of current chart data.
		 */
		function get quotes():Array;
	}
}