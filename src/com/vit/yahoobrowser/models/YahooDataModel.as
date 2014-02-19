/**
* YahooDataModel is created and used as a Model of the project robotlegs structure.
* YahooDataModel stores industries and companies data loaded from the data provider database.
* There are four types of data stored:
* - industries
* - companies
* - favorites
* - search
* All data stored as ArrayList to be compatible with DataGroup dataProvider (implemented IList)
* The model also provide adding and removing components from/to industries list
* to make industries list view openable (openItem, closeItem)described
* The model makes search by name field through industries using user defined string (getSearch)
* The model creates temporary favorites list (tmpFavorites) until user confirm or cancel select
* favorites process. When select favorites process finished, tmpFavorites are copied to main favorites
* list or cleared depending on user choice.
*/
package com.vit.yahoobrowser.models
{
	import com.vit.yahoobrowser.events.YahooCompanyEvent;
	import com.vit.yahoobrowser.events.YahooFavoritesEvent;
	import com.vit.yahoobrowser.events.YahooIndustryEvent;
	import com.vit.yahoobrowser.models.vo.ICompanyVO;
	import com.vit.yahoobrowser.models.vo.IIndustryVO;
	
	import flash.events.IEventDispatcher;
	
	import mx.collections.ArrayList;

	public class YahooDataModel implements IYahooDataModel
	{
		[Inject]
		public var eventDispatcher:IEventDispatcher;
		
		/**
		 * The list of all industries loaded.
		 */
		private var industries:ArrayList;
		/**
		 * The list of the companies according to current industry.
		 */
		private var companies:ArrayList;
		/**
		 * The list of the favorite companies.
		 */
		private var favorites:ArrayList = new ArrayList();
		/**
		 * The temporary list of the favorite companies to make cancel action possible.
		 */
		private var tmpFavorites:ArrayList;
		/**
		 * The list of current founded companies.
		 */
		private var currentSearch:ArrayList;
		/**
		 * Current search string.
		 */
		private var currentSearchString:String;
		/**
		 * Current selected industry sector
		 */
		private var currentSector:IIndustryVO;
		/**
		 * Current selected industry
		 */
		private var currentIndustry:IIndustryVO;
		/**
		 * Current selected company
		 */
		private var currentCompany:ICompanyVO;
		
		/**
		 * Receives the industries data, saves it and dispatches event;
		 * @param data:Object - the data to be saved as industries data. Usually data from DataLoadStrategy.
		 */
		public function setIndustries(data:Object):void
		{
			industries = data as ArrayList;
			eventDispatcher.dispatchEvent(new YahooIndustryEvent(YahooIndustryEvent.INDUSTRIES_CHANGED));
		}
		
		/**
		 * Returns industries list.
		 * If currentSearchString is presented, returns search result.
		 * If user started search procedure before data was loaded, search string will be saved and
		 * search result will be returned next time industries data requested.
		 * If users stoped searching currentSearchString will be cleared by clearSearchMethod.
		 */
		public function getIndustries():ArrayList
		{
			if(currentSearchString && currentSearchString.length > 0)
			{
				return getSearch(currentSearchString);
			}
			return industries;
		}
		
		/**
		 * Receives the companies data according to current industry selected, saves data and dispatches event.
		 * If data received with error, current industry will be unmarked as current to give user opportunities to
		 * repeat action.
		 * @param data:Object - the data to be saved as companies data. Usually data from DataLoadStrategy.
		 */
		public function setCompanies(data:Object):void
		{
			companies = data.data as ArrayList;
			
			if(data.error && currentIndustry)
			{
				currentIndustry.isCurrent = false;
				industries.itemUpdated(currentIndustry);
				favorites.itemUpdated(currentIndustry);
			}
			
			eventDispatcher.dispatchEvent(new YahooCompanyEvent(YahooCompanyEvent.COMPANIES_CHANGED, null, data.error));
		}
		
		/**
		 * Returns current companies list.
		 */
		public function getCompanies():ArrayList
		{
			return companies;
		}
		
		/**
		 * Sets current industry.
		 * If currentIndustry is the same, does nothing.
		 * Otherwise sets isCurrent property of current industry to false, sets isCurrent property of the new industry to true
		 * and clears the companies list.
		 * @param industry:IIndustryVO - the value object to be saved as current industry.
		 */
		public function setCurrentIndustry(industry:IIndustryVO):void
		{
			if(currentIndustry == industry)
			{
				return;
			}
			
			if(currentIndustry)
			{
				currentIndustry.isCurrent = false;
				favorites.itemUpdated(currentIndustry);
			}
			
			currentIndustry = industry;
			currentIndustry.isCurrent = true;
			favorites.itemUpdated(currentIndustry);
			
			if(companies)
			{
				companies.removeAll();
			}
		}
		
		/**
		 * Sets current company.
		 * If currentCompany is the same, does nothing.
		 * Otherwise sets isCurrent property of current company to false, sets isCurrent property of new company to true
		 * and dispatches event.
		 * @param company:ICompanyVO - the value object to be saved as current company.
		 */
		public function setCurrentCompany(company:ICompanyVO):void
		{
			if(currentCompany == company)
			{
				return;
			}
			
			if(currentCompany)
			{
				currentCompany.isCurrent = false;
				companies.itemUpdated(currentCompany);
			}
			
			currentCompany = company;
			currentCompany.isCurrent = true;
			companies.itemUpdated(currentCompany);
			
			eventDispatcher.dispatchEvent(new YahooCompanyEvent(YahooCompanyEvent.COMPANY_CHANGED, currentCompany));
		}
		
		/**
		 * Returns current selected company value object.
		 */
		public function getCurrentCompany():ICompanyVO
		{
			return currentCompany;
		}
		
		/**
		 * Searches company by symbol through companies list.
		 * If the company was found, sets it as currentCompany.
		 * Otherwise set the currentCompany's isCurrent property to false.
		 * @param _symbol:String - the company symbol name.
		 */
		public function setCurrentCompanyBySymbol(_symbol:String):void
		{
			if(!companies || !currentCompany || currentCompany.symbol == _symbol)
			{
				return;
			}
			
			var a:int = companies.length;
			var company:ICompanyVO;
			while(a--)
			{
				company = companies.getItemAt(a) as ICompanyVO;
				
				if(company.symbol == _symbol)
				{
					setCurrentCompany(company);
					return;
				}
			}
			
			currentCompany.isCurrent = false;
			companies.itemUpdated(currentCompany);
			currentCompany = null;
		}
		
		/**
		 * Adds the industry children list to the industries list at the position next to the industry position.
		 * @param source:ArrayList - the children list.
		 * @param index:int - current industry position in the industries list.
		 */
		public function openItem(source:ArrayList, index:int):void
		{
			var _sector:IIndustryVO = source.getItemAt(index) as IIndustryVO;
			_sector.isOpened = true;
			source.addAllAt(_sector.children, index + 1);
		}
		
		/**
		 * Removes the industry children from the industries list from the position next to the industry position.
		 * @param source - the children list.
		 * @param index - current industry position in the industries list.
		 */
		public function closeItem(source:ArrayList, index:int):void
		{
			var _sector:IIndustryVO = source.getItemAt(index) as IIndustryVO;
			_sector.isOpened = false;
			
			var i:int = _sector.children.length;
			
			while(i--)
			{
				source.removeItemAt(index + 1);
			}
		}
		
		/**
		 * Searchs by the string in the industries names.
		 * Uses only industries without children, because industries with the children
		 * is a sectors in our case.
		 * If currentSearch is already presented, it will be cleared before.
		 * If currentSearch is empty or industry not created yet, returns empty result;
		 *  
		 * Loops through the children of industries.
		 * If industry found, the clone of parent industry will be created.
		 * The property isOpened of founded items will be differ from default IIndustryVO.
		 * Sets all items isOpened property to true, to open all sectors in founded list.
		 * @param searchString:String - the string used to process search.
		 */
		public function getSearch(searchString:String):ArrayList
		{
			if(currentSearch)
			{
				if(currentSearch.length > 0)
				{
					currentSearch.removeAll();
				}
			}
			else
			{
				currentSearch = new ArrayList();
			}
			
			currentSearchString = searchString;
			
			if(searchString.length == 0 || !industries)
			{
				return currentSearch;
			}
			
			var aLen:int = industries.length;
			var bLen:int;
			var _sector:IIndustryVO;
			var tmpSector:IIndustryVO;
			var tmpIndustry:IIndustryVO;
			for(var a:int = 0; a<aLen; a++)
			{
				_sector = industries.getItemAt(a) as IIndustryVO;
				
				if(!_sector.children) continue;
				
				bLen = _sector.children.length;
				for(var b:int = 0; b<bLen; b++)
				{
					tmpIndustry = _sector.children.getItemAt(b) as IIndustryVO;
					if(tmpIndustry.name.toLowerCase().indexOf(searchString.toLowerCase()) > -1)
					{
						tmpSector ||= _sector.clone(true);
						tmpSector.children.addItem(tmpIndustry);
					}
					tmpIndustry = null;
				}
				
				if(tmpSector != null)
				{
					currentSearch.addItem(tmpSector);
					openItem(currentSearch, currentSearch.length - 1);
				}
				tmpSector = null;
			}
			
			return currentSearch;
		}
		
		/**
		 * Clears the search list and the searchString
		 */
		public function clearSearch():void
		{
			currentSearchString = "";
			currentSearch.removeAll();
			currentSearch = null;
		}
		
		/**
		 * Creates the temporary favorites list (if not created yet) and
		 * adds the favorite item to the temporary favorites list.
		 * If the user will cancel, all items in the temporary list will be cleared.
		 * Otherwise was copied to main favorites list.
		 * @param item:IIndustryVO - the value object to be stored in favorites list.
		 */
		public function addFavorite(item:IIndustryVO):void
		{
			tmpFavorites ||= new ArrayList(favorites? favorites.source.slice(0):null);
			tmpFavorites.addItem(item);
			
			item.isFavorite = true;
			industries.itemUpdated(item);
		}
		
		/**
		 * Removes the item from the temporary favorites list.
		 * If complete parameter is true, removes item from main favorites list.
		 * (The user can remove the item from the main favorites list - not simply uncheck)
		 * @param item:IIndustryVO - item to be removed from favorites list.
		 * @param completeBoolean - if true, completely remove the item from the favorites.
		 */
		public function removeFavorite(item:IIndustryVO, complete:Boolean = false):void
		{
			if(complete)
			{
				favorites.removeItem(item);
			}
			else
			{
				tmpFavorites ||= new ArrayList(favorites.source.slice(0));
				tmpFavorites.removeItem(item);
			}
			
			item.isFavorite = false;
			industries.itemUpdated(item);
		}
		
		/**
		 * Saves the temporary favorites list to the main favorites list and clear the temporary favorites list.
		 * Sets isFavorite parameter to false in all items in old favorites list first.
		 * Sets isFavorite parameter to true in all items in the temporary favorites list.
		 * Sorts the sourse of new favorites ArrayList by name.
		 */
		public function saveFavorites():void
		{
			if(tmpFavorites == null) return; // the favorites was not been changed
			
			favorites ||= new ArrayList();
			
			var i:int = favorites.length;
			var item:IIndustryVO;
			while(i--)
			{
				item = favorites.getItemAt(i) as IIndustryVO;
				item.isFavorite = false;
				favorites.itemUpdated(item);
				industries.itemUpdated(item);
			}
			
			i = tmpFavorites.length;
			while(i--)
			{
				item = tmpFavorites.getItemAt(i) as IIndustryVO;
				item.isFavorite = true;
				industries.itemUpdated(item);
			}
			
			favorites = tmpFavorites;
			favorites.source.sortOn("name");

			tmpFavorites = null;
			eventDispatcher.dispatchEvent(new YahooFavoritesEvent(YahooFavoritesEvent.CHANGED));
		}
		
		/**
		 * Removes the temporary favorites list.
		 * Sets isFavorite parameter to false in all items in temporary favorites list first.
		 * Sets isFavorite parameter to true in all items in the favorites list.
		 */
		public function resetFavorites():void
		{
			if(tmpFavorites == null) return; // favorites was not been changed
			
			var i:int = tmpFavorites.length;
			var item:IIndustryVO;
			while(i--)
			{
				item = tmpFavorites.getItemAt(i) as IIndustryVO;
				item.isFavorite = false;
				industries.itemUpdated(item);
			}
			
			i = favorites.length;
			while(i--)
			{
				item = favorites.getItemAt(i) as IIndustryVO;
				item.isFavorite = true;
				favorites.itemUpdated(item);
				industries.itemUpdated(item);
			}
			
			tmpFavorites.removeAll();
			tmpFavorites = null;
		}
		
		/**
		 * Returns the favorites list.
		 */
		public function getFavorites():ArrayList
		{
			return favorites;
		}
	}
}