package com.vit.yahoobrowser.models
{
	import com.vit.yahoobrowser.events.DataLoaderEvent;
	import com.vit.yahoobrowser.events.YahooCompanyEvent;
	import com.vit.yahoobrowser.events.YahooIndustryEvent;
	import com.vit.yahoobrowser.models.vo.ICompanyVO;
	import com.vit.yahoobrowser.models.vo.IIndustryVO;
	import com.vit.yahoobrowser.services.app.YahooDataService;
	import com.vit.yahoobrowser.services.strategies.app.YahooDataServiceStrategy;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import mx.collections.ArrayList;
	import mx.events.CollectionEvent;
	import mx.events.PropertyChangeEvent;
	
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.asserts.assertNull;
	import org.flexunit.asserts.assertTrue;
	import org.flexunit.async.Async;
	
	public class YahooDataModelTest
	{
		private static var subject:YahooDataModel;
		private static var serviss:YahooDataService;
		
		private static var industries:ArrayList;
		private static var sectors:ArrayList;
		
		[Before]
		public function setUp():void
		{
			
		}
		
		[After]
		public function tearDown():void
		{
			
		}
		
		[BeforeClass (async)]
		public static function setUpBeforeClass():void
		{
			trace("VF", new Date().toLocaleTimeString(), "YahooDataModelTest::setUpBeforeClass");
			
			subject = new YahooDataModel();
			subject.eventDispatcher = new EventDispatcher();
			
			serviss = new YahooDataService();
			serviss.eventDispatcher = subject.eventDispatcher;
			
			subject.eventDispatcher.addEventListener(DataLoaderEvent.EVENT_DATA_LOADED,
				Async.asyncHandler(YahooDataModelTest,
					function(event:DataLoaderEvent, passThrough:*):void
					{
						industries = event.loadedData as ArrayList;
						sectors = new ArrayList();
						var industryVO:IIndustryVO;
						var len:int = industries.length;
						for(var i:int = 0; i<len; i++)
						{
							industryVO = industries.getItemAt(i) as IIndustryVO;
							if(industryVO.children.length > 0)
							{
								sectors.addItem(industryVO);
							}
						}
					},
					60000, null,
					function(event:Event):void
					{
						trace("VF", "YahooDataModelTest::enclosing_method TIME_OUT");
						setUpBeforeClass();
					}
				), false, 0, true);
			
			serviss.load(new YahooDataServiceStrategy(YahooLoaderDataTypes.INDUSTRIES));
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
			trace("VF", new Date().toLocaleTimeString(), "YahooDataModelTest::tearDownAfterClass");
			
			subject.eventDispatcher = null;
			subject = null;
			
			serviss.eventDispatcher = null;
			serviss = null;
		}
		
		[Test (order = -1)]
		public function testSetIndustries():void
		{
			trace("VF", new Date().toLocaleTimeString(), "YahooDataModelTest::testSetIndustries");
			
			var count:int = 0;
			var _onSetIndustries:Function = function(event:YahooIndustryEvent):void
			{
				count++;				
			}
			
			subject.eventDispatcher = new EventDispatcher();
			subject.eventDispatcher.addEventListener(YahooIndustryEvent.INDUSTRIES_CHANGED, _onSetIndustries);
			subject.setIndustries(industries);
			subject.eventDispatcher.removeEventListener(YahooIndustryEvent.INDUSTRIES_CHANGED, _onSetIndustries);
			
			assertNotNull("YahooDataModelTest::testSetIndustries => YahooDataModel should have industries", subject.getIndustries());
			assertEquals("YahooDataModelTest::testSetIndustries => YahooIndustryEvent.INDUSTRIES_CHANGED should be dispatched", 1, count);
		}
		
		[Test]
		public function testGetIndustries():void
		{
			trace("VF", new Date().toLocaleTimeString(), "YahooDataModelTest::testGetIndustries");
			
			assertTrue("YahooDataModelTest::testGetIndustries => Industries should be an ArrayList", subject.getIndustries() is ArrayList);
			
			var industriesTest:ArrayList = subject.getIndustries();
			
			assertNotNull("YahooDataModelTest::testGetIndustries => YahooDataModel should have industries", industriesTest);
			
			var i:int = industriesTest.length;
			while(i--)
			{
				assertTrue("YahooDataModelTest::testGetIndustries => Companies should consist IIndustryVO only", industriesTest.getItemAt(i) is IIndustryVO); 
			}
		}
		
		[Test]
		public function testGetSearch():void
		{
			trace("VF", new Date().toLocaleTimeString(), "YahooDataModelTest::testGetSearch");
			
			var industryVO:IIndustryVO = getRandomIndustry(); 
			
			var searchResult:ArrayList = subject.getSearch(industryVO.name);
			assertNotNull("YahooDataModelTest::testGetSearch => Search result is null (positive search)", searchResult);
			assertTrue("YahooDataModelTest::testGetSearch => Search result should have at least one item => " + industryVO.name, searchResult.length > 0);
			
			searchResult = subject.getSearch("not found");
			assertNotNull("YahooDataModelTest::testGetSearch => Search result is null (negative search)", searchResult);
			assertTrue("YahooDataModelTest::testGetSearch => Search result should not have any items", searchResult.length == 0);
			subject.clearSearch();
		}
		
		[Test]
		public function testClearSearch():void
		{
			assertEquals("YahooDataModelTest::testClearSearch => Search was not cleared succesfully", null, subject.clearSearch());
		}
		
		[Test (order = 1)]
		public function testAddFavorite():void
		{
			trace("VF", new Date().toLocaleTimeString(), "YahooDataModelTest::testAddFavorite");
			
			var sectorVO:IIndustryVO = getRandomSector();
			assertNotNull("YahooDataModelTest::testAddFavorite => sectorVO is null", sectorVO);
			
			var industryVO:IIndustryVO = getRandomIndustry(sectorVO);
			assertNotNull("YahooDataModelTest::testAddFavorite => industryVO is null", industryVO);
			
			// If sector is not opened, there are no available items in industries list. industries.itemUpdated() will not work, CollectionEvent will not dispatch. 
			subject.openItem(subject.getIndustries(), subject.getIndustries().getItemIndex(sectorVO));
			
			var _event:PropertyChangeEvent;
			
			var _onPropertyChanged:Function = function(event:PropertyChangeEvent):void
			{
				_event = event;
			}
			
			subject.getIndustries().addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, _onPropertyChanged);
			
			// ADD FAVORITE
			if(industryVO.isFavorite == false && subject.getFavorites().getItemIndex(industryVO) == -1)
			{
				assertTrue("YahooDataModelTest::testAddFavorite => Item should be added to favorites", subject.addFavorite(industryVO));
				assertTrue("YahooDataModelTest::testAddFavorite => Item was not marked as favorite", industryVO.isFavorite);
				assertNotNull("YahooDataModelTest::testAddFavorite => CollectionEvent.COLLECTION_CHANGE should be dispatched", _event);
				assertEquals("YahooDataModelTest::testAddFavorite => Wrong vo changed on addFavorite", industryVO, _event.source);
			}
			
			// ADD FAVORITE AGAIN
			_event = null;
			assertFalse("YahooDataModelTest::testAddFavorite => Item should NOT be added to favorites repeatelly", subject.addFavorite(industryVO));
			assertNull("YahooDataModelTest::testAddFavorite (repeat) => CollectionEvent.COLLECTION_CHANGE should not be dispatched when item repatelly added to favorites", _event);
			assertTrue("YahooDataModelTest::testAddFavorite (repeat) => Item was not marked as favorite", industryVO.isFavorite);
			
			// ADD NULL AS FAVORITE
			_event = null;
			assertFalse("YahooDataModelTest::testAddFavorite => Null should NOT be added to favorites", subject.addFavorite(null));
			assertNull("YahooDataModelTest::testAddFavorite => CollectionEvent.COLLECTION_CHANGE should not be dispatched on addFavorite(null)", _event);
			
			subject.getIndustries().removeEventListener(CollectionEvent.COLLECTION_CHANGE, _onPropertyChanged);
			
			subject.closeItem(subject.getIndustries(), subject.getIndustries().getItemIndex(sectorVO));
			
			sectorVO = null;
			industryVO = null;
			_event = null;
		}
		
		[Test (order = 3)]
		public function testRemoveFavorite():void
		{
			trace("VF", new Date().toLocaleTimeString(), "YahooDataModelTest::testRemoveFavorite");
			
			var sectorVO:IIndustryVO = getRandomSector();
			assertNotNull("YahooDataModelTest::testAddFavorite => sectorVO is null", sectorVO);
			
			var industryVO:IIndustryVO = getRandomIndustry(sectorVO);
			assertNotNull("YahooDataModelTest::testAddFavorite => industryVO is null", industryVO);
			
			// If sector is not opened, there are no available items in industries list. industries.itemUpdated() will not work, CollectionEvent will not dispatch. 
			subject.openItem(subject.getIndustries(), subject.getIndustries().getItemIndex(sectorVO));
			
			// Add favorite to be removed
			subject.addFavorite(industryVO);
			
			var _event:PropertyChangeEvent;
			
			var _onPropertyChanged:Function = function(event:PropertyChangeEvent):void
			{
				_event = event;
			}
			
			subject.getIndustries().addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, _onPropertyChanged);
			
			// REMOVE FAVORITE
			assertTrue("YahooDataModelTest::testRemoveFavorite => Item should be removed from favorites", subject.removeFavorite(industryVO));
			
			assertNotNull("YahooDataModelTest::testRemoveFavorite => CollectionEvent.COLLECTION_CHANGE should be dispatched", _event);
			assertEquals("YahooDataModelTest::testRemoveFavorite => Wrong vo changed on removeFavorite", industryVO, _event.source);
			
			// REMOVE FAVORITE AGAIN
			_event = null;
			assertFalse("YahooDataModelTest::testRemoveFavorite => Item could not be removed from favorites", subject.removeFavorite(industryVO));
			assertNull("YahooDataModelTest::testRemoveFavorite => CollectionEvent.COLLECTION_CHANGE should not be dispatched on removeFavorite", _event);
			
			// Add favorite to be removed
			subject.addFavorite(industryVO);	
			subject.saveFavorites();
			
			// COMPLETE REMOVE FAVORITE
			_event = null;
			assertTrue("YahooDataModelTest::testRemoveFavorite (complete) => Item should be removed from favorites", subject.removeFavorite(industryVO, true));
			
			assertNotNull("YahooDataModelTest::testRemoveFavorite (complete) => CollectionEvent.COLLECTION_CHANGE should be dispatched", _event);
			assertEquals("YahooDataModelTest::testRemoveFavorite (complete) => Wrong vo changed on removeFavorite", industryVO, _event.source);
			
			// COMPLETE REMOVE FAVORITE AGAIN
			_event = null;
			assertFalse("YahooDataModelTest::testRemoveFavorite (complete) => Item could not be removed from favorites", subject.removeFavorite(industryVO, true));
			
			assertNull("YahooDataModelTest::testRemoveFavorite (complete) => CollectionEvent.COLLECTION_CHANGE should not be dispatched on removeFavorite", _event);
			_event = null;
			
			// Add favorite to be removed
			subject.addFavorite(industryVO);
			
			// RESET FAVORITES
			subject.resetFavorites();
			
			subject.getIndustries().removeEventListener(CollectionEvent.COLLECTION_CHANGE, _onPropertyChanged);
			
			subject.closeItem(subject.getIndustries(), subject.getIndustries().getItemIndex(sectorVO));
			
			sectorVO = null;
			industryVO = null;
			_event = null;
		}
		
		[Test (async)]
		public function testSaveFavorites():void
		{
			trace("VF", new Date().toLocaleTimeString(), "YahooDataModelTest::testSaveFavorites");
			
			var timer:Timer = new Timer(500, 5); // Random saveFavorites test each .5 sec
			var asyncCompleteHandler:Function = Async.asyncHandler(this, saveFavoritesFinishedHandler, timer.delay * (timer.repeatCount + 1));
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, asyncCompleteHandler, false, 0, true);
			timer.addEventListener(TimerEvent.TIMER, saveFavoritesOnTimer, false, 0, true );
			timer.start();
		}
		
		private function saveFavoritesFinishedHandler(event:Event, passThroughData:Object):void
		{
			trace("VF", new Date().toLocaleTimeString(), "YahooDataModelTest::saveFavoritesFinishedHandler", passThroughData);
		}
		
		public function saveFavoritesOnTimer(event:TimerEvent):void
		{
			saveFavorites(false);
		}
		
		[Test (async)]
		public function testResetFavorites():void
		{
			trace("VF", new Date().toLocaleTimeString(), "YahooDataModelTest::testResetFavorites");
			
			var timer:Timer = new Timer(500, 5); // Random saveFavorites test each .5 sec
			var asyncCompleteHandler:Function = Async.asyncHandler(this, saveFavoritesFinishedHandler, timer.delay * (timer.repeatCount + 1));
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, asyncCompleteHandler, false, 0, true);
			timer.addEventListener(TimerEvent.TIMER, resetFavoritesOnTimer, false, 0, true );
			timer.start();
		}
		
		protected function resetFavoritesOnTimer(event:TimerEvent):void
		{
			saveFavorites(true);
		}
		
		private function saveFavorites(reset:Boolean = false):void
		{
			var mode:String = reset == true ? "RESET":"SAVE";
			
			trace("VF", new Date().toLocaleTimeString(), "YahooDataModelTest::saveFavorites", mode);
			
			var sectorVO:IIndustryVO = getRandomSector();
			
			subject.openItem(subject.getIndustries(), subject.getIndustries().getItemIndex(sectorVO));
			
			var count:int = sectorVO.children.length; 
			var action:int;
			var changed:ArrayList = new ArrayList();
			
			var industryVO:IIndustryVO;
			
			for(var i:int = 0; i<count; i++)
			{
				industryVO = sectorVO.children.getItemAt(i) as IIndustryVO;
				action = Math.random() * 2;
				
				if(action == 0)
				{
					if(industryVO.isFavorite == false)
					{
						subject.addFavorite(industryVO);
						changed.addItem([industryVO, reset? -1:1]);
						//trace("VF", new Date().toLocaleTimeString(), "YahooDataModelTest::saveFavorites", industryVO.name, "added to favorites");
						assertTrue("YahooDataModelTest::saveFavorites /" + mode + "/ => BEFORE: Item should NOT be presented in favorites", subject.getFavorites().getItemIndex(industryVO) == -1);
					}
				}
				else
				{
					if(industryVO.isFavorite == true)
					{
						subject.removeFavorite(industryVO);
						changed.addItem([industryVO, reset? 1:-1]);
						//trace("VF", new Date().toLocaleTimeString(), "YahooDataModelTest::saveFavorites", industryVO.name, "removed from favorites");
						assertTrue("YahooDataModelTest::saveFavorites /" + mode + "/ => BEFORE: Item should be presented in favorites", subject.getFavorites().getItemIndex(industryVO) > -1);
					}
				}
			}
			
			var dispatched:ArrayList = new ArrayList();
			
			var _onPropertyChanged:Function = function(event:PropertyChangeEvent):void
			{
				dispatched.addItem(event.source);
			}
			
			subject.getIndustries().addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, _onPropertyChanged);
			
			if(reset)
			{
				subject.resetFavorites();
			}
			
			subject.saveFavorites();
			
			i = changed.length;
			var changedItem:Array;
			while(i--)
			{
				changedItem = changed.removeItemAt(i) as Array;
				industryVO = changedItem[0] as IIndustryVO;
				assertTrue("YahooDataModelTest::saveFavorites /" + mode + "/ => AFTER: Wrong vo dispatched " + industryVO.name, dispatched.getItemIndex(industryVO) > -1);
				if(changedItem[1] == 1)
				{
					assertTrue("YahooDataModelTest::saveFavorites /" + mode + "/ => AFTER: Item should be presented in favorites " + industryVO.name, subject.getFavorites().getItemIndex(industryVO) > -1);
					assertTrue("YahooDataModelTest::saveFavorites /" + mode + "/ => AFTER: Item was not marked as favorite " + industryVO.name, industryVO.isFavorite);
				}
				else if(changedItem[1] == -1)
				{
					assertTrue("YahooDataModelTest::saveFavorites /" + mode + "/ => AFTER: Item should NOT be presented in favorites " + industryVO.name, subject.getFavorites().getItemIndex(industryVO) == -1);
					assertFalse("YahooDataModelTest::saveFavorites /" + mode + "/ => AFTER: Item was not marked as favorite " + industryVO.name, industryVO.isFavorite);
				}
			}
			
			assertEquals("YahooDataModelTest::saveFavorites /" + mode + "/ => AFTER: All changed items should be dispatched", changed.length, 0);
			
			subject.getIndustries().removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, _onPropertyChanged);
			
			subject.closeItem(subject.getIndustries(), subject.getIndustries().getItemIndex(sectorVO));
			
			changed.removeAll();
			changed = null;
			
			dispatched.removeAll();
			dispatched = null;
			
			sectorVO = null;
			industryVO = null;
			if(changedItem != null)
			{
				changedItem.length = 0;
				changedItem = null;
			}
		}
		
		[Test]
		public function testGetFavorites():void
		{
			trace("VF", new Date().toLocaleTimeString(), "YahooDataModelTest::testGetFavorites");
			
			assertTrue("YahooDataModelTest::testGetFavorites => Favorites should be an ArrayList", subject.getFavorites() is ArrayList);
			
			var favorites:ArrayList = subject.getFavorites();
			
			assertNotNull("YahooDataModelTest::testGetFavorites => YahooDataModel should have industries", favorites);
			
			var i:int = favorites.length;
			while(i--)
			{
				assertTrue("YahooDataModelTest::testGetFavorites => Companies should consist IIndustryVO only", favorites.getItemAt(i) is IIndustryVO); 
			}
		}
		
		[Test (async)]
		public function testSetCompanies():void
		{
			trace("VF", new Date().toLocaleTimeString(), "YahooDataModelTest::testSetCompanies");
			
			var count:int = 0;
			var _onSetCompanies:Function = function(event:YahooCompanyEvent):void
			{
				count++;				
			} 
			
			var asyncDataLoadedHandler:Function = Async.asyncHandler(this,
					function(event:DataLoaderEvent, passThrough:*):void
					{
						trace("VF", new Date().toLocaleTimeString(), "YahooDataModelTest::testSetCompanies /DataLoaderEvent.EVENT_DATA_LOADED/", event.dataType);
						if(event.dataType == YahooLoaderDataTypes.COMPANIES)
						{
							subject.setCompanies(event.loadedData);	
							
							assertTrue("YahooDataModelTest::testSetCompanies => YahooDataModel should have companies", subject.getCompanies().length > 0);
							assertEquals("YahooDataModelTest::testSetCompanies => YahooCompanyEvent.COMPANIES_CHANGED should be dispatched", 1, count);
							
							subject.eventDispatcher.removeEventListener(DataLoaderEvent.EVENT_DATA_LOADED, asyncDataLoadedHandler);
							subject.eventDispatcher.removeEventListener(YahooCompanyEvent.COMPANIES_CHANGED, _onSetCompanies);
						}
					}, 60000, null, 
					function(event:Event):void
					{
						trace("VF", "YahooDataModelTest::testSetCompanies TIME_OUT");
					}
				);
			
			var industryVO:IIndustryVO = getRandomIndustry();
			serviss.eventDispatcher = subject.eventDispatcher;
			
			subject.eventDispatcher.addEventListener(DataLoaderEvent.EVENT_DATA_LOADED, asyncDataLoadedHandler);
			subject.eventDispatcher.addEventListener(YahooCompanyEvent.COMPANIES_CHANGED, _onSetCompanies);
			
			serviss.load(new YahooDataServiceStrategy(YahooLoaderDataTypes.COMPANIES, { id:industryVO.id }));
		}
		
		[Test]
		public function testGetCompanies():void
		{
			trace("VF", new Date().toLocaleTimeString(), "YahooDataModelTest::testGetCompanies");
			
			assertTrue("YahooDataModelTest::testGetCompanies => Companies should be an ArrayList", subject.getCompanies() is ArrayList);
			
			var companies:ArrayList = subject.getCompanies();
			
			assertNotNull("YahooDataModelTest::testGetCompanies => YahooDataModel should have companies", companies);
			
			var i:int = companies.length;
			while(i--)
			{
				assertTrue("YahooDataModelTest::testGetCompanies => Companies should consist ICompanyVO only", companies.getItemAt(i) is ICompanyVO); 
			}
		}
		
		[Test]
		public function testGetCurrentCompany():void
		{
			trace("VF", new Date().toLocaleTimeString(), "YahooDataModelTest::testGetCurrentCompany");
			
			assertTrue("YahooDataModelTest::testGetCurrentCompany => Company should implement ICompanyVO", subject.getCurrentCompany() is ICompanyVO || subject.getCurrentCompany() == null); 
		}
		
		[Test]
		public function testCloseItem():void
		{
			trace("VF", new Date().toLocaleTimeString(), "YahooDataModelTest::testCloseItem");
			
			var sectorVO:IIndustryVO = getRandomSector();
			subject.openItem(subject.getIndustries(), subject.getIndustries().getItemIndex(sectorVO));
			subject.closeItem(subject.getIndustries(), subject.getIndustries().getItemIndex(sectorVO));
			var i:int = sectorVO.children.length;
			while(i--)
			{
				assertEquals("YahooDataModelTest::testCloseItem => Industry should not be presented in industries list",  subject.getIndustries().getItemIndex(sectorVO.children.getItemAt(i)), -1);
			}
		}
		
		[Test]
		public function testOpenItem():void
		{
			trace("VF", new Date().toLocaleTimeString(), "YahooDataModelTest::testOpenItem");
			
			var sectorVO:IIndustryVO = getRandomSector();
			subject.openItem(subject.getIndustries(), subject.getIndustries().getItemIndex(sectorVO));
			var i:int = sectorVO.children.length;
			while(i--)
			{
				assertTrue("YahooDataModelTest::testOpenItem => Industry should be presented in industries list",  subject.getIndustries().getItemIndex(sectorVO.children.getItemAt(i)) > -1);
			}
			subject.closeItem(subject.getIndustries(), subject.getIndustries().getItemIndex(sectorVO));
		}
		
		[Test (async)]
		public function testSetCurrentCompany():void
		{
			trace("VF", new Date().toLocaleTimeString(), "YahooDataModelTest::testSetCurrentCompany");
			
			var asyncDataLoadedHandler:Function = Async.asyncHandler(this,
				function(event:DataLoaderEvent, passThrough:*):void
				{
					trace("VF", new Date().toLocaleTimeString(), "YahooDataModelTest::testSetCurrentCompany /DataLoaderEvent.EVENT_DATA_LOADED/", event.dataType);
					if(event.dataType == YahooLoaderDataTypes.COMPANIES)
					{
						subject.setCompanies(event.loadedData);
						
						var companyVO:ICompanyVO = getRandomCompany();
						subject.setCurrentCompany(companyVO);
						assertEquals("YahooDataModelTest::testSetCurrentCompany => Current company was not set", subject.getCurrentCompany(), companyVO);
						assertTrue("YahooDataModelTest::testSetCurrentCompany => Current company isCurrent parameter is false", companyVO.isCurrent);
						
						var newCompanyVO:ICompanyVO = getRandomCompany();
						while(newCompanyVO !== companyVO)
						{
							newCompanyVO = getRandomCompany();
						}
						subject.setCurrentCompany(newCompanyVO);
						assertEquals("YahooDataModelTest::testSetCurrentCompany => Current company was not changed", subject.getCurrentCompany(), newCompanyVO);
						assertTrue("YahooDataModelTest::testSetCurrentCompany => Current company isCurrent parameter is false", newCompanyVO.isCurrent);
						
						subject.eventDispatcher.addEventListener(DataLoaderEvent.EVENT_DATA_LOADED, asyncDataLoadedHandler);
					}
				}, 60000, null, 
				function(event:Event):void
				{
					trace("VF", "YahooDataModelTest::testSetCurrentCompany TIME_OUT");
				}
			);
			
			var industryVO:IIndustryVO = getRandomIndustry();
			serviss.eventDispatcher = subject.eventDispatcher;
			
			subject.eventDispatcher.addEventListener(DataLoaderEvent.EVENT_DATA_LOADED, asyncDataLoadedHandler);
			
			serviss.load(new YahooDataServiceStrategy(YahooLoaderDataTypes.COMPANIES, { id:industryVO.id }));
		}
		
		[Test (async)]
		public function testSetCurrentCompanyBySymbol():void
		{
			trace("VF", new Date().toLocaleTimeString(), "YahooDataModelTest::testSetCurrentCompanyBySymbol");
			
			var asyncDataLoadedHandler:Function = Async.asyncHandler(this,
				function(event:DataLoaderEvent, passThrough:*):void
				{
					trace("VF", new Date().toLocaleTimeString(), "YahooDataModelTest::testSetCurrentCompanyBySymbol /DataLoaderEvent.EVENT_DATA_LOADED/", event.dataType);
					if(event.dataType == YahooLoaderDataTypes.COMPANIES)
					{
						subject.setCompanies(event.loadedData);
						
						var companyVO:ICompanyVO = getRandomCompany();
						subject.setCurrentCompanyBySymbol(companyVO == null? null:companyVO.symbol);
						assertEquals("YahooDataModelTest::testSetCurrentCompanyBySymbol => Current company was not set by symbol", subject.getCurrentCompany(), companyVO);
						assertTrue("YahooDataModelTest::testSetCurrentCompanyBySymbol => Current company isCurrent parameter is false", companyVO.isCurrent);
						
						var newCompanyVO:ICompanyVO = getRandomCompany();
						while(newCompanyVO !== companyVO)
						{
							newCompanyVO = getRandomCompany();
						}
						subject.setCurrentCompanyBySymbol(companyVO == null? null:companyVO.symbol);
						assertEquals("YahooDataModelTest::testSetCurrentCompanyBySymbol => Current company was not changed", subject.getCurrentCompany(), newCompanyVO);
						assertTrue("YahooDataModelTest::testSetCurrentCompanyBySymbol => Changed current company isCurrent parameter is false", newCompanyVO.isCurrent);
						
						subject.eventDispatcher.addEventListener(DataLoaderEvent.EVENT_DATA_LOADED, asyncDataLoadedHandler);
					}
				}, 60000, null, 
				function(event:Event):void
				{
					trace("VF", "YahooDataModelTest::testSetCurrentCompanyBySymbol TIME_OUT");
				}
			);
			
			var industryVO:IIndustryVO = getRandomIndustry();
			serviss.eventDispatcher = subject.eventDispatcher;
			
			subject.eventDispatcher.addEventListener(DataLoaderEvent.EVENT_DATA_LOADED, asyncDataLoadedHandler);
			
			serviss.load(new YahooDataServiceStrategy(YahooLoaderDataTypes.COMPANIES, { id:industryVO.id }));
		}
		
		[Test]
		public function testSetCurrentIndustry():void
		{
			trace("VF", new Date().toLocaleTimeString(), "YahooDataModelTest::testSetCurrentIndustry");
			
			var industryVO:IIndustryVO = getRandomIndustry();
			subject.setCurrentIndustry(industryVO);
			assertEquals("YahooDataModelTest::testSetCurrentIndustry => Current industry was not set", subject.getCurrentIndustry(), industryVO);
			assertTrue("YahooDataModelTest::testSetCurrentIndustry => Current industry isCurrent parameter is false", industryVO.isCurrent);
			
			
			var newIndustryVO:IIndustryVO = getRandomIndustry();
			while(newIndustryVO !== industryVO)
			{
				newIndustryVO = getRandomIndustry();
			}
			subject.setCurrentIndustry(newIndustryVO);
			assertEquals("YahooDataModelTest::testSetCurrentIndustry => Current industry was not changed", subject.getCurrentIndustry(), newIndustryVO);
			assertTrue("YahooDataModelTest::testSetCurrentIndustry => Changed current industry isCurrent parameter is false", newIndustryVO.isCurrent);
		}
		
		//---------------------------------------------------------------------
		
		private function getRandomCompany():ICompanyVO
		{
			var companies:ArrayList = subject.getCompanies();
			if(companies.length == 0)
			{
				return null;
			}
			var i:int = (Math.random() * (companies.length - 1)) >> 0;
			return companies.getItemAt(i) as ICompanyVO;
		}
		
		private function getRandomIndustry(sector:IIndustryVO = null):IIndustryVO
		{
			sector ||= getRandomSector();
			
			if(sector == null)
			{
				return null;
			}
			
			if(industries == null)
			{
				trace("VF", "YahooDataModelTest::getRandomIndustry => industries was not created!!!");
				return null;
			}
			
			sector ||= getRandomSector();

			var a:int = (Math.random() * (sector.children.length - 1)) >> 0;
			
			return sector.children.getItemAt(a) as IIndustryVO;
		}
		
		private function getRandomSector():IIndustryVO
		{
			if(sectors == null)
			{
				trace("VF", "YahooDataModelTest::getRandomSector => sectors was not created!!!");
				return null;
			}
			
			var i:int = (Math.random() * (sectors.length - 1)) >> 0;
			return sectors.getItemAt(i) as IIndustryVO;
		}
	}
}