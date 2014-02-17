package com.vit.yahoobrowser.events
{
	import com.vit.yahoobrowser.models.vo.ICompanyVO;
	
	import flash.events.Event;
	
	public class YahooCompanyEvent extends Event
	{
		public static const COMPANIES_CHANGED:String = "data_companies_changed";
		public static const COMPANY_SELECTED:String = "list_company_selected";
		public static const COMPANY_CHANGED:String = "list_company_changed";
		
		private var _vo:ICompanyVO;
		
		public function YahooCompanyEvent(type:String, vo:ICompanyVO = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_vo = vo;
		}
		
		public function get vo():ICompanyVO
		{
			return _vo;
		}
		
		override public function clone():Event
		{
			return new YahooCompanyEvent(type, vo, bubbles, cancelable);
		}
	}
}