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
			addContextListener(YahooChartEvent.CHART_DATA_CHANGED, onChartDataChanged, YahooChartEvent);
			addContextListener(YahooCompanyEvent.COMPANY_CHANGED, onCompanyChanged, YahooCompanyEvent);
		}
		
		private function onCompanyChanged(event:YahooCompanyEvent):void
		{
			//view.setLoading();
		}
		
		private function onChartDataChanged(event:YahooChartEvent):void
		{
			view.setChartData(chartModel.getChartData());
		}
	}
}