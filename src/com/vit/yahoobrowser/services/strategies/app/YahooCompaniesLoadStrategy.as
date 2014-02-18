package com.vit.yahoobrowser.services.strategies.app
{
	import com.vit.yahoobrowser.models.YahooLoaderDataTypes;
	import com.vit.yahoobrowser.models.vo.CompanyVO;
	
	import mx.collections.ArrayList;

	public class YahooCompaniesLoadStrategy extends YahooDataLoadStrategy
	{
		private var industryID:String;
		
		override protected function get query():String
		{
			return "select  *  from  yahoo.finance.industry where id=" + industryID;
		}
		
		override public function get id():String
		{
			return YahooLoaderDataTypes.COMPANIES;
		}
		
		override public function parse(data:Object):Object
		{
			var json:Object = JSON.parse(data as String);
			var companiesData:Array;
			var error:Boolean = false;
			
			if(!json || !json.query || !json.query.results || !json.query.results.industry)
			{
				trace(this, "parse: ERROR >> Wrong object in data!");
				error = true;
				companiesData = [];
			}
			else if(!json.query.results.industry.company)
			{
				companiesData = [];
				error = true;
				trace(this, "No companies included in industry", json.query.results.industry.id);
			}
			else if(json.query.results.industry.company is Array)
			{
				companiesData = json.query.results.industry.company as Array;
			}
			else
			{
				companiesData = [json.query.results.industry.company];
			}
			
			var companies:ArrayList = new ArrayList();
			var aLen:int = companiesData.length;
			
			for(var a:int = 0; a<aLen; a++)
			{
				companies.addItem(new CompanyVO(companiesData[a].symbol, companiesData[a].name));
			}
			
			return {data:companies, id:json.query.results.industry.id, error:error};
		}
		
		override public function setParams(params:Object):void
		{
			industryID = params.id;
		}
	}
	
}