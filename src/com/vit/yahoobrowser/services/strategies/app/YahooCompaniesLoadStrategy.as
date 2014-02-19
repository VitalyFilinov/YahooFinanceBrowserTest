package com.vit.yahoobrowser.services.strategies.app
{
	import com.vit.yahoobrowser.models.YahooLoaderDataTypes;
	import com.vit.yahoobrowser.models.vo.CompanyVO;
	import mx.collections.ArrayList;

	/**
	 * The member of the Strategy pattern to load companies from the YQL
	 * according to the industry id.
	 */
	public class YahooCompaniesLoadStrategy extends YahooDataLoadStrategy
	{
		/**
		 * The id of the industry to be used to load industry data.
		 */
		private var industryID:String;
		
		/**
		 * Returns current strategy query.
		 */
		override protected function get query():String
		{
			return "select  *  from  yahoo.finance.industry where id=" + industryID;
		}
		
		/**
		 * Returns the id of the strategy.
		 */
		override public function get id():String
		{
			return YahooLoaderDataTypes.COMPANIES;
		}
		
		/**
		 * Returns the object of the parsed loaded data.
		 * if query.results.industry.company not found in the loaded object,
		 * returns the object with empty array of companies and the error set to true.
		 * 
		 * Otherwise if company is object returns array of one value object
		 * created from received object.
		 * 
		 * Otherwise if company is array returns array of CompanyVO
		 * created from received array of objects.
		 * 
		 * @param data:Object - object to be parsed.
		 */
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
		
		/**
		 * Sets additional loading parameters.
		 * @param:params:Object
		 */
		override public function setParams(params:Object):void
		{
			industryID = params.id;
		}
	}
	
}