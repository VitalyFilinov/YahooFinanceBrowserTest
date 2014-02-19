/**
 * IDataLoaderStrategy used in YahooDataServiceStrategy to implement pattern Strategy
 */
package com.vit.yahoobrowser.services.strategies.base
{
	import flash.net.URLRequest;

	public interface IDataLoaderStrategy
	{
		/**
		 * Returns the id of the strategy.
		 */
		function get id():String;
		/**
		 * Returns URLRequest created according to current situation.
		 */
		function get request():URLRequest;
		/**
		 * Returns the object of the loaded data parsed according to current situation.
		 * @param data:Object - object to be parsed.
		 */
		function parse(data:Object):Object;
		/**
		 * Sets additional loading parameters.
		 * @param:params:Object
		 */
		function setParams(params:Object):void;
	}
}