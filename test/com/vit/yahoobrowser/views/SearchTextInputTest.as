package com.vit.yahoobrowser.views
{
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.TimerEvent;
	
	import mx.events.FlexEvent;
	
	import flexunit.framework.Assert;
	
	import org.flexunit.assertThat;
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.async.Async;
	import org.fluint.uiImpersonation.UIImpersonator;
	
	public class SearchTextInputTest
	{
		private var subject:SearchTextInput;
		
		[Before (async, ui)]
		public function setUp():void
		{
			subject = new SearchTextInput();
			subject.text = "testText";
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
		public function testInit():void
		{
			assertEquals("Value should be empty because text was not set before creation was complete", subject.value, "");
			subject.text = "changed text";
			assertEquals("Value should be 'changed text'", subject.value, "changed text");
			subject.text = "";
			assertEquals("Text should equal default text", subject.text, "testText");
		}
		
		[Test (async)]
		public function testFocusInWhenEmpty():void
		{
			var onFocusIn:Function = Async.asyncHandler(this,
				function(event:Event, passThroughData:Object):void
					{
						assertEquals("Value should be empty", subject.value, ""); 
						assertEquals("Text should be empty", subject.text, ""); 
					}, 500);
			subject.addEventListener(FocusEvent.FOCUS_IN, onFocusIn, false, 0, true);
			subject.stage.focus = subject;
		}
		
		[Test (async)]
		public function testFocusOutWhenEmpty():void
		{
			subject.stage.focus = subject;
			var onFocusOut:Function = Async.asyncHandler(this,
				function(event:Event, passThroughData:Object):void
				{
					assertEquals("Value should be empty", subject.value, ""); 
					assertEquals("Text should be default text", subject.text, "testText"); 
				}, 500);
			subject.addEventListener(FocusEvent.FOCUS_OUT, onFocusOut, false, 0, true);
			subject.stage.focus = null;
		}
		
		[Test (async)]
		public function testFocusInWhenValue():void
		{
			subject.text = "testFocusInWhenValue";
			var onFocusIn:Function = Async.asyncHandler(this,
				function(event:Event, passThroughData:Object):void
				{
					assertEquals("Value should not be empty", subject.value, "testFocusInWhenValue"); 
					assertEquals("Text should not be empty", subject.text, "testFocusInWhenValue"); 
				}, 500);
			subject.addEventListener(FocusEvent.FOCUS_IN, onFocusIn, false, 0, true);
			subject.stage.focus = subject;
		}
		
		[Test (async)]
		public function testFocusOutWhenValue():void
		{
			subject.text = "testFocusInWhenValue";
			subject.stage.focus = subject;
			var onFocusOut:Function = Async.asyncHandler(this,
				function(event:Event, passThroughData:Object):void
				{
					assertEquals("Value should noy be empty", subject.value, "testFocusInWhenValue"); 
					assertEquals("Text should not be default text", subject.text, "testFocusInWhenValue"); 
				}, 500);
			subject.addEventListener(FocusEvent.FOCUS_OUT, onFocusOut, false, 0, true);
			subject.stage.focus = null;
		}
		
		[Test (async)]
		public function testMouseFocusChange():void
		{
			var onFocusChange:Function = Async.asyncHandler(this,
				function(event:Event, passThroughData:Object):void
				{
					trace("VF", new Date().toLocaleTimeString(), "SearchTextInputTest::testMouseFocusChange FocusEvent.MOUSE_FOCUS_CHANGE");
					assertThat("Focus should be removed from subject", subject.stage.focus != subject);
				}, 50000);
			subject.addEventListener(FocusEvent.MOUSE_FOCUS_CHANGE, onFocusChange, false, 0, true);
			subject.stage.focus = subject;
			trace("VF", new Date().toLocaleTimeString(), "SearchTextInputTest::testMouseFocusChange !!! CLICK SOMEWHERE in the flash window !!!");
		}
	}
}