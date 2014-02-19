/**
* IYahooDataModel is a Model interface of the project robotlegs structure.
* IYahooDataModel stores the industries and the companies data loaded from the data provider database.
*/
package com.vit.yahoobrowser.models
{
	import com.vit.yahoobrowser.models.vo.ICompanyVO;
	import com.vit.yahoobrowser.models.vo.IIndustryVO;
	import mx.collections.ArrayList;

	public interface IYahooDataModel
	{
			/**
		 * Receives the industries.
		 * @param data:Object - the data to be saved.
		 */
		function setIndustries(data:Object):void;
		/**
		 * Returns the industries.
		 */
		function getIndustries():ArrayList;
		/**
		 * Receives the companies.
		 * @param data:Object - data to be saved.
		 */
		function setCompanies(data:Object):void;
		/**
		 * Returns the companies.
		 */
		function getCompanies():ArrayList;
		/**
		 * Sets current industry.
		 */
		function setCurrentIndustry(industry:IIndustryVO):void;
		/**
		 * Sets current company.
		 * @param data:ICompanyVO - the company to be selected as current.
		 */
		function setCurrentCompany(company:ICompanyVO):void;
		/**
		 * Returns current selected company.
		 */
		function getCurrentCompany():ICompanyVO;
		/**
		 * Searches a company by the symbol through the companies list and sets it as currentCompany if found.
		 * @param symbol:String - the string to be used to search a company by the symbol name.
		 */
		function setCurrentCompanyBySymbol(symbol:String):void;
		/**
		 * Adds industry children list to the industries list at the position next to the industry position.
		 * @param source:ArrayList - the list to be added to the industries list.
		 * @param index:int - the item index in the industries list.
		 */
		function openItem(source:ArrayList, index:int):void;
		/**
		 * Removes industry children from industries list from the position next to the industry position.
		 * @param source:ArrayList - the list to be removed from the industries list.
		 * @param index:int - the item index in the industries list.
		 */
		function closeItem(source:ArrayList, index:int):void;
		/**
		 * Searchs by string in industries names.
		 * @param symbol:String - the string to be used to search a industry by the name.
		 */
		function getSearch(searchString:String):ArrayList;
		/**
		 * Clears the search list and the searchString.
		 */
		function clearSearch():void;
		/**
		* Adds industry to favorites.
		* @param item:IIndustryVO - industry to be added to the favorites list.
		*/
		function addFavorite(item:IIndustryVO):void;
		/**
		* Removes industry from favorites.
		* @param item:IIndustryVO - industry to be removed from the favorites list.
		* @param complete:Boolean - removes from previosly saved favorites list.
		*/
		function removeFavorite(item:IIndustryVO, complete:Boolean = false):void;
		/**
		* Saves the favorite's changes
		*/
		function saveFavorites():void;
		/**
		* Resets the favorites to previously saved state.
		*/
		function resetFavorites():void;
		/**
		* Returns the favorites
		*/
		function getFavorites():ArrayList;
	}
}