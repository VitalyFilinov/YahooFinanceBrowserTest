package com.vit.yahoobrowser.services.base
{
	import flash.net.URLLoader;
	import com.vit.yahoobrowser.services.strategies.base.IDataLoaderStrategy;
	
	public class DataLoader extends URLLoader {
		
		/**
		 * The loader strategy to be used.
		 */
		private var _strategy:IDataLoaderStrategy;
		
		/**
		 * UrlLoader extended class with the additional strategy parameter.
		 * Data loader could be identified by using the strategy.
		 * @param strategy:IDataLoaderStrategy - the loader strategy to be used.
		 */
		public function DataLoader(strategy:IDataLoaderStrategy)
		{
			_strategy = strategy;
		}	
		
		/**
		 * Returns the current loader strategy.
		 */
		public function get strategy():IDataLoaderStrategy
		{
			return _strategy;
		}
	}
	
}