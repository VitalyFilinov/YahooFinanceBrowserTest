package com.vit.yahoobrowser.models.vo
{
	import com.vit.yahoobrowser.models.YahooDataTypes;

	public class CompanyVO implements ICompanyVO
	{
		private var _selected:Boolean;
		
		public function CompanyVO()
		{
			
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
			return YahooDataTypes.COMPANY;
		}
	}
}