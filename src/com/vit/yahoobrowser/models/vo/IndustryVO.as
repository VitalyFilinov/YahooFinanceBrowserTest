package com.vit.yahoobrowser.models.vo
{
	import mx.collections.ArrayList;

	public class IndustryVO implements IIndustryVO
	{
		private var _id:int;
		private var _name:String;
		private var _children:ArrayList; 
		private var _isFavorite:Boolean;
		private var _isOpened:Boolean;
		private var _isCurrent:Boolean;
		
		public function IndustryVO(id:int, name:String, children:ArrayList = null)
		{
			_id = id;
			_name = name;
			_children = children;
		}
		
		public function get id():int
		{
			return _id;
		}
		
		public function get name():String
		{
			return _name;
		}
		
		public function get children():ArrayList
		{
			return _children;
		}
		
		public function get isFavorite():Boolean
		{
			return _isFavorite;
		}
		
		public function set isFavorite(value:Boolean):void
		{
			_isFavorite = value;
		}
		
		public function get isOpened():Boolean
		{
			return _isOpened;
		}
		
		public function set isOpened(value:Boolean):void
		{
			_isOpened = value;
		}
		
		public function get isCurrent():Boolean
		{
			return _isCurrent;
		}
		
		public function set isCurrent(value:Boolean):void
		{
			_isCurrent = value;
		}
		
		public function clone(emptySectors:Boolean = false):IIndustryVO
		{
			return new IndustryVO(_id, _name, emptySectors? new ArrayList():_children);
		}
	}
}