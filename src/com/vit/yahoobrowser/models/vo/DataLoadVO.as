package com.vit.yahoobrowser.models.vo
{
	public class DataLoadVO implements IDataLoadVO
	{
		private var _hashID:String;
		
		public function set hashID(value:String):void
		{
			_hashID = value;
		}
		
		public function get hashID():String
		{
			return _hashID;
		}
	}
}