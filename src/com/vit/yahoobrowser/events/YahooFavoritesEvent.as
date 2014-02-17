package com.vit.yahoobrowser.events
{
	import com.vit.yahoobrowser.models.vo.IIndustryVO;
	
	import flash.events.Event;
	
	public class YahooFavoritesEvent extends Event
	{
		public static const ADD:String = "favorites_add";
		public static const REMOVE:String = "favorites_remove";
		public static const COMPLETE_REMOVE:String = "favorites_complete_remove";
		public static const SAVE:String = "favorites_save";
		public static const RESET:String = "favorites_reset";
		public static const CHANGED:String = "favorites_changed";
		
		private var _item:IIndustryVO;
		
		public function YahooFavoritesEvent(type:String, item:IIndustryVO = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_item = item;
		}
		
		public function get item():IIndustryVO
		{
			return _item;
		}
		
		override public function clone():Event
		{
			return new YahooFavoritesEvent(type, item, bubbles, cancelable);
		}
	}
}