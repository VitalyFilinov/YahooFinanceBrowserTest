package com.vit.yahoobrowser.events
{
	import flash.events.Event;
	
	public class YahooFavoritesEvent extends Event
	{
		public static const ADD:String = "favorites_add";
		public static const REMOVE:String = "favorites_remove";
		
		private var _items:Array;
		
		public function YahooFavoritesEvent(type:String, items:Array, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_items = items;
		}
		
		public function get items():Array
		{
			return _items;
		}
		
		override public function clone():Event
		{
			return new YahooFavoritesEvent(type, items, bubbles, cancelable);
		}
	}
}