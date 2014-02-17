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
			//addContextListener(YahooChartEvent.CHART_DATA_CHANGED, onChartDataChanged, YahooChartEvent);
			//addContextListener(YahooCompanyEvent.COMPANY_CHANGED, onCompanyChanged, YahooCompanyEvent);
		}
	}
}