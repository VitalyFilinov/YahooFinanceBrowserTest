package com.vit.yahoobrowser.services.strategies.app
{
	import com.vit.yahoobrowser.models.YahooLoaderDataTypes;
	import com.vit.yahoobrowser.services.strategies.base.IDataLoaderStrategy;
	
	import flash.net.URLRequest;

	public class YahooDataServiceStrategy implements IDataLoaderStrategy
	{
		/**
		 * Current used strategy
		 */
		private var _strategy:IDataLoaderStrategy;
		
		/**
		 * Main Strategy pattern class to load data from the data provider.
		 * @param strategyType:String - type of the strategy.
		 * @param params:Object - additional loading parameters.
		 */
		public function YahooDataServiceStrategy(strategyType:String, params:Object = null)
		{
			if(strategyType == YahooLoaderDataTypes.INDUSTRIES)
			{
				setStrategy(new YahooIndustriesLoadStrategy());
			}
			else if(strategyType == YahooLoaderDataTypes.COMPANIES)
			{
				setStrategy(new YahooCompaniesLoadStrategy());
			}
			else if(strategyType == YahooLoaderDataTypes.QUOTES)
			{
				setStrategy(new YahooQuotesLoadStrategy());
			}
			
			if(params != null)
			{
				setParams(params);
			}
		}
		
		/**
		 * Sets current stategy
		 * @param strategy:IDataLoaderStrategy - the strategy to be used as current.
		 */
		private function setStrategy(strategy:IDataLoaderStrategy):void
		{
			_strategy = strategy;
		}
		
		/**
		 * Returns current strategy id.
		 */
		public function get id():String
		{
			return _strategy.id;
		}
		
		/**
		 * Returns current stategy URLRequest created according to current situation.
		 */
		public function get request():URLRequest
		{
			return _strategy.request;
		}
		
		/**
		 * Returns the object of the loaded data parsed according to current situation.
		 * @param data:Object - object to be parsed.
		 */
		public function parse(data:Object):Object
		{
			return _strategy.parse(data);
		}
		
		/**
		 * Sets the additional loading parameters.
		 * @param data:Object - the additional loading parameters.
		 */
		public function setParams(params:Object):void
		{
			return _strategy.setParams(params);
		}
	}
}