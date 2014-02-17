package com.vit.yahoobrowser.services.strategies.app
{
	import com.vit.yahoobrowser.services.strategies.base.IDataLoaderStrategy;
	
	import flash.errors.IllegalOperationError;
	import flash.net.URLRequest;

	internal class YahooDataLoadStrategy implements IDataLoaderStrategy
	{
		private const ENV:String = "&env=store://datatables.org/alltableswithkeys";
		private const FORMAT_JSON:String = "&format=json";
		
		protected function get query():String
		{
			throw new IllegalOperationError("query method must be overriden!");
			return "";
		}
		
		public function get id():String
		{
			throw new IllegalOperationError("query id must be overriden!");
			return "";
		}
		
		public function get request():URLRequest
		{
			return new URLRequest("http://query.yahooapis.com/v1/public/yql?q=" + query + FORMAT_JSON + ENV);
		}
		
		public function parse(data:Object):Object
		{
			throw new IllegalOperationError("parse method must be overriden!");
			return null;
		}
		
		public function setParams(params:Object):void
		{
			throw new IllegalOperationError("setParams method must be overriden!");
		}
	}
}