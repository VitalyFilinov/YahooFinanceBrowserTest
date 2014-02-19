/**
* YahooDataModel is created and used as a Model of the project robotlegs structure.
* YahooDataModel stores industries and companies data loaded from YQL database.
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
		 * List of all industries loaded
		 */
		private var industries:ArrayList;
		/**
		 * List of companies represnting current industry
		 */
		private var companies:ArrayList;
		/**
		 * List of favorite companies
		 */
		private var favorites:ArrayList = new ArrayList();
		/**
		 * Temporary list of favorite companies to make cancel action possible
		 */
		private var tmpFavorites:ArrayList;
		/**
		 * List of current founded companies
		 */
		private var currentSearch:ArrayList;
		/**
		 * Current search string
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
		 * @param data:Object. Usually data from DataLoadStrategy.
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
		 * @param data:Object. Usually data from DataLoadStrategy.
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
		 * Otherwise sets isCurrent property of current industry to false, sets isCurrent property of new industry to true
		 * and clears companies list.
		 * @param industry - IIndustryVO.
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
		 * @param company - ICompanyVO.
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
		 * Returns current selected company
		 */
		public function getCurrentCompany():ICompanyVO
		{
			return currentCompany;
		}
		
		/**
		 * Searches company by symbol through companies list.
		 * If company was found, sets it as currentCompany.
		 * Otherwise set currentCompanys isCurrent property to false.
		 * @param _symbol - company symbol. ICompanyVO.symbol.
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
		 * Adds industry children list to industries list at position next to industry position.
		 * @param source - children list. IIndustryVO.children
		 * @param index - current industry position in industries list 
		 */
		public function openItem(source:ArrayList, index:int):void
		{
			var _sector:IIndustryVO = source.getItemAt(index) as IIndustryVO;
			_sector.isOpened = true;
			source.addAllAt(_sector.children, index + 1);
		}
		
		/**
		 * Removes industry children from industries list from the position next to industry position.
		 * @param source - children list. IIndustryVO.children
		 * @param index - current industry position in industries list 
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
		 * Searchs by string in industries names.
		 * Uses only industries without children, because industries with children is a sectors;
		 * If current search already presented, it will be cleared before.
		 * If currentSearch is empty or industry not created yet, returns empty result;
		 *  
		 * Loops through children of industries.
		 * If industry found, clone of parent industry will be created.
		 * Property isOpened in founded items will be differ from default IIndustryVO.
		 * Sets all items isOpened = true, to open all sectors in founded list
		 * @param searchString
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
		 * Clears search list and searchString
		 */
		public function clearSearch():void
		{
			currentSearchString = "";
			currentSearch.removeAll();
			currentSearch = null;
		}
		
		/**
		 * Creates temporary favorites list (if not created yet) and
		 * adds favorite item to temporary favorites list.
		 * If user will cancel all items in temporary list will be cleared
		 * Otherwise was copied to main favorites list.
		 * @param item IIndustryVO
		 */
		public function addFavorite(item:IIndustryVO):void
		{
			tmpFavorites ||= new ArrayList(favorites? favorites.source.slice(0):null);
			tmpFavorites.addItem(item);
			
			item.isFavorite = true;
			industries.itemUpdated(item);
		}
		
		/**
		 * Removes item from temporary favorites list.
		 * If complete == true, removes item from main favorites list.
		 * (User can remove item from favorites from main favorites list - not simply uncheck)
		 * @param item IIndustryVO
		 * @param complete - completely removes item from favorites
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
		 * Saves temporary favorites list to main favorites list and clear temporary favorites list.
		 * All items in old favorites list sets isFavorite = false first.
		 * All items in temporary favorites list sets isFavorite = true.
		 * Sorts sourse of new favorites ArrayList by name
		 */
		public function saveFavorites():void
		{
			if(tmpFavorites == null) return; // favorites was not been changed
			
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
		 * Removes temporary favorites list.
		 * All items in temporary favorites list sets isFavorite = false first.
		 * All items in favorites list sets isFavorite = true.
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
		 * Returns favorites list
		 */
		public function getFavorites():ArrayList
		{
			return favorites;
		}
	}
}