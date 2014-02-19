package com.vit.yahoobrowser.models.vo
{

	public class CompanyVO implements ICompanyVO
	{
		/**
		 * The symbol name of the company.
		 */
		private var _symbol:String;
		/**
		 * The name of the company.
		 */
		private var _name:String;
		/**
		 * Whether the company is current used company or not.
		 */
		private var _isCurrent:Boolean;
		
		/**
		 * CompanyVO is value object used to store the company data.
		 * @param symbol:String - the symbol name of the company.
		 * @param name:String	- the name of the company.
		 */
		public function CompanyVO(symbol:String, name:String)
		{
			_symbol = symbol;
			_name = name;
		}
		
		/**
		 * Returns the symbol name of the company.
		 */
		public function get symbol():String
		{
			return _symbol;
		}
		
		/**
		 * Returns the name of the company.
		 */
		public function get name():String
		{
			return _name;
		}
		
		/**
		 * Returns whether the company is current used company or not.
		 */
		public function get isCurrent():Boolean
		{
			return _isCurrent;
		}
		
		/**
		 * Sets whether the company is current used company or not.
		 * @param value:Boolean
		 */
		public function set isCurrent(value:Boolean):void
		{
			_isCurrent = value;
		}
	}
}