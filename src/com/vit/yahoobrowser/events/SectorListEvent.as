package com.vit.yahoobrowser.events
{
	import flash.events.Event;
	
	public class SectorListEvent extends Event
	{
		public static const ITEM_SELECT:String = "sector_list_item_select";
		
		public function SectorListEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}