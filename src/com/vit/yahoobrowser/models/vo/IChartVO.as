package com.vit.yahoobrowser.models.vo
{
	public interface IChartVO
	{
		function get symbol():String;
		function get startDate():Date;
		function get endDate():Date;
		function get minimum():Number;
		function get maximum():Number;
		function get quotes():Array;
	}
}