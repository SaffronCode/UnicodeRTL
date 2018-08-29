// *************************
// * COPYRIGHT
// * DEVELOPER: MTEAM ( info@mteamapp.com )
// * ALL RIGHTS RESERVED FOR MTEAM
// * YOU CAN'T USE THIS CODE IN ANY OTHER SOFTWARE FOR ANY PURPOSE
// * YOU CAN'T SHARE THIS CODE
// *************************


/**Version : 1.2
 * 	- 92-12-26 : 	setID debuged
 *  - 92-12-28 : 	cash is supported now on convert() function
 * 					arabic number correction activated on convert() function
 *  - 92-1-19  :	firstSetUp(forceToSetUp:Boolean=false) debugged - it didmt refresh the temporary
 * 	- 92-2-18  :	textID  function depends on textField heigh , i removed this dependency because heights will change with auto size tag
 * 	- 93-3-26  :	number correction added to function list
 * 	- 93-4-4   :	htmlText debuged , text without cash was automaticly justified
 * 	- 93-5-11  :	arabicNumber FUNCTION get publiced
 * -	93-12-24 : Arabic detection lines added here.
 */


package com.mteamapp
{
	
	import flash.net.SharedObject;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.utils.getTimer;
	
	

	public class UnicodeStatic
	{
		private static var 	uni:Unicode,
							tempStrings:SharedObject,
							tempID:String = 'unicodTextTemp';
							
		/**Deactivate convertor without controlling the isArabic value*/
		public static var deactiveConvertor:Boolean = false ;
		
		/**This will be cause to ignor selected language typ from function and detecting arabic script on the text dynamicly.*/
		public static var detectArabicScript:Boolean = false ;
		
		
		
							
		/**change the id of cashes*/
		public static function setID(newID:String)
		{
			tempID = newID ;
			//new line↓ 92-12-27
			firstSetUp(true);
		}
		
		
		
		/**convert numbers to arabic*/
		public static function arabicNumber(myText:String):String
		{
			return uni.NumberChange(myText);
		}
		
		/**remove all cashd strings based on this cash id*/
		public static function clearMyTemp(cashID:String=null)
		{
			if(cashID == null)
			{
				cashID = tempID ;
			}
			tempStrings = SharedObject.getLocal(cashID);
			tempStrings.clear();
			tempStrings = null ;
		}
		/**it can cash your text to load it later*/			
		public static function convert(str:String,useCash:Boolean=false,arabicNumber:Boolean=false)
		{
			//trace('♣');
			
			if(deactiveConvertor && (!detectArabicScript || detectArabicScript && !StringFunctions.isPersian(str)))
			{
				//Continue in default way
				return str ;
			}
			
			firstSetUp();
			if(str=='' || str==null)
			{
				return '' ;
			}
			
			var noData = useCash ;
			if(useCash)
			{
				var ID = textID(null,str);
				var cashed:String = loadStringFromData(ID);
				//trace('cashed : '+cashed);
				if (cashed == null || cashed == 'undefined' || cashed == '')
				{
					noData = false;
				}
				else
				{
					return cashed;
				}
			}
			if(!noData)
			{
				//trace('☻');
				var string:String = uni.toUnicode(String(str));
				if(arabicNumber)
				{
					string = uni.NumberChange(string);
				}
				if(useCash)
				{
					saveStringOnID(ID,string);
				}
				return string;
			}
		}
		
		public static function fastUnicodeOnLines(target:TextField,tx:String,autoSize:Boolean=false):void
		{
			firstSetUp();
			if(autoSize)
			{
				target.height = 50;
			}
			target.multiline = true;
			target.wordWrap = true ;
			//trace("detectArabicScript : "+detectArabicScript+' && '+"!StringFunctions.isArabic(tx) : "+!StringFunctions.isPersian(tx));
			if(deactiveConvertor && (!detectArabicScript || !StringFunctions.isPersian(tx)))
			{
				target.text = tx;
			}
			else
			{
				uni.fastUnicodeOnLines(target,tx);
			}
			if(autoSize)
			{
				target.height = target.textHeight+10;
				//Debugged !! for no reason, these lines on below makes the target resized on one case. single line did not make change.
				//target.height = target.textHeight+10;
				//target.height = target.textHeight+10;
				//> The cause of that discovered: First height of the textfield was 1 and that was the cause of previus bug.
				target.mouseWheelEnabled = false;
			}
		}
		
		public static function htmlText(target:TextField,tx:String,useCash:Boolean=true,autoSize:Boolean=false,justify:Boolean=true,splitIfToLong:Boolean=false):void
		{
			firstSetUp();
			target.multiline = true;
			
			var detectedArabicScript:Boolean = true ;
			var wasArabic:Boolean = true ;
			
			if(detectArabicScript)
			{
				//trace("***************************Detect arabic************************");
				detectedArabicScript = StringFunctions.isPersian(tx) ;
				trace("+++++++++++++++ detectedArabicScript : "+detectedArabicScript);
				trace("+++++++++++++++ tx : "+tx);
				//trace("This is arabic ***********************"+detectedArabicScript);
				wasArabic = detectedArabicScript ;
			}
			
			//trace('add this : '+tx.substr(0,20));
			if(useCash && !deactiveConvertor && detectedArabicScript)
			{
				var ID = textID(target,tx);
				var cashed:String = loadStringFromData(ID);
				if (cashed == null || cashed == 'undefined' || cashed == '')
				{
					//trace('not founded');
					tx = correctHTMLS(tx) ;
					//trace("tx : "+tx);
					uni.HTMLfastUnicodeOnLines(target,tx,justify);
					saveStringOnID(ID,target.htmlText);
				}
				else
				{
					//trace('♠founded : '+cashed);
					//This will not use with deactiveConvertor. so dont care about htmls
					target.htmlText = cashed ;
				}
			}
			else
			{
				tx = correctHTMLS(tx) ;
				if((deactiveConvertor || !detectedArabicScript ) && !(detectArabicScript && detectedArabicScript))
				{
					target.text = 'MESepehr' ;
					//I don't remember why did I do below check to prevent justify on CenterAlighn
					var tf:TextFormat;
					//This line will prevent added html tags override with old and static ones. This is for Contents class use.
					target.htmlText = target.htmlText.split(target.text).join(tx) ;
						//target.text = tx ;
					tf = target.getTextFormat();
					//trace("******* Englisher ******* detected");
					if(justify && target.defaultTextFormat.align != TextFormatAlign.CENTER)
					{
						tf.align = TextFormatAlign.JUSTIFY ;
						//target.defaultTextFormat = tf ;
						target.setTextFormat(tf) ;
						//target.defaultTextFormat.align = TextAlign.JUSTIFY ;
					}
					else if(tf.align==TextFormatAlign.RIGHT)
					{
						tf.align = TextFormatAlign.LEFT ;
						target.setTextFormat(tf) ;
					}
					
					//The below line makes html text effects remove.
					/*if(tf!=null)
					{
						target.setTextFormat(tf);
					}*/
				}
				else
				{
					uni.HTMLfastUnicodeOnLines(target,tx,justify);
				}
			}
			if(splitIfToLong)//This is not supports html now
			{
				if(target.maxScrollV>1)
				{
					var axxeptedText:String = '' ;
					var maxAxxeptedTextLine:uint = target.numLines - (target.maxScrollV-1) ;
					var lineText:String ;
					for(var i = 0 ; i<maxAxxeptedTextLine ; i++)
					{
						lineText = target.getLineText(i);
						if(i == maxAxxeptedTextLine-1)
						{
							var spaceIndex:uint ;
							if(wasArabic)
							{
								spaceIndex = lineText.indexOf(' ',2);
							}
							else
							{
								spaceIndex = lineText.lastIndexOf(' ',lineText.length-3);
							}
							if(spaceIndex!=-1)
							{
								if(wasArabic)
								{
									lineText = '...'+lineText.substring(spaceIndex+1);
								}
								else
								{
									lineText = lineText.substring(spaceIndex+1)+'...';
								}
							}
						}
						axxeptedText += lineText ;
					}
					target.text = axxeptedText ;
				}
			}
			else if(autoSize)
			{
				target.height = target.textHeight+10;
			}
		}
		
		private static function correctHTMLS(htmlString:String):String
		{
			if(htmlString==null)
			{
				htmlString = '' ;
			}
			return htmlString.split('[[').join('<').split(']]').join('>')
		}
		
		/**insialize the app*/
		private static function firstSetUp(forceToSetUp:Boolean=false)
		{
			if(uni==null || forceToSetUp==true)
			{
				uni = new Unicode();
				tempStrings = SharedObject.getLocal(tempID);
				if(tempStrings.data['unicodetemp'] == undefined)
				{
					tempStrings.data['unicodetemp'] = new Object();
				}	
			}
		}
		
		/**reset the unicod temp for this app*/
		public static function resetTemp()
		{
			firstSetUp();
			tempStrings.data['unicodetemp'] = new Object();
		}
		
		
		
		private static function textID(yourTextField:TextField,tex:String):String
		{
			if(yourTextField==null)
			{
				yourTextField = new TextField();
			}
			var tf:TextFormat = yourTextField.defaultTextFormat ;
			var size:Number = Number(tf.size);
			var font:String = tf.font ;
			var bold:String = String(tf.bold);
			/**text height removed from id generator , each text hav to had one id*/
			var ID:String = yourTextField.width/*+','+yourTextField.height*/+','+tex.length+','+tex.substring(0,5)+','+tex.substring(tex.length-5,tex.length)+','+zipTheText(tex.substr(tex.length/2))+','+zipTheText(tex.substr(0,tex.length/2))+','+size+','+font+bold;
			//trace("ID is : "+ID);
			return ID ;
		}
		
		
		/**returns an Number that is will be result of sum of all string carachters code*/
		private static function zipTheText(tex:String):uint
		{
			var tim:Number = getTimer();
			var myNum:uint = 0 ;
			for(var i=0;i<tex.length;i++)
			{
				myNum += tex.charCodeAt(i);
			}
			//trace("Zip tooken time : "+(getTimer()-tim));
			return myNum;
		}
		
		
		
		/**if The Language Is ENglish ( or any Other LR languages that can handel by Flash it self) dont search for
		 * cashed Strings*/
		private static function loadStringFromData(ID:String){
			return tempStrings.data['unicodetemp'][ID];
		}
		
		
		
		/** if Language is LR , it will not Cash Any thins*/
		private static function saveStringOnID(ID:String,Text:String){
			//trace('♠saved on cash');
			tempStrings.data['unicodetemp'][ID] = Text;
				//↓ this line will make app crash if device had not enaugh storage
			try
			{
				tempStrings.flush();
			}catch(e){};
		}
		
		/**this function will remove all persian ک and ی and will repace them with ي and ك*/
		public static function KaafYe(str:String):String
		{
			return str.split('ی').join('ي').split('ک').join('ك').split('ى').join('ي');
		}
		
		
		/**this funciton will reset all farsi numbers to english numbers*/
		public static function numberCorrection(str:String):String
		{
			firstSetUp();
			return uni.numCorrection(str);
		}
		
		/**clear ي or ة */
		public static function clearArabicStyles(str:String):String
		{
			return str.split('ي').join('ی').split('ة').join('ه').split('‏').join(' ');
		}
		
		
		/**detect arabic texts*/
		public static function isArabic(str:String):Boolean
		{
			for(var i = 0 ; i<str.length ; i++)
			{
				if(str.charCodeAt(i)>1000)
				{
					return true;
				}
			}
			return false ;
		}
	}
}