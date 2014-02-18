package com.vit.yahoobrowser.models.vo
{
	public interface IChartVO
	{
		function set symbol(value:String):void;
		function get symbol():String;
		
		function set startDate(value:Date):void;
		function get startDate():Date;
			
		function set endDate(value:Date):void;
		function get endDate():Date;
			
		function get minimum():Number;
		function get maximum():Number;
		function get quotes():Array;
	}
}