/**
* IYahooChartModel is a Model iterface of the project robotlegs structure.
* IYahooChartModel stores quotes data loaded from YQL database.
* Data stores as IChartVO to simplify data transfer to the system.
*
* The model also stores and returns start date and end date separately
* to be able to change them before loading any data.
*/
package com.vit.yahoobrowser.models
{
	import com.vit.yahoobrowser.models.vo.IChartVO;

	public interface IYahooChartModel
	{
		/**
		* Sets start date to be used to load quotes.
		*/
		function setStartDate(value:Date):void;
		/**
		* Returns start date.
		*/
		function getStartDate():Date;
		/**
		* Sets start end to be used to load quotes.
		*/
		function setEndDate(value:Date):void;
		/**
		* Returns end date.
		*/
		function getEndDate():Date;
		/**
		* Sets chart data.
		*/
		function setChartData(loadedData:Object):void;
		/**
		* Returns chart data.
		*/
		function getChartData():IChartVO;
	}
}