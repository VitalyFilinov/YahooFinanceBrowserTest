package com.vit.yahoobrowser.views
{
	import com.vit.yahoobrowser.events.YahooDataSearchEvent;
	import com.vit.yahoobrowser.events.YahooViewEvent;
	
	import flash.events.MouseEvent;
	
	import mx.events.FlexEvent;
	
	import spark.events.TextOperationEvent;
	
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.asserts.assertNull;
	import org.flexunit.async.Async;
	import org.fluint.uiImpersonation.UIImpersonator;

	public class IndustryManagerViewTest
	{
		private var subject:IndustryManagerView;
		
		[Before (async, ui)]
		public function setUp():void
		{
			subject = new IndustryManagerView();
			Async.proceedOnEvent(this, subject, FlexEvent.CREATION_COMPLETE);
			UIImpersonator.addChild(subject);
		}
		
		[After]
		public function tearDown():void
		{
			UIImpersonator.removeChild(subject);
			subject = null;
		}
		
		[Test]
		public function testListButtonClick():void
		{
			var _event:YahooViewEvent;
			
			var onYahooViewEvent:Function = function(event:YahooViewEvent):void
			{
				_event = event;
			}
			
			subject.addEventListener(YahooViewEvent.INVOKE_INDUSTRY_BROWSER, onYahooViewEvent);
			subject.btn.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
			subject.addEventListener(YahooViewEvent.INVOKE_INDUSTRY_BROWSER, onYahooViewEvent);
			
			assertNotNull("YahooViewEvent was not dispatched", _event);
		}
		
		[Test]
		public function testChangeHandler():void
		{
			var _event:YahooDataSearchEvent;
			
			var onYahooDataSearchEvent:Function = function(event:YahooDataSearchEvent):void
			{
				_event = event;
			}
			
			subject.addEventListener(YahooDataSearchEvent.SEARCH, onYahooDataSearchEvent);
			subject.search.text = "t";
			subject.search.dispatchEvent(new TextOperationEvent(TextOperationEvent.CHANGE));
			
			assertNull("YahooDataSearchEvent should not be dispatched on string length less then 2", _event);
			
			subject.search.text = "test";
			subject.search.dispatchEvent(new TextOperationEvent(TextOperationEvent.CHANGE));
			
			assertNotNull("YahooDataSearchEvent should be dispatched", _event);
			
			subject.addEventListener(YahooDataSearchEvent.SEARCH, onYahooDataSearchEvent);
		}
	}
}