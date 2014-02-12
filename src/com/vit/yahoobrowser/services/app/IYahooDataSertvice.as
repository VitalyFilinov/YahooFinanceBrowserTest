package com.vit.yahoobrowser.services.app
{
	import com.vit.yahoobrowser.services.strategies.base.IDataLoaderStrategy;

	public interface IYahooDataSertvice
	{
		function load(strategy:IDataLoaderStrategy):void;
	}
}