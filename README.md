The project is created by usign Flash Builder 4.6
The project uses robotlegs 2.0 architecture.

The data is stored in two models:
	IYahooDataModel - stores the industries data;
	IYahooChartModel - stores the chart data.
	
There are four types of data stored in IYahooDataModel:
- industries
- companies
- favorites
- search

All data stored as ArrayList to be compatible with DataGroup dataProvider (implemented IList)
The IYahooDataModel also provide adding and removing components from/to industries list
to make industries list view openable (openItem, closeItem).

The YahooDataModel makes search by name field through industries using user defined string (getSearch)
The YahooDataModel creates temporary favorites list (tmpFavorites) until user confirm or cancel select
favorites process. When select favorites process finished, tmpFavorites are copied to main favorites
list or cleared depending on user choice.

IYahooChartModel stores quotes data loaded from the data provider database.
Data stores as IChartVO to simplify data transfer to the system.
The model also stores and returns the start date and the end date separately, 
to be able to change them before loading any data.

All data is loaded fro YQL database using YahooDataService.
YahooDataService is used IDataLoaderStrategy to load data.
All strategies are implements IDataLoaderStrategy and Strategy pattern and extends YahooDataLoadStrategy.
Creating the YahooDataServiceStrategy the strategy type is provided. According to startegy type
YahooDataServiceStrategy creates the appropriate strategy instance.

Each startegy has specific SQL query. Using the query the startegy instance creates and returns URLRequest,
which is used by YahooDataService to load data.

Loaded data is parsed by strategy's parse method and sends to appropriate models using
DataLoaderEvent.EVENT_DATA_LOADED and YahooLoadedDataCommand. The models stores the data and
dispatches events to views.