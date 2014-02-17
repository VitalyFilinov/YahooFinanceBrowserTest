package com.vit.yahoobrowser.events
{
	import flash.events.Event;
	
	public class YahooViewEvent extends Event
	{
		public static const INVOKE_INDUSTRY_BROWSER:String = "view_invoke_industry_browser";
		
		public function YahooViewEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}