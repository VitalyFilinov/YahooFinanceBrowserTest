package com.vit.yahoobrowser.models
{
	import com.vit.yahoobrowser.events.YahooChartEvent;
	import com.vit.yahoobrowser.models.vo.IChartVO;
	import com.vit.yahoobrowser.models.vo.QuoteVO;
	
	import flash.events.IEventDispatcher;
	
	import mx.formatters.DateFormatter;

	public class YahooChartModel implements IYahooChartModel
	{
		[Inject]
		public var eventDispatcher:IEventDispatcher;
		
		private var startDate:Date;
		private var endDate:Date;
		private var quotes:Vector.<QuoteVO> = new Vector.<QuoteVO>();
		
		private var currentData:IChartVO;
		
		private var dateFormatter:DateFormatter;
		
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
		
		public function setChartData(loadedData:Object):void
		{
			currentData = loadedData as IChartVO;
			eventDispatcher.dispatchEvent(new YahooChartEvent(YahooChartEvent.CHART_DATA_CHANGED, currentData.symbol));
		}
		
		public function getChartData():IChartVO
		{
			return currentData;
		}
	}
}