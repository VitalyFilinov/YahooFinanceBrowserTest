package com.vit.yahoobrowser.models.vo
{
	public interface IIndustryVO
	{
		function get id():int;
		function get name():String;
		
		function get selected():Boolean;
		function set selected(value:Boolean):void;
		
		function get isFavorite():Boolean;
		function set isFavorite(value:Boolean):void;
	}
}