/**
 * IYahooDataService is created and used as a Service interface of the project robotlegs structure.
 */
package com.vit.yahoobrowser.services.app
{
	import com.vit.yahoobrowser.services.strategies.base.IDataLoaderStrategy;

	public interface IYahooDataSertvice
	{
		/**
		 * Loads the data using the strategy parameters.
		 * @param strategy:IDataLoaderStrategy - the strategy to be used to load data.
		 */
		function load(strategy:IDataLoaderStrategy):void;
	}
}