package com.vit.yahoobrowser.services.strategies.app
{
	import com.vit.yahoobrowser.models.YahooLoaderDataTypes;
	import com.vit.yahoobrowser.models.vo.IndustryVO;
	
	import mx.collections.ArrayList;

	public class YahooIndustriesLoadStrategy extends YahooDataLoadStrategy
	{
		override protected function get query():String
		{
			return "select  *  from  yahoo.finance.sectors";
		}
		
		override public function get id():String
		{
			return YahooLoaderDataTypes.INDUSTRIES;
		}
		
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