package com.vit.yahoobrowser.models.vo
{
	import com.vit.yahoobrowser.models.YahooDataTypes;

	public class IndustryVO implements IIndustryVO
	{
		private var _id:int;
		private var _name:String;
		private var _selected:Boolean;
		private var _isFavorite:Boolean;
		
		public function IndustryVO(id:int, name:String)
		{
			_id = id;
			_name = name;
		}
		
		public function get id():int
		{
			return _id;
		}
		
		public function get selected():Boolean
		{
			return _selected;
		}
		
		public function set selected(value:Boolean):void
		{
			_selected = value;
		}
		
		public function get isFavorite():Boolean
		{
			return _selected;
		}
		
		public function set isFavorite(value:Boolean):void
		{
			_selected = value;
		}
		
		public function get name():String
		{
			return _name;
		}
		
		public function get type():String
		{
			return YahooDataTypes.INDUSTRY;
		}
	}
}