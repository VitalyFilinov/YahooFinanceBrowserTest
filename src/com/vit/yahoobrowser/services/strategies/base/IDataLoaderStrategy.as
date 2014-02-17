package com.vit.yahoobrowser.services.strategies.base
{
	import flash.net.URLRequest;

	public interface IDataLoaderStrategy
	{
		function get id():String;
		function get request():URLRequest;
		function parse(data:Object):Object;
		function setParams(params:Object):void;
	}
}