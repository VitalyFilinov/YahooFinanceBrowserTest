/**
 * IndustryManagerMediator is created and used as a Mediator of the project robotlegs structure
 * to connect IndustryManagerView to the project. 
 */
package com.vit.yahoobrowser.views
{
	import com.vit.yahoobrowser.events.YahooDataSearchEvent;
	import com.vit.yahoobrowser.events.YahooViewEvent;
	import com.vit.yahoobrowser.models.IYahooDataModel;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class IndustryManagerMediator extends Mediator
	{
		[Inject]
		public var dataModel:IYahooDataModel;
		
		[Inject]
		public var view:IndustryManagerView;
		
		override public function initialize():void
		{
			addViewListener(YahooDataSearchEvent.SEARCH, dispatch, YahooDataSearchEvent);
			
			//addViewListener(YahooViewEvent.INVOKE_INDUSTRY_BROWSER, dispatch, YahooViewEvent);
			//TODO Why direct dispatch is not working???
			
			addViewListener(YahooViewEvent.INVOKE_INDUSTRY_BROWSER, dispatchIvoke, YahooViewEvent);
		}
		
		/**
		 * Dispatches YahooViewEvent.INVOKE_INDUSTRY_BROWSER
		 * TODO Why direct dispatch is not working???
		 */
		private function dispatchIvoke(event:YahooViewEvent):void
		{
			dispatch(new YahooViewEvent(YahooViewEvent.INVOKE_INDUSTRY_BROWSER));
		}
	}
}