package com.vit.yahoobrowser.views
{
	import com.vit.yahoobrowser.events.YahooChartEvent;
	import com.vit.yahoobrowser.events.YahooCompanyEvent;
	import com.vit.yahoobrowser.events.YahooIndustryEvent;
	import com.vit.yahoobrowser.events.YahooLoadDataEvent;
	import com.vit.yahoobrowser.models.IYahooChartModel;
	import com.vit.yahoobrowser.models.IYahooDataModel;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class CompaniesListMediator extends Mediator
	{
		[Inject]
		public var dataModel:IYahooDataModel;
		
		[Inject]
		public var view:CompaniesListView;
		
		override public function initialize():void
		{
			addViewListener(YahooCompanyEvent.COMPANY_SELECTED, onCompanySelected, YahooCompanyEvent);
			
			addContextListener(YahooCompanyEvent.COMPANIES_CHANGED, setCompanies, YahooCompanyEvent);
			addContextListener(YahooIndustryEvent.INDUSTRY_SELECTED, onIndustrySelected, YahooIndustryEvent);
		}
		
		private function onIndustrySelected(event:YahooIndustryEvent):void
		{
			view.setLoading();
		}
		
		private function onCompanySelected(event:YahooCompanyEvent):void
		{
			dataModel.setCurrentCompany(event.vo);
		}
		
		private function setCompanies(event:YahooCompanyEvent):void
		{
			view.setDataProvider(dataModel.getCompanies(), event.error);
		}
	}
}