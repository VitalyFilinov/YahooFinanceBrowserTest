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
			
			addContextListener(YahooChartEvent.CHART_DATA_UPDATE, onChartUpdate, YahooChartEvent);
		}
		
		private function onChartUpdate(event:YahooChartEvent):void
		{
			view.setLoading();
		}
		
		private function onCompanyChanged(event:YahooCompanyEvent):void
		{
			view.setLoading();
			view.setSymbol(event.vo.symbol);
		}
		
		private function onChartDataChanged(event:YahooChartEvent):void
		{
			view.setChartData(chartModel.getChartData());
			view.setSymbol(event.symbol);
		}
	}
}