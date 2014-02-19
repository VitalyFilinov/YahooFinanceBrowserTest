package com.vit.yahoobrowser.services.strategies.app
{
	import com.vit.yahoobrowser.services.strategies.base.IDataLoaderStrategy;
	
	import flash.errors.IllegalOperationError;
	import flash.net.URLRequest;
	
	/**
	 * The base member class of the Strategy pattern to load data from the data provider.
	 */
	internal class YahooDataLoadStrategy implements IDataLoaderStrategy
	{
		/**
		 * Default YQL environment string to be added to url.
		 */
		private const ENV:String = "&env=store://datatables.org/alltableswithkeys";
		/**
		 * Default YQL json format string to be added to url.
		 */
		private const FORMAT_JSON:String = "&format=json";
		
		/**
		 * Returns current strategy query.
		 * MUST BE OVERRIDEN
		 */
		protected function get query():String
		{
			throw new IllegalOperationError("query method must be overriden!");
			return "";
		}
		
		/**
		 * Returns the id of the strategy.
		 * MUST BE OVERRIDEN
		 */
		public function get id():String
		{
			throw new IllegalOperationError("query id must be overriden!");
			return "";
		}
		/**
		 * Returns URLRequest created according to current query.
		 */
		public function get request():URLRequest
		{
			return new URLRequest("http://query.yahooapis.com/v1/public/yql?q=" + query + FORMAT_JSON + ENV);
		}
		
		/**
		 * Returns the object of the loaded data parsed according to current situation.
		 * @param data:Object - object to be parsed.
		 * MUST BE OVERRIDEN
		 */
		public function parse(data:Object):Object
		{
			throw new IllegalOperationError("parse method must be overriden!");
			return null;
		}
		
		/**
		 * Sets additional loading parameters.
		 * @param:params:Object
		 * MUST BE OVERRIDEN
		 */
		public function setParams(params:Object):void
		{
			throw new IllegalOperationError("setParams method must be overriden!");
		}
	}
}