package com.vit.yahoobrowser.services.strategies.app
{
	import com.vit.yahoobrowser.models.YahooLoaderDataTypes;
	import com.vit.yahoobrowser.models.vo.IndustryVO;
	import mx.collections.ArrayList;

	/**
	 * The member of the Strategy pattern to load industries from the YQL.
	 */
	public class YahooIndustriesLoadStrategy extends YahooDataLoadStrategy
	{
		/**
		 * Returns current strategy query.
		 */
		override protected function get query():String
		{
			return "select  *  from  yahoo.finance.sectors";
		}
		
		/**
		 * Returns the id of the strategy.
		 */
		override public function get id():String
		{
			return YahooLoaderDataTypes.INDUSTRIES;
		}
		
		/**
		 * Returns the object of the parsed loaded data.
		 * if qquery.results.sector not found query.results.sector is not an Array,
		 * returns the object with empty array of industries.
		 * 
		 * Otherwise returns ArrayList of IndustryVO
		 * created from received array of objects.
		 * 
		 * @param data:Object - object to be parsed.
		 */
		override public function parse(data:Object):Object
		{
			var json:Object = JSON.parse(data as String);
			
			if(!json || !json.query || !json.query.results || !(json.query.results.sector is Array))
			{
				trace(this, "parse: ERROR >> Wrong sectors in data!");
				return [];
			}
			
			var sectorsData:Array = json.query.results.sector as Array;
			
			var sectors:ArrayList = new ArrayList();
			var aLen:int = sectorsData.length;
			
			var industries:ArrayList;
			var industriesData:Array;
			var bLen:int;
			
			for(var a:int = 0; a<aLen; a++)
			{
				industries = new ArrayList();
				
				if(sectorsData[a].industry)
				{
					if(sectorsData[a].industry is Array)
					{
						industriesData = sectorsData[a].industry;
					}
					else
					{
						industriesData = [sectorsData[a].industry];
					}
					
					bLen = industriesData.length;
					for(var b:int = 0; b<bLen; b++)
					{
						industries.addItem(new IndustryVO(industriesData[b].id, industriesData[b].name));
					}
				}
				
				sectors.addItem(new IndustryVO(a, sectorsData[a]["name"], industries));
			}
			
			return sectors;
		}
	}
	
}