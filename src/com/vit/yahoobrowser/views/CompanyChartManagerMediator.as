/**
 * CompanyChartManagerMediator is created and used as a Mediator of the project robotlegs structure
 * to connect CompanyChartManagerView to the project. 
 */
package com.vit.yahoobrowser.views
{
	import com.vit.yahoobrowser.events.YahooChartEvent;
	import com.vit.yahoobrowser.events.YahooCompanyEvent;
	import com.vit.yahoobrowser.models.IYahooChartModel;
	
	import robotlegs.bender.bundles.mvcs.Mediator;

	public class CompanyChartManagerMediator extends Mediator
	{
		[Inject]
		public var chartModel:IYahooChartModel;
		
		[Inject]
		public var view:CompanyChartManagerView;
		
		override public function initialize():void
		{
			addViewListener(YahooChartEvent.CHART_DATA_UPDATE, dispatch, YahooChartEvent);
			
			addContextListener(YahooCompanyEvent.COMPANY_CHANGED, onCompanySelected, YahooCompanyEvent);
			
			/**
			 * Sets view default dates
			 */
			view.setDates(chartModel.getStartDate(), chartModel.getEndDate());
		}
		
		/**
		 * Handles YahooCompanyEvent.COMPANY_CHANGED event dispatched by the context
		 * when the company is changed.
		 * 
		 * Sets the new symbol name by calling view.setSymbol method using the
		 * symbol name from value object provided by the event.
		 */
		private function onCompanySelected(event:YahooCompanyEvent):void
		{
			view.setSymbol(event.vo.symbol);
		}
	}
}