package com.vit.yahoobrowser.models.vo
{
	import mx.collections.ArrayList;

	public interface IIndustryVO
	{
		function get id():int;
		function get name():String;
		function get children():ArrayList;
		
		function get isFavorite():Boolean;
		function set isFavorite(value:Boolean):void;
		
		function get isOpened():Boolean;
		function set isOpened(value:Boolean):void;
		
		function get isCurrent():Boolean;
		function set isCurrent(value:Boolean):void;
		
		function clone(emptySectors:Boolean = false):IIndustryVO;
	}
}