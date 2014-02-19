package com.vit.yahoobrowser.resources
{
	public class Resources
	{
		/**
		 * Plus symbol at the left of the industry sector item in the industries list.
		 * Shows that the industry sector is closed. 
		 */
		[Embed (source="../../../../../libs/plus.png" )]
		public static const PLUS:Class;
		
		/**
		 * Minus symbol at the left of the industry sector item in the industries list.
		 * Shows that the industry sector is opened. 
		 */
		[Embed (source="../../../../../libs/minus.png" )]
		public static const MINUS:Class;
		
		/**
		 * Checkbox checked symbol at the right of the industry item in the industries list.
		 * Shows that the industry is selected to be inserted to the favorites list.
		 */
		[Embed (source="../../../../../libs/checkbox_yes.png" )]
		public static const CHECKBOX_YES:Class;
		
		/**
		 * Checkbox unchecked symbol at the right of the industry item in the industries list.
		 * Shows that the industry is NOT selected to be inserted to the favorites list. 
		 */
		[Embed (source="../../../../../libs/checkbox_no.png" )]
		public static const CHECKBOX_NO:Class;
		
		/**
		 * Delete symbol at the right of the favorite industry item in the favorites list.
		 * Used as a button to delete the favorite item. 
		 */
		[Embed (source="../../../../../libs/delete.png" )]
		public static const DELETE:Class;
		
		/**
		 * Triangle bottom oriented icon for the open industries list button on the IndustryManagerView.
		 * Shows that list is closed.
		 */
		[Embed (source="../../../../../libs/btn_open.png" )]
		public static const OPEN:Class;
		
		/**
		 * Triangle top oriented icon for the open industries list button on the IndustryManagerView.
		 * Shows that list is opened.
		 */
		[Embed (source="../../../../../libs/btn_close.png" )]
		public static const CLOSE:Class;
	}
}