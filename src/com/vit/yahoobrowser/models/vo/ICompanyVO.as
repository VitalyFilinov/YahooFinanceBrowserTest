/**
 * ChartVO is value object interface used to store the company data.
 */
package com.vit.yahoobrowser.models.vo
{
	public interface ICompanyVO
	{
		/**
		 * Returns the symbol name of the company.
		 */
		function get symbol():String;
		/**
		 * Returns the name of the company.
		 */
		function get name():String;
		/**
		 * Returns whether the company is current used company or not.
		 */
		function get isCurrent():Boolean
		/**
		 * Sets whether the company is current used company or not.
		 * @param value:Boolean - shows whether the company is current used company or not.
		 */
		function set isCurrent(value:Boolean):void
	}
}