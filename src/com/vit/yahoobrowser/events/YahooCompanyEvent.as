package com.vit.yahoobrowser.events
{
	import com.vit.yahoobrowser.models.vo.ICompanyVO;
	
	import flash.events.Event;
	
	public class YahooCompanyEvent extends Event
	{
		public static const COMPANIES_CHANGED:String = "data_companies_changed";
		public static const COMPANIES_ERROR:String = "data_companies_error";
		
		public static const COMPANY_SELECTED:String = "list_company_selected";
		public static const COMPANY_CHANGED:String = "list_company_changed";
		
		private var _vo:ICompanyVO;
		private var _error:Boolean;
		
		public function YahooCompanyEvent(type:String, vo:ICompanyVO = null, error:Boolean = false, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_vo = vo;
			_error = error;
		}
		
		public function get vo():ICompanyVO
		{
			return _vo;
		}
		
		public function get error():Boolean
		{
			return _error;
		}
		
		override public function clone():Event
		{
			return new YahooCompanyEvent(type, vo, error, cancelable);
		}
	}
}