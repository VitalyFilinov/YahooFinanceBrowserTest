package com.vit.yahoobrowser.models.vo
{
	import mx.collections.ArrayList;

	public interface ISectorVO
	{
		function get id():int;
		function get name():String;
		function get industries():ArrayList;
		function get isOpened():Boolean;
		function set isOpened(value:Boolean):void;
		function clone(emptySectors:Boolean = false):ISectorVO;
	}
}