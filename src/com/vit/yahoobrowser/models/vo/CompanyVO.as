package com.vit.yahoobrowser.models.vo
{

	public class CompanyVO implements ICompanyVO
	{
		private var _symbol:String;
		private var _name:String;
		private var _isCurrent:Boolean;
		
		public function CompanyVO(symbol:String, name:String)
		{
			_symbol = symbol;
			_name = name;
		}
		
		public function get symbol():String
		{
			return _symbol;
		}
		
		public function get name():String
		{
			return _name;
		}
		
		public function get isCurrent():Boolean
		{
			return _isCurrent;
		}
		
		public function set isCurrent(value:Boolean):void
		{
			_isCurrent = value;
		}
	}
}