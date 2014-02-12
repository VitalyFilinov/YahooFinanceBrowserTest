package com.vit.yahoobrowser.services.strategies.app
{
	import com.vit.yahoobrowser.models.YahooLoaderDataTypes;
	import com.vit.yahoobrowser.models.vo.IIndustryVO;
	import com.vit.yahoobrowser.models.vo.ISectorVO;
	import com.vit.yahoobrowser.models.vo.IndustryVO;
	import com.vit.yahoobrowser.models.vo.SectorVO;

	public class YahooSectorsLoadStrategy extends YahooDataLoadStrategy
	{
		override protected function get query():String
		{
			return "select  *  from  yahoo.finance.sectors";
		}
		
		override public function get id():String
		{
			return YahooLoaderDataTypes.SECTORS;
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
			sectorsData.reverse();
			
			var sectors:Vector.<ISectorVO> = new Vector.<ISectorVO>();
			var a:int = sectorsData.length;
			
			var industries:Vector.<IIndustryVO> = new Vector.<IIndustryVO>();
			var industriesData:Array;
			var b:int;
			
			while(a--)
			{
				industries = new Vector.<IIndustryVO>();
				
				if(sectorsData.industry)
				{
					industriesData = sectorsData.industry;
					industriesData.revers();
					b = industriesData.length;
					while(b--)
					{
						industries[industries.length] = new IndustryVO(industriesData[b].id, industriesData[b].name);
					}
				}
				
				sectors[sectors.length] = new SectorVO(a, sectorsData[a]["name"], industries);
			}
			
			return sectors;
		}
	}
	
}