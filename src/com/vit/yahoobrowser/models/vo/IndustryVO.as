package com.vit.yahoobrowser.models.vo
{
	import mx.collections.ArrayList;

	public class IndustryVO implements IIndustryVO
	{
		/**
		 * The id of the industry.
		 */
		private var _id:int;
		/**
		 * The name of the industry.
		 */
		private var _name:String;
		/**
		 * The children list of the industry.
		 */
		private var _children:ArrayList; 
		/**
		 * Whether the industry is stored in user favorites list or not.
		 */
		private var _isFavorite:Boolean;
		/**
		 * Whether industry's children are presented in industries list.
		 */
		private var _isOpened:Boolean;
		/**
		 * Whether the industry is current used industry or not.
		 */
		private var _isCurrent:Boolean;
		
		/**
		 * IndustryVO is value object used to store the industry data.
		 * If the industry has children, it could be opened in the industries list view.
		 * In our case if the industry has children, it is used as the industry sector.
		 * @param id:int				- the id of the industry.
		 * @param name:String			- the name of the industry.
		 * @param children:ArrayList	- the children list of the industry.							
		 */
		public function IndustryVO(id:int, name:String, children:ArrayList = null)
		{
			_id = id;
			_name = name;
			_children = children;
		}
		
		/**
		 * Returns the id of the industry.
		 */
		public function get id():int
		{
			return _id;
		}
		
		/**
		 * Returns the name of the industry.
		 */
		public function get name():String
		{
			return _name;
		}
		
		/**
		 * Returns the children list of the industry.
		 * If industry has children, it could be opened in industries list view.
		 * In our case if the industry has children, it is used as industry sector.
		 */
		public function get children():ArrayList
		{
			return _children;
		}
		
		/**
		 * Returns whether the industry is stored in user favorites list or not.
		 */
		public function get isFavorite():Boolean
		{
			return _isFavorite;
		}
		
		/**
		 * Sets the industry is stored in user favorites list or not.
		 * @param value:Boolean
		 */
		public function set isFavorite(value:Boolean):void
		{
			_isFavorite = value;
		}
		
		/**
		 * Returns whether industry's children are presented in industries list
		 * starting from the position next to the industry position.
		 */
		public function get isOpened():Boolean
		{
			return _isOpened;
		}
		
		/**
		 * Sets whether industry's children are presented in industries list
		 * starting from the position next to the industry's position.
		 * @param value:Boolean
		 */
		public function set isOpened(value:Boolean):void
		{
			_isOpened = value;
		}
		
		/**
		 * Returns whether the industry is current used industry or not.
		 */
		public function get isCurrent():Boolean
		{
			return _isCurrent;
		}
		
		/**
		 * Sets whether the industry is current used industry or not.
		 * @param value:Boolean
		 */
		public function set isCurrent(value:Boolean):void
		{
			_isCurrent = value;
		}
		
		/**
		 * Returns the clone of the industry value object.
		 * @param emptyChildren:Boolean - include the children list or stay it empty.
		 */
		public function clone(emptyChildren:Boolean = false):IIndustryVO
		{
			return new IndustryVO(_id, _name, emptyChildren? new ArrayList():_children);
		}
	}
}