package com.vit.yahoobrowser.models.vo
{
	public interface IQuoteVO
	{
		function get date():Date;
		function set date(value:Date):void;
		function get open():Number;
		function get close():Number;
		function get high():Number;
		function get low():Number;
		function get volume():Number;
		function get adjClose():Number;
	}
}