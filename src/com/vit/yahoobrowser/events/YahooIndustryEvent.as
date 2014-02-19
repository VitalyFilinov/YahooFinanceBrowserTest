package com.vit.yahoobrowser.events
{
	import com.vit.yahoobrowser.models.vo.IIndustryVO;
	
	import flash.events.Event;
	
	public class YahooIndustryEvent extends Event
	{
		/**
		 * Dispatches when industries data changed.
		 */
		public static const INDUSTRIES_CHANGED:String = "data_industries_changed";
		/**
		 * Dispatches when current industry changed
		 */
		public static const CURRENT_INDUSTRY_CHANGED:String = "data_current_industry_changed";
		/**
		 * Dispatches when industry data loading error detected.
		 */
		public static const CURRENT_INDUSTRY_ERROR:String = "data_current_industry_error";
		/**
		 * Dispatches to open the industry sector.
		 */
		public static const SECTOR_OPEN:String = "data_sector_open";
		/**
		 * Dispatches to close the industry sector.
		 */
		public static const SECTOR_CLOSE:String = "data_sector_close";
		/**
		 * Dispatches when the industry is selected.
		 */
		public static const INDUSTRY_SELECTED:String = "list_industry_selected";
		
		/**
		 * The industry value object.
		 */
		private var _vo:IIndustryVO;
		
		/**
		 * Events related to the industries.
		 * @param type:String - the event type.
		 * @param vo:IIndustryVO - the industry value object.
		 * @param bubbles:Boolean
		 * @param cancelable:Boolean
		 */
		public function YahooIndustryEvent(type:String, vo:IIndustryVO = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_vo = vo;
		}
		
		/**
		 * Returns the industry value object.
		 */
		public function get vo():IIndustryVO
		{
			return _vo;
		}
		
		override public function clone():Event
		{
			return new YahooIndustryEvent(type, vo, bubbles, cancelable);
		}
	}
}