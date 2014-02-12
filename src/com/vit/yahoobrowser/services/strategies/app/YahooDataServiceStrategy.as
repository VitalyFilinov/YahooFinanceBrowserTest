package com.vit.yahoobrowser.services.strategies.app
{
	import com.vit.yahoobrowser.models.YahooLoaderDataTypes;
	import com.vit.yahoobrowser.services.strategies.base.IDataLoaderStrategy;
	
	import flash.net.URLRequest;
	
	public class YahooDataServiceStrategy implements IDataLoaderStrategy
	{
		private var _strategy:IDataLoaderStrategy;
		
		public function YahooDataServiceStrategy(strategyType:String)
		{
			if(strategyType == YahooLoaderDataTypes.SECTORS)
			{
				setStrategy(new YahooSectorsLoadStrategy());
			}
		}
		
		private function setStrategy(strategy:IDataLoaderStrategy):void
		{
			_strategy = strategy;
		}
		
		public function get id():String
		{
			return _strategy.id;
		}
		
		public function get request():URLRequest
		{
			return _strategy.request;
		}
		
		public function parse(data:Object):Object
		{
			return _strategy.parse(data);
		}
	}
}