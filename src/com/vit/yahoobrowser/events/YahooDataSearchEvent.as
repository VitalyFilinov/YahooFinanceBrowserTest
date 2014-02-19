package com.vit.yahoobrowser.events
{
	import flash.events.Event;
	
	public class YahooDataSearchEvent extends Event
	{
		/**
		 * Dispatches when user insert new search string
		 */
		public static const SEARCH:String = "data_search";
		
		/**
		 * The string to be used to process search.
		 */
		private var _searchString:String;
		
		/**
		 * Events related to the industries search.
		 * @param type:String - event.type.
		 * @param searchString:String - the string to be used to process search.
		 * @param bubbles:Boolean
		 * @param cancelable:Boolean
		 */
		public function YahooDataSearchEvent(type:String, searchString:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_searchString = searchString;
		}

		/**
		 * Returns the string to be used to process search.
		 */
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