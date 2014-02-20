/**
 * CompanyChartMediator is created and used as a Mediator of the project robotlegs structure
 * to connect CompanyChartView to the project. 
 */
package com.vit.yahoobrowser.views
{
	import com.vit.yahoobrowser.events.YahooChartEvent;
	import com.vit.yahoobrowser.events.YahooCompanyEvent;
	import com.vit.yahoobrowser.models.IYahooChartModel;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class CompanyChartMediator extends Mediator
	{
		[Inject]
		public var chartModel:IYahooChartModel;
		
		[Inject]
		public var view:CompanyChartView;
		
		override public function initialize():void
		{
			addContextListener(YahooCompanyEvent.COMPANY_CHANGED, onCompanyChanged, YahooCompanyEvent);
			addContextListener(YahooChartEvent.CHART_DATA_CHANGED, onChartDataChanged, YahooChartEvent);
			addContextListener(YahooChartEvent.CHART_DATA_UPDATE, onChartUpdate, YahooChartEvent);
		}
		
		/**
		 * Handles YahooCompanyEvent.COMPANY_CHANGED event dispatched by the context
		 * when the company is changed.
		 * 
		 * Switches view to the loading state.
		 * 
		 * Sets the new symbol name by calling view.setSymbol method using the
		 * symbol name from value object provided by the event.
		 */
		private function onCompanyChanged(event:YahooCompanyEvent):void
		{
			view.setLoading();
			view.setSymbol(event.vo.symbol);
		}
		
		/**
		 * Handles YahooChartEvent.CHART_DATA_CHANGED event dispatched by the context
		 * when the chart data is changed.
		 * 
		 * Sets new chart data by calling view.setChartData method using the data providet by IYahooChartModel.
		 * 
		 * Sets the new symbol name by calling view.setSymbol method using the
		 * symbol name provided by the event.
		 */
		private function onChartDataChanged(event:YahooChartEvent):void
		{
			view.setChartData(chartModel.getChartData());
			view.setSymbol(event.symbol);
		}
		
		/**
		 * Handles YahooChartEvent.CHART_DATA_UPDATE event dispatched by the context
		 * when the chart parameters (symbol, start/end date) are changed.
		 * 
		 * Switches view to the loading state.
		 */
		private function onChartUpdate(event:YahooChartEvent):void
		{
			view.setLoading();
		}
	}
}