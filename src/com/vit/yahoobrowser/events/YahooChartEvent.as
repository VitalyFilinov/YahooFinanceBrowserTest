package com.vit.yahoobrowser.events
{
	import flash.events.Event;
	
	public class YahooChartEvent extends Event
	{
		public static const CHART_DATA_CHANGED:String = "chart_data_changed";
		
		public function YahooChartEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}