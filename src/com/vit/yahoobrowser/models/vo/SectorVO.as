package com.vit.yahoobrowser.models.vo
{
	import com.vit.yahoobrowser.models.ISectorsListItem;
	import com.vit.yahoobrowser.models.YahooDataTypes;

	public class SectorVO implements ISectorVO, ISectorsListItem
	{
		private var _id:int; 
		private var _name:String; 
		private var _industries:Vector.<IIndustryVO>; 
		private var _selected:Boolean;
		
		public function SectorVO(id:int, name:String, industries:Vector.<IIndustryVO>)
		{
			_id = id;
			_name = name;
			_industries = industries;
		}
		
		public function get id():int
		{
			return _id;
		}
		
		public function get name():String
		{
			return _name;
		}
		
		public function get industries():Vector.<IIndustryVO>
		{
			return _industries;
		}
		
		public function get selected():Boolean
		{
			return _selected;
		}
		
		public function set selected(value:Boolean):void
		{
			_selected = value;
		}
		
		public function get type():String
		{
			return YahooDataTypes.SECTOR;
		}
	}
}