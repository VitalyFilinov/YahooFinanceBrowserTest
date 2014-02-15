package com.vit.yahoobrowser.views
{
	import com.vit.yahoobrowser.events.YahooDataEvent;
	import com.vit.yahoobrowser.models.YahooDataModel;
	
	import flash.events.Event;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class SectorsListMediator extends Mediator
	{
		[Inject]
		public var dataModel:YahooDataModel;
		
		[Inject]
		public var view:SectorsListView;
		
		override public function initialize():void
		{
			setSectors();
			addContextListener(YahooDataEvent.SECTORS_CHANGED, setSectors, Event);
		}
		
		private function setSectors(event:Event = null):void
		{
			view.setData(dataModel.getSectors());
		}
	}
}