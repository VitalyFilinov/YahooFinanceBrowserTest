package com.vit.yahoobrowser.events
{
	import flash.events.Event;
	
	public class YahooViewEvent extends Event
	{
		/**
		 * Dispatches when industry list has to be opened or closed
		 */
		public static const INVOKE_INDUSTRY_BROWSER:String = "view_invoke_industry_browser";
		
		/**
		 * Events related to the view change.
		 * @param type:String - the event type.
		 * @param bubbles:Boolean
		 * @param cancelable:Boolean
		 */
		public function YahooViewEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}