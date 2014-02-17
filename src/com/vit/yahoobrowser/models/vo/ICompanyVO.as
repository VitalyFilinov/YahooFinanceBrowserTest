package com.vit.yahoobrowser.models.vo
{
	public interface ICompanyVO
	{
		function get symbol():String;
		function get name():String;
		function get isCurrent():Boolean
		function set isCurrent(value:Boolean):void
	}
}