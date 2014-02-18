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
			addContextListener(YahooCompanyEvent.COMPANY_CHANGED, onCompanySelected, YahooCompanyEvent);
			
			addViewListener(YahooChartEvent.CHART_DATA_UPDATE, dispatch, YahooChartEvent);
			
			view.setDates(chartModel.getStartDate(), chartModel.getEndDate());
		}
		
		private function onCompanySelected(event:YahooCompanyEvent):void
		{
			view.setSymbol(event.vo.symbol);
		}
	}
}