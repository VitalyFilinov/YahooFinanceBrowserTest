package com.vit.yahoobrowser.models.vo
{
	import com.vit.yahoobrowser.models.YahooDataTypes;

	public class SectorVO implements ISectorVO
	{
		private var _id:int; 
		private var _name:String; 
		private var _industries:Array; 
		private var _isOpened:Boolean;
		
		public function SectorVO(id:int, name:String, industries:Array)
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
		
		public function get industries():Array
		{
			return _industries;
		}
		
		public function get isOpened():Boolean
		{
			return _isOpened;
		}
		
		public function set isOpened(value:Boolean):void
		{
			_isOpened = value;
		}
		
		public function get type():String
		{
			return YahooDataTypes.SECTOR;
		}
	}
}