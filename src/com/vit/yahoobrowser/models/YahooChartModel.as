/**
* IYahooChartModel is a Model iterface of the project robotlegs structure.
* IYahooChartModel stores quotes data loaded from the data provider database.
* Data stores as IChartVO to simplify data transfer to the system.
*
* The model also stores and returns the start date and the end date separately, 
* to be able to change them before loading any data.
*/
package com.vit.yahoobrowser.models
{
	import com.vit.yahoobrowser.events.YahooChartEvent;
	import com.vit.yahoobrowser.models.vo.IChartVO;
	import flash.events.IEventDispatcher;

	public class YahooChartModel implements IYahooChartModel
	{
		[Inject]
		public var eventDispatcher:IEventDispatcher;
		/**
		 * The start date of the quotes list time period
		 */
		private var startDate:Date;
		/**
		 * The end date of the quotes list time period
		 */
		private var endDate:Date;
		/**
		 * IChartVO stores symbol name, start/end dates, minimum/maximum and quotes list.
		 */
		private var currentData:IChartVO;
		
		/**
		* Sets the start date to be used to load quotes.
		* If no data was loaded (IChartVO was not created) saves value to the variable.
		* Otherwise saves value to IChartVO
		* @param value:Date - the date to be saved as the start date.
		*/
		public function setStartDate(value:Date):void
		{
			if(currentData)
			{
				currentData.startDate = value;
			}
			else
			{
				startDate = value;
			}
		}
		
		/**
		* Returns the start date of the stored data if it is presented.
		* If the data was not stored yet, returns the startDate value.
		* If the startDate was not set, returns the endDate value minus one month.
		*/
		public function getStartDate():Date
		{
			if(currentData)
			{
				return currentData.startDate;
			}
			
			if(!startDate)
			{
				startDate = new Date(getEndDate());
				startDate.month--;
			}

			return startDate;
		}
		
		/**
		* Sets the end date to be used to load quotes.
		* If no data was loaded (IChartVO was not created) saves value to the variable.
		* Otherwise saves value to IChartVO.
		* @param value:Date - the date to be saved as the end date.
		*/
		public function setEndDate(value:Date):void
		{
			if(currentData)
			{
				currentData.endDate = value;
			}
			else
			{
				endDate = value;
			}
		}
		
		/**
		* Returns the end date of the stored data if it is presented.
		* If the data was not stored yet, returns the startDate value.
		* If the startDate was not set, returns new Date (now).
		*/
		public function getEndDate():Date
		{
			if(currentData)
			{
				return currentData.endDate;
			}
			
			if(!endDate)
			{
				endDate = new Date();
			}
			
			return endDate;
		}
		
		/**
		* Sets the chart data and dispatches event.
		* @param loadedData:Object - the chart data. Usually the data from DataLoadStrategy.
		*/
		public function setChartData(loadedData:Object):void
		{
			currentData = loadedData as IChartVO;
			eventDispatcher.dispatchEvent(new YahooChartEvent(YahooChartEvent.CHART_DATA_CHANGED, currentData.symbol));
		}
		
		/**
		* Returns current chart data.
		*/
		public function getChartData():IChartVO
		{
			return currentData;
		}
	}
}