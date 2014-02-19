/**
* IYahooDataModel is a Model interface of the project robotlegs structure.
* IYahooDataModel stores industries and companies data loaded from YQL database.
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
		 * @param data - data to be saved.
		 */
		function setIndustries(data:Object):void;
		/**
		 * Returns industries.
		 */
		function getIndustries():ArrayList;
		/**
		 * Receives the companies.
     * @param data - data to be saved.
		 */
		function setCompanies(data:Object):void;
		/**
		 * Returns companies.
		 */
		function getCompanies():ArrayList;
		/**
		 * Sets current industry.
		 */
		function setCurrentIndustry(industry:IIndustryVO):void;
		/**
		 * Sets current company.
		 * @param data - company to be selected as current.
		 */
		function setCurrentCompany(company:ICompanyVO):void;
		/**
		 * Returns current selected company.
		 */
		function getCurrentCompany():ICompanyVO;
			/**
		 * Searches company by symbol through companies list and sets it as currentCompany if found.
		 * @param symbol - string to be used to search a company by symbol name.
		 */
		function setCurrentCompanyBySymbol(symbol:String):void;
		/**
		 * Adds industry children list to industries list at position next to industry position.
		 * @param source - list to be added to industries.
		 * @param source - item index in industries list.
		 */
		function openItem(source:ArrayList, index:int):void;
		/**
		 * Removes industry children from industries list from the position next to industry position.
		 * @param source - list to be removed from industries.
		 * @param source - item index in industries list.
		 */
		function closeItem(source:ArrayList, index:int):void;
		/**
		 * Searchs by string in industries names.
		 * @param symbol - string to be used to search a industry by name.
		 */
		function getSearch(searchString:String):ArrayList;
		/**
		 * Clears search list and searchString.
		 */
		function clearSearch():void;
		/**
		* Adds industry to favorites.
		* @param item - industry to be added to favorites.
		*/
		function addFavorite(item:IIndustryVO):void;
		/**
		* Removes industry from favorites.
		* @param item - industry to be removed from favorites
		*/
		function removeFavorite(item:IIndustryVO, complete:Boolean = false):void;
		/**
		* Saves favorites changes
		*/
		function saveFavorites():void;
		/**
		* Resets favorites to previously saved state.
		*/
		function resetFavorites():void;
		/**
		* Returns favorites
		*/
		function getFavorites():ArrayList;
	}
}