package com.vit.yahoobrowser.events
{
	import flash.events.Event;
	
	public class YahooDataSearchEvent extends Event
	{
		public static const SEARCH:String = "data_search";
		
		private var _searchString:String;
		
		public function YahooDataSearchEvent(type:String, searchString:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_searchString = searchString;
		}

		public function get searchString():String
		{
			return _searchString;
		}
		
		override public function clone():Event
		{
			return new YahooDataSearchEvent(type, searchString, bubbles, cancelable);
		}

	}
}