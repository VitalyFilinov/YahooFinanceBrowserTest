package com.vit.yahoobrowser.views
{
	import com.vit.yahoobrowser.events.YahooLoadDataEvent;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class IndustryManagerMediator extends Mediator
	{
		override public function initialize():void
		{
			addViewListener(YahooLoadDataEvent.LOAD_DATA, dispatch, YahooLoadDataEvent);
		}
	}
}