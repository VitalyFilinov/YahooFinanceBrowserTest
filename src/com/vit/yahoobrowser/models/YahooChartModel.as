/**
* YahooChartModel is created and used as a Model of the project robotlegs structure.
* YahooChartModel stores quotes data loaded from YQL database.
* Data stores as IChartVO to simplify data transfer to the system.
*
* The model also stores and returns start date and end date separately
* to be able to change them before loading any data.
*/
package com.vit.yahoobrowser.models
{
	import com.vit.yahoobrowser.events.YahooChartEvent;
	import com.vit.yahoobrowser.models.vo.IChartVO;
	import com.vit.yahoobrowser.models.vo.QuoteVO;
	import flash.events.IEventDispatcher;

	public class YahooChartModel implements IYahooChartModel
	{
		[Inject]
		public var eventDispatcher:IEventDispatcher;
		/**
		 * Start date of quotes list time period
		 */
		private var startDate:Date;
		/**
		 * End date of quotes list time period
		 */
		private var endDate:Date;
		/**
		 * IChartVO stores symbol name, start/end dates, minimum/maximum and quotes list.
		 */
		private var currentData:IChartVO;
		
		/**
		* Sets start date to be used to load quotes.
		* If now data was loaded (IChartVO was not created) saves value to variable.
		* Otherwise saves value to IChartVO
    * @param - value. Date to be saved as start date.
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
		* Returns start date of stored data if it is presented.
		* If data was not stored yet, returns startDate value.
		* If startDate was not set, returns endDate value minus one month.
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
		* Sets end date to be used to load quotes.
		* If now data was loaded (IChartVO was not created) saves value to variable.
		* Otherwise saves value to IChartVO.
		* @param - value. Date to be saved as end date.
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
		* Returns end date of stored data if it is presented.
		* If data was not stored yet, returns startDate value.
		* If startDate was not set, returns new Date (now).
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
		
		/*
		* Sets chart data and dispatches event.
		* @param loadedData - object. Usually data from DataLoadStrategy.
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