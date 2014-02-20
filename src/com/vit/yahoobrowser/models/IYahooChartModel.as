/**
* IYahooChartModel is a Model iterface of the project robotlegs structure.
* IYahooChartModel stores quotes data loaded from the data provider database.
*/
package com.vit.yahoobrowser.models
{
	import com.vit.yahoobrowser.models.vo.IChartVO;

	public interface IYahooChartModel
	{
		/**
		* Sets the start date to be used to load quotes.
		* @param value:Date - the date to be saved as the start date.
		*/
		function setStartDate(value:Date):void;
		/**
		* Returns the start date.
		*/
		function getStartDate():Date;
		/**
		* Sets the end date to be used to load quotes.
		* @param value:Date - the date to be saved as the end date.
		*/
		function setEndDate(value:Date):void;
		/**
		* Returns the end date.
		*/
		function getEndDate():Date;
		/**
		* Sets the chart data.
		* @param loadedData:Object - the chart data.
		*/
		function setChartData(loadedData:Object):void;
		/**
		* Returns the chart data.
		*/
		function getChartData():IChartVO;
	}
}