package com.vit.yahoobrowser.models.vo
{
	public interface ISectorVO
	{
		function get id():int;
		function get name():String;
		function get industries():Array;
		function get isOpened():Boolean;
		function set isOpened(value:Boolean):void;
	}
}