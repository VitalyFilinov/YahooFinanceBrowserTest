package com.vit.yahoobrowser.models
{
	import com.vit.yahoobrowser.models.vo.IChartVO;

	public interface IYahooChartModel
	{
		function setStartDate(value:Date):void;
		function getStartDate():Date;
		function setEndDate(value:Date):void;
		function getEndDate():Date;
		function setCurrentSymbol(value:String):void;
		function getCurrentParams():Object;
		function setChartData(loadedData:Object):void;
		function getChartData():IChartVO;
	}
}