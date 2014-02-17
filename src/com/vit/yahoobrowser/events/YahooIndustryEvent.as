package com.vit.yahoobrowser.events
{
	import com.vit.yahoobrowser.models.vo.IIndustryVO;
	
	import flash.events.Event;
	
	public class YahooIndustryEvent extends Event
	{
		public static const INDUSTRIES_CHANGED:String = "data_industries_changed";
		public static const CURRENT_INDUSTRY_CHANGED:String = "data_current_industry_changed";
		public static const INDUSTRY_SELECTED:String = "list_industry_selected";
		
		private var _vo:IIndustryVO;
		
		public function YahooIndustryEvent(type:String, vo:IIndustryVO = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_vo = vo;
		}
		
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