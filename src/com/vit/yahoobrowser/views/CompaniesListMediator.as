/**
 * CompaniesListMediator is created and used as a Mediator of the project robotlegs structure
 * to connect CompaniesListView to the project.
 */
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
			
			addContextListener(YahooIndustryEvent.INDUSTRY_SELECTED, onIndustrySelected, YahooIndustryEvent);
			addContextListener(YahooCompanyEvent.COMPANIES_CHANGED, setCompanies, YahooCompanyEvent);
		}
		
		/**
		 * Handles YahooCompanyEvent.COMPANY_SELECTED event dispatched by the view item renderer using bubbles.
		 * Calls IYahooDataModel.setCurrentCompany method and stops immediate propagation of the event.
		 */
		private function onCompanySelected(event:YahooCompanyEvent):void
		{
			dataModel.setCurrentCompany(event.vo);
			event.stopImmediatePropagation();
		}
		
		/**
		 * Handles YahooCompanyEvent.COMPANY_SELECTED event dispatched by the context.
		 * Invoke the loading state in the view.
		 */
		private function onIndustrySelected(event:YahooIndustryEvent):void
		{
			view.setLoading();
		}
		
		/**
		 * Handles YahooCompanyEvent.COMPANIES_CHANGED event dispatched by the context
		 * when the companies list is changed.
		 * Calls view.setDataProvider method with the companies list
		 * provided by IYahooDataModel.
		 */
		private function setCompanies(event:YahooCompanyEvent):void
		{
			view.setDataProvider(dataModel.getCompanies(), event.error);
		}
	}
}