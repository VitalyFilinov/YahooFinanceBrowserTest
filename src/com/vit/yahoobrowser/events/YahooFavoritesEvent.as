package com.vit.yahoobrowser.events
{
	import com.vit.yahoobrowser.models.vo.IIndustryVO;
	
	import flash.events.Event;
	
	public class YahooFavoritesEvent extends Event
	{
		/**
		 * Dispatches to add the industry to the favorites.
		 */
		public static const ADD:String = "favorites_add";
		/**
		 * Dispatches to remove the industry from the favorites.
		 */
		public static const REMOVE:String = "favorites_remove";
		/**
		 * Dispatches to completly remove the industry from the favorites. 
		 */
		public static const COMPLETE_REMOVE:String = "favorites_complete_remove";
		/**
		 * Dispatches to save the favorites. 
		 */
		public static const SAVE:String = "favorites_save";
		/**
		 * Dispatches to reset the favorites. 
		 */
		public static const RESET:String = "favorites_reset";
		/**
		 * Dispatches when the favorites are changed. 
		 */
		public static const CHANGED:String = "favorites_changed";
		
		/**
		 * Industry value object
		 */
		private var _item:IIndustryVO;
		
		/**
		 * Events related to the favorites.
		 * @param type:String - event.type.
		 * @param item:IIndustryVO - the industry value object.
		 */
		public function YahooFavoritesEvent(type:String, item:IIndustryVO = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_item = item;
		}
		
		/**
		 * Returns industry value object.
		 */
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