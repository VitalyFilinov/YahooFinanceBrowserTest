/**
 * IIndustryVO is value object interface used to store the industry data.
 * If the industry has children, it could be opened in industries list view.
 * In our case if the industry has children, it is used as the industry sector.
 */
package com.vit.yahoobrowser.models.vo
{
	import mx.collections.ArrayList;

	public interface IIndustryVO
	{
		/**
		 * Returns the id of the industry.
		 */
		function get id():int;
		/**
		 * Returns the name of the industry.
		 */
		function get name():String;
		/**
		 * Returns the children list of the industry.
		 */
		function get children():ArrayList;
		/**
		 * Returns whether the industry is stored in user favorites list or not.
		 */
		function get isFavorite():Boolean;
		/**
		 * Sets the industry is stored in user favorites list or not.
		 * @param value:Boolean
		 */
		function set isFavorite(value:Boolean):void;
		/**
		 * Returns whether industry is opened.
		 */
		function get isOpened():Boolean;
		/**
		 * Sets whether industry is opened.
		 * @param value:Boolean
		 */
		function set isOpened(value:Boolean):void;
		/**
		 * Returns whether the industry is current used industry or not.
		 */
		function get isCurrent():Boolean;
		/**
		 * Sets whether the industry is current used industry or not.
		 * @param value:Boolean
		 */
		function set isCurrent(value:Boolean):void;
		/**
		 * Returns the clone of the industry value object.
		 * @param emptyChildren:Boolean - include the children list or stay it empty.
		 */
		function clone(emptyChildren:Boolean = false):IIndustryVO;
	}
}