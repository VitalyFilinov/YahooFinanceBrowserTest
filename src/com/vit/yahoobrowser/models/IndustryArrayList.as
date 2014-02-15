package com.vit.yahoobrowser.models
{
	import com.vit.yahoobrowser.models.vo.ISectorVO;
	
	import flash.events.Event;
	
	import mx.collections.ArrayList;
	
	public class IndustryArrayList extends ArrayList
	{
		private var sectors:Array;
		
		public function IndustryArrayList(source:Array=null)
		{
			sectors = source == null? []:source;
			super(source);
		}
		
		public function openSector(index:int):void
		{
			if(!(source[index] is ISectorVO)) return;
			
			ISectorVO(source[index]).isOpened = true;
			
			addAllAt(source[index].industries, index + 1);
		}
		
		protected function addOnFrame(event:Event):void
		{
			// TODO Auto-generated method stub
			
		}
		
		public function closeSector(index:int):void
		{
			if(!(source[index] is ISectorVO)) return;
			
			ISectorVO(source[index]).isOpened = false;
			
			var i:int = source[index].industries.length;
			
			while(i--)
			{
				removeItemAt(index + 1);
			}
		}
	}
}