package com.vit.yahoobrowser.services.base
{
	import flash.net.URLLoader;
	import com.vit.yahoobrowser.services.strategies.base.IDataLoaderStrategy;
	
	public class DataLoader extends URLLoader {
		
		private var _strategy:IDataLoaderStrategy;
		
		public function DataLoader(strategy:IDataLoaderStrategy)
		{
			_strategy = strategy;
		}	
		
		public function get strategy():IDataLoaderStrategy
		{
			return _strategy;
		}
	}
	
}