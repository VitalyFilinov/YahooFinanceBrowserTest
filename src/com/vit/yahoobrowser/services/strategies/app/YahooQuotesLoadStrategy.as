package com.vit.yahoobrowser.services.strategies.app
{
	import com.vit.yahoobrowser.models.YahooLoaderDataTypes;
	import com.vit.yahoobrowser.models.vo.ChartVO;
	import com.vit.yahoobrowser.models.vo.QuoteVO;
	import mx.formatters.DateFormatter;
	
	/**
	 * The member of the Strategy pattern to load quotes from the YQL
	 * according to the company id.
	 */
	public class YahooQuotesLoadStrategy extends YahooDataLoadStrategy
	{
		/**
		 * The company symbol name.
		 */
		private var companySymbol:String;
		/**
		 * The start date to be used to load quotes.
		 */
		private var startDate:Date;
		/**
		 * The end date to be used to load quotes.
		 */
		private var endDate:Date;
		
		/**
		 * Formats dates to the string in YYYY-MM-DD format
		 * and returns current strategy query.
		 */
		override protected function get query():String
		{
			var dateFormatter:DateFormatter = new DateFormatter();
				dateFormatter.formatString = "YYYY-MM-DD";
			
			var startDateString:String = dateFormatter.format(startDate);
			var endDateString:String = dateFormatter.format(endDate);
			
			return 'select * from yahoo.finance.historicaldata where symbol="' + companySymbol + '" and startDate="' + startDateString +'" and endDate="' + endDateString + '"';
		}
		
		/**
		 * Returns the id of the strategy.
		 */
		override public function get id():String
		{
			return YahooLoaderDataTypes.QUOTES;
		}
		
		/**
		 * Returns the object of the parsed loaded data.
		 * if json.query.results.quote,
		 * returns the ChartVO with empty array of quotes.
		 * 
		 * Otherwise returns Array of QuoteVO
		 * created from received array of objects.
		 * 
		 * Saves minimum/maximum start/end data values during the main loop.
		 * 
		 * @param data:Object - object to be parsed.
		 */
		override public function parse(data:Object):Object
		{
			var json:Object = JSON.parse(data as String);
			
			if(!json || !json.query || !json.query.results || !json.query.results.quote)
			{
				trace(this, "parse: ERROR >> Wrong object in data!");
				return new ChartVO(companySymbol, startDate, endDate, 0, 0, []);
			}
			
			var quotesData:Array = json.query.results.quote as Array;
			
			var quotes:Array = new Array();
			var aLen:int = quotesData.length;
			
			var startDate:Date = new Date();
			var endDate:Date = new Date(0);
			var minClose:Number = 999999999;
			var maxClose:Number = 0;
			var symbol:String;
			
			var quote:QuoteVO;
			
			for(var a:int = 0; a<aLen; a++)
			{
				quote = new QuoteVO(
					new Date(Date.parse(quotesData[a].Date.split("-").join("/"))),
					Number(quotesData[a].Open),
					Number(quotesData[a].High),
					Number(quotesData[a].Low),
					Number(quotesData[a].Close),
					Number(quotesData[a].Volume),
					Number(quotesData[a].Adj_Close));
					
					if(!symbol)
					{
						symbol = quotesData[a].Symbol;
					}
					
					if(startDate > quote.date)
					{
						startDate = quote.date;
					}
					
					if(endDate < quote.date)
					{
						endDate = quote.date;
					}
					
					if(maxClose < quote.close)
					{
						maxClose = quote.close;
					}
					
					if(minClose > quote.close)
					{
						minClose = quote.close;
					}
						
				quotes[quotes.length] = quote;
			}
			
			return new ChartVO(symbol, startDate, endDate, minClose, maxClose, quotes);
		}
		
		/**
		 * Sets additional loading parameters.
		 * @param:params:Object
		 */
		override public function setParams(params:Object):void
		{
			companySymbol = params.symbol;
			startDate = params.startDate;
			endDate = params.endDate;
		}
	}
	
}