package com.vit.yahoobrowser.models
{
	import com.vit.yahoobrowser.events.YahooChartEvent;
	import com.vit.yahoobrowser.events.YahooLoadDataEvent;
	import com.vit.yahoobrowser.models.vo.IChartVO;
	import com.vit.yahoobrowser.models.vo.QuoteVO;
	
	import flash.events.IEventDispatcher;
	
	import mx.formatters.DateFormatter;

	public class YahooChartModel implements IYahooChartModel
	{
		[Inject]
		public var eventDispatcher:IEventDispatcher;
		
		private var currentSymbol:String;
		private var startDate:Date;
		private var endDate:Date;
		private var quotes:Vector.<QuoteVO> = new Vector.<QuoteVO>();
		
		private var currentData:IChartVO;
		
		private var dateFormatter:DateFormatter;
		
		public function setStartDate(value:Date):void
		{
			startDate = value;
		}
		
		public function getStartDate():Date
		{
			if(!startDate)
			{
				startDate = new Date(getEndDate());
				startDate.month--;
			}
			return startDate;
		}
		
		public function setEndDate(value:Date):void
		{
			endDate = value;
		}
		
		public function getEndDate():Date
		{
			if(!endDate)
			{
				var now:Date = new Date();
				endDate = new Date(Date.UTC(now.fullYear, now.month, now.date, now.hours, now.minutes, now.milliseconds));
			}
			return endDate;
		}
		
		public function setChartData(loadedData:Object):void
		{
			var data:IChartVO = loadedData as IChartVO;
			if(data.symbol == "Error")
			{
				return;
			}
			
			currentData = data;
			eventDispatcher.dispatchEvent(new YahooChartEvent(YahooChartEvent.CHART_DATA_CHANGED));
		}
		
		public function getChartData():IChartVO
		{
			return currentData;
		}
		
		public function setCurrentSymbol(value:String):void
		{
			currentSymbol = value;
		}
		
		public function getCurrentParams():Object
		{
			if(!dateFormatter)
			{
				dateFormatter = new DateFormatter();
				dateFormatter.formatString = "YYYY-MM-DD";
			}
			
			var startDateString:String = dateFormatter.format(getStartDate());
			var endDateString:String = dateFormatter.format(getEndDate());
			
			return {symbol:currentSymbol, startDate:startDateString, endDate:endDateString};
		}
	}
}