package com.vit.yahoobrowser.events
{
	import flash.events.Event;
	
	public class YahooDataEvent extends Event
	{
		public static const SECTOR_OPEN:String = "list_sector_open";
		public static const SECTOR_CLOSE:String = "list_sector_close";
		
		public function YahooDataEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}