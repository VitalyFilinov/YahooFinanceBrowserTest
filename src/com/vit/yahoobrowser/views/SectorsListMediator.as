package com.vit.yahoobrowser.views
{
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	import flash.events.Event;
	
	import com.vit.yahoobrowser.events.YahooDataEvent;
	import com.vit.yahoobrowser.models.YahooDataModel;
	
	public class SectorsListMediator extends Mediator
	{
		[Inject]
		public var dataModel:YahooDataModel;
		
		[Inject]
		public var view:SectorsListView;
		
		override public function initialize():void
		{
			addContextListener(YahooDataEvent.SECTORS_CHANGED, onSectorsChanged, Event);
		}
		
		private function onSectorsChanged(event:Event):void
		{
			view.setData(dataModel.getCurrentSectorsList());
		}
	}
}