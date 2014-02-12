package com.vit.yahoobrowser.models.vo
{
	public interface ISectorVO
	{
		function get id():int
		function get name():String
		function get industries():Vector.<IIndustryVO>
		function get selected():Boolean
		function set selected(value:Boolean):void
	}
}