package com.vit.yahoobrowser.events
{
	import com.vit.yahoobrowser.models.vo.ICompanyVO;
	
	import flash.events.Event;
	
	public class YahooCompanyEvent extends Event
	{
		/**
		 * Dispatches when companies data was changed.
		 */
		public static const COMPANIES_CHANGED:String = "data_companies_changed";
		/**
		 * Dispatches when companies data loading error detected.
		 */
		public static const COMPANIES_ERROR:String = "data_companies_error";
		/**
		 * Dispatches when the user selected a company.
		 */
		public static const COMPANY_SELECTED:String = "list_company_selected";
		/**
		 * Dispatches when current selected company changed.
		 */
		public static const COMPANY_CHANGED:String = "list_company_changed";
		
		/**
		 * The company value object
		 */
		private var _vo:ICompanyVO;
		/**
		 * Whether error detected during companies loading process or not.
		 */
		private var _error:Boolean;
		
		/**
		 * Events related to the companies.
		 * @param type:String - event.type.
		 * @param vo:ICompanyVO - the company value object.
		 * @param error:Boolean - whether error detected during companies loading process or not.
		 * @param bubbles:Boolean
		 * @param cancelable:Boolean
		 */
		public function YahooCompanyEvent(type:String, vo:ICompanyVO = null, error:Boolean = false, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_vo = vo;
			_error = error;
		}
		
		/**
		 * Returns the company value object.
		 */
		public function get vo():ICompanyVO
		{
			return _vo;
		}
		
		/**
		 * Returns whether error detected during companies loading process or not.
		 */
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