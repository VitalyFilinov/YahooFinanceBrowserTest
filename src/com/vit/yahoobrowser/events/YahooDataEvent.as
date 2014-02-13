package com.vit.yahoobrowser.events
{
	import flash.events.Event;
	
	public class YahooDataEvent extends Event
	{
		public static const SECTORS_CHANGED:String = "data_sectors_changed";
		public static const CURRENT_SECTOR_CHANGED:String = "data_current_sector_changed";
		public static const CURRENT_INDUSTRY_CHANGED:String = "data_current_industry_changed";
		public static const CURRENT_COMPANY_CHANGED:String = "data_current_company_changed";
		public static const SECTOR_SELECTED:String = "list_sector_selected";
		public static const INDUSTRY_SELECTED:String = "list_industry_selected";
		
		public static const INDUSTRY_CHECKED:String = "list_industry_checked";
		public static const INDUSTRY_UNCHECKED:String = "list_industry_unchecked";
		
		public function YahooDataEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}