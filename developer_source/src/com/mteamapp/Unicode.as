// *************************
// * COPYRIGHT
// * DEVELOPER: MTEAM ( info@mteamapp.com )
// * ALL RIGHTS RESERVED FOR MTEAM
// * YOU CAN'T USE THIS CODE IN ANY OTHER SOFTWARE FOR ANY PURPOSE
// * YOU CAN'T SHARE THIS CODE
// *************************

/**by Mohammad Ebrahim -Motahar Parrs Co
 //last edit 6/1/2013
 //10/14/2013 : . character removed from estesna list for converting float Numbers like 15.5
 ///11/24/2013  fast html unicode added : HTMLfastUnicodeOnLines();  2 time slower than 
 //				fastUnicodeOnLines but it can support coloring texts and justify paraphs
 //4/13/2014	:	use hirostic algoritms to improve main function speed about 30%
 * 8/6/2014 : optimized
 *	9/27/2014 : ٌ  character added to charackter lists
 * 6/24/2015 ; HTMLUnicode UPGRADED to make all HTML tags usable
 * 				Farsi correction updated
 * 6/29/2015 : Unicode_string.as created 
 * 8/9/2015 : Performance upgraded
 * 8/31/2015: new character added to list
 */
package com.mteamapp
{
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	public class Unicode
	{
		/**This is still in beta version*/
		public static var UseNewFastInLine:Boolean = false ;
		
		//From now there is no need to copy full class here, you can only copy and edite Unicode_string to your project folder.
		//include "Unicode_strings.as"
		//Not Effected
		
		public static var splitters:Array = [',','.',' ','-',')',':'];
		public static var adad = '٠١٢٣٤٥٦٧٨٩۰۱۲۳۴۵۶۷۸۹٠١٢٣٤٥٦٧٨٩٠١٢٣٤٥٦٧٨٩۰۱۲۳۴۵۶۷۸۹۰۱۲۳۴۵۶۷۸۹����٪٪';
		public static var estesna = '-[]»«)("/\\:';
		public static var forceToEnglish:String = '' ;
		
		private var MESlistChr:Object = {};
		
		
		/**this will improving the app performance after one time runing<br>
		 * it is still in beta version*/
		private var helperObject:Object = {},
			typeHirostic:Object = {};
		
		/**Numeric characters will not have absolute direction.*/
		public static var	smartTextAlign:Boolean = false ,
							floatingChars:String = "-/\\+=. ",
							notSureChars:String = "0123456789",
							lastRtlStatus:Boolean = true ;
		
		public function Unicode(numCorrection:Boolean = true)
		{
			MESlistChr['پ'] = "ﭖ ﭗﺘﭙﺘﭘ";
			MESlistChr['ض'] = "ﺽ ﺾﺘﻀﺘﺿ";
			MESlistChr['ص'] = "ﺹ ﺺﺘﺼﺘﺻ";
			MESlistChr['ث'] = "ﺙ ﺚﺘﺜﺘﺛ";
			MESlistChr['ق'] = "ﻕ ﻖﺘﻘﺘﻗ";
			MESlistChr['ف'] = "ﻑ ﻒﺘﻔﺘﻓ";
			MESlistChr['غ'] = "ﻍ ﻎﺘﻐﺘﻏ";
			MESlistChr['ع'] = "ﻉ ﻊﺘﻌﺘﻋ";
			MESlistChr['ه'] = "ه ﻪﺘﻬﺘﻫ";
			MESlistChr['خ'] = "ﺥ ﺦﺘﺨﺘﺧ";;
			MESlistChr['ح'] = "ﺡ ﺢﺘﺤﺘﺣ";
			MESlistChr['ج'] = "ﺝ ﺞﺘﺠﺘﺟ";
			MESlistChr['چ'] = "ﭺ ﭻﺘﭽﺘﭼ";
			MESlistChr['ژ'] = "ﮊ ﮋﺗﮋﺗﮊ";
			MESlistChr['ش'] = "ﺵ ﺶﺘﺸﺘﺷ";
			MESlistChr['س'] = "ﺱ ﺲﺘﺴﺘﺳ";
			MESlistChr['ی'] = "ﯼ ﯽﺘﻴﺘﯾ";
			MESlistChr['ى'] = "ﯼ ﯽﺘﻴﺘﯾ";
			MESlistChr['ي'] = "ﯼ ﯽﺘﻴﺘﯾ";
			MESlistChr['ێ'] = "ێ ﯽﺘﻴﺘﯾ";
			MESlistChr['ب'] = "ﺏ ﺐﺘﺒﺘﺑ";
			MESlistChr['ل'] = "ﻝ ﻞﺘﻠﺘﻟ";
			MESlistChr['ڵ'] = "ڵ ﻞﺘﻠﺘﻟ";
			MESlistChr['ا'] = "ﺍ ﺎﺗﺎﺗﺍ";
			MESlistChr['ت'] = "ﺕ ﺖﺘﺘﺘﺗ";
			MESlistChr['ن'] = "ﻥ ﻦﺘﻨﺘﻧ";
			MESlistChr['م'] = "ﻡ ﻢﺘﻤﺘﻣ";
			MESlistChr['ظ'] = "ﻅ ﻆﺘﻈﺘﻇ";
			MESlistChr['ط'] = "ﻁ ﻂﺘﻄﺘﻃ";
			MESlistChr['ز'] = "ﺯ ﺰﺗﺰﺗﺯ";
			MESlistChr['ر'] = "ﺭ ﺮﺗﺮﺗﺭ";
			MESlistChr['ڕ'] = "ڕ ﺮﺗﺮﺗﺭ";
			MESlistChr['ذ'] = "ﺫ ﺬﺗﺬﺗﺫ";
			MESlistChr['د'] = "ﺩ ﺪﺗﺪﺗﺩ";
			MESlistChr['ئ'] = "ء ﺊﺘﺌﺘﺋ";
			MESlistChr['و'] = "ﻭ ﻮﺗﻮﺗﻭ";
			MESlistChr['ۆ'] = "ۆ ﻮﺗﻮﺗۆ";
			MESlistChr['ک'] = "ﮎ ﮏﺘﮑﺘﮐ";
			MESlistChr['ك'] = "ﮎ ﮏﺘﮑﺘﮐ";
			MESlistChr['گ'] = "ﮒ ﮓﺘﮕﺘﮔ";
			MESlistChr['آ'] = "ﺁ ﺂﺗﺂﺗﺁ";
			MESlistChr['أ'] = "ﺃ ﺄﺗﺄﺗﺃ";
			MESlistChr['إ'] = "ﺇ ﺈﺗﺈﺗﺇ";
			MESlistChr['ؤ'] = "ﺅ ﺆﺗﺆﺗﺅ";
			MESlistChr['ۀ'] = "ﮤ ﮥ ﮥ ﻫ";
			MESlistChr['؟'] = "؟";		//manande و , be hichi nemichasbe
			MESlistChr['ـ'] = "ــــــ";	//manande ـ be hame michasbe
			MESlistChr['«'] = "»";
			MESlistChr['»'] = "«";
			MESlistChr['['] = "]";
			MESlistChr[']'] = "[";
			MESlistChr['('] = ")";
			MESlistChr[')'] = "(";
			MESlistChr['٪'] = "%";
			MESlistChr['ً'] = "ًً";		//bi khasiate va az ghabli va badish asar migire
			MESlistChr['ٌ'] = "";
			MESlistChr['ٍ'] = "ٍٍ";
			MESlistChr['َ'] = "ََ";
			MESlistChr['ْ'] = "ْْ";
			MESlistChr['ُ'] = "ُُ";
			MESlistChr['ِ'] = "ِِ";
			MESlistChr['ّ'] = "ّّ";
			MESlistChr['ة'] = "ﺓ ﺔﺘﻬﺘﻫ";
			MESlistChr[','] = ",";
			if(numCorrection){
				MESlistChr['۰'] = "0";
				MESlistChr['۱'] = "1";
				MESlistChr['۲'] = "2";
				MESlistChr['۳'] = "3";
				MESlistChr['۴'] = "4";
				MESlistChr['۵'] = "5";
				MESlistChr['۶'] = "6";
				MESlistChr['۷'] = "7";
				MESlistChr['۸'] = "8";
				MESlistChr['۹'] = "9";
				MESlistChr['٤'] = "4";
				MESlistChr['٥'] = "5";
				MESlistChr['٦'] = "6";
				MESlistChr['٧'] = "7";
				MESlistChr['٨'] = "8";
				MESlistChr['٩'] = "9";
				MESlistChr['٣'] = "3";
				MESlistChr['٢'] = "2";
				MESlistChr['١'] = "1";
				MESlistChr['٠'] = "0";
			}
			MESlistChr[','] = "،";
		}
		
		
		
		
		
		
		//92-8-30
		/**if html boolean set to true , it will act on input tex as a HTML text*/
		public function fastUnicodeOnLines(yourTextField:TextField,tex:String,detectLanguage:Boolean = true)
		{
			var myTextcash = entersCorrection(tex).split(String.fromCharCode(10));
			tex = '' ;
			var i ;
			for(i=0;i<myTextcash.length;i++){
				tex += toUnicode(myTextcash[i])+'\n';
			}
			tex = tex.substring(0,tex.length-1);
			var myText:String = (tex);
			//debug
			//yourTextField.text = myText;
			//return
			//debug end
			var parag:Array = myText.split('\n');
			var linesTest:Array = new Array();
			for(var j =0 ;j<parag.length;j++){
				yourTextField.text = parag[j] ;
				if(yourTextField.numLines==1){
					linesTest.push(parag[j]);
					continue;
				}//else V
				var lastNumLines:uint;
				var spaces;
				var cnt=0;
				while((lastNumLines = yourTextField.numLines)>1 && cnt<1000){
					cnt++;
					spaces = '' ;
					do{
						spaces+='-';
						yourTextField.text = spaces+parag[j] ;
					}while(lastNumLines == yourTextField.numLines) ;
					spaces = spaces.substring(1) ;
					yourTextField.text = spaces+parag[j] ;
					var cashedText:String = yourTextField.getLineText(lastNumLines-1);
					var lineIndex = yourTextField.getLineOffset(lastNumLines-1);
					
					var indexOfSplitters = Infinity ;
					for(i=0;i<splitters.length;i++){
						var J = cashedText.indexOf(splitters[i]) ;
						if(J!=-1){
							indexOfSplitters = Math.min(indexOfSplitters,J);
						}
					}
					if(indexOfSplitters == Infinity){
						indexOfSplitters = 0 ;
					}
					cashedText = cashedText.substring(indexOfSplitters);
					linesTest.push(cashedText);
					parag[j] = parag[j].substring(0,lineIndex+indexOfSplitters-spaces.length);
					yourTextField.text = parag[j] ;
				}
				linesTest.push(parag[j]);
			}
			//debug line
			//	yourTextField.text = cashedText ;
			//	return
			///debug line ended
			yourTextField.text = '' ;
			for(i=0;i<linesTest.length;i++){
				yourTextField.appendText(linesTest[i]+'\n');
			}
			yourTextField.text = yourTextField.text.substring(0,yourTextField.text.length-1);
		}
		
		
		
		///92-9-3  fast html unicode
		public function HTMLfastUnicodeOnLines(yourTextField:TextField,tex:String,justify:Boolean = true)
		{
			//trace("tex : "+tex);
			var myTextcash = entersCorrection(tex).split(String.fromCharCode(10));
			var parag:Array = [];
			var i ;
			var corrected:String ; 
			
			var lastWorldWrapMode:Boolean = yourTextField.wordWrap ;
			yourTextField.wordWrap = false ;
			
			yourTextField.text = ' ' ;
			var spaceWidth:Number = yourTextField.getCharBoundaries(0).width ;
			
			
					var cashedText:String;
					var xmlSpace:String ;
					
					xmlSpace = '<flashrichtext version="1"><textformat>( )</textformat></flashrichtext>';
				/**Paragraph lengh*/
				var l:uint ; 
				var lastIndex:uint ;
				/**Last splitted parag*/
				var lastSpace:int ;
				var lineW:Number ;
				var textWidth:Number ; 
				var charRect:Rectangle ;
				var lineString:String ;
				
			textWidth = yourTextField.width-7 ;
					
			for(i=0;i<myTextcash.length;i++){
				corrected = HTMLUnicode(myTextcash[i]) ;
				parag.push(corrected);
			}
			var linesTest:Array = new Array();
			for(var j =0 ;j<parag.length;j++){
				/// tamam e data haa bayad rooye textfield ha beran bad 
				yourTextField.htmlText = parag[j] ;
				cashedText = yourTextField.text ;
				/**parag become an xml string*/
				//parag[j] = yourTextField.getXMLText();
				lastIndex = l = yourTextField.text.length ;
				lineW = 0 ;
				lastSpace = -1 ;
				var step:uint = 1 ;
				var realLineSize:Number ;
				
				var lastW:Number;
				var lastCharInLineLeftX:Number = NaN ;
				var lastCharLeft:Number ;
				var charLeft:Number;
				var spaceLeft:Number;
				
				const stepPrecent:Number = 0.78 ;
				
				for( i=l-1 ; i>=0 ; i-=step )
				{
					step = 1 ;
					//lastCharRect = charRect ;
					charRect = yourTextField.getCharBoundaries(i) ;
					if(charRect==null)
					{
						continue;
					}
					else if(isNaN(lastCharInLineLeftX))
					{
						lastCharInLineLeftX = charRect.right+1 ;
					}
					lastCharLeft = charLeft ;
					charLeft = charRect.left ;
					lastW = lineW ;
					lineW = lastCharInLineLeftX-charLeft ;
					
					//trace(lineW+' vs '+textWidth);
					
					if(lineW>textWidth)
					{
						if(lastSpace!=-1)
						{
							//trace("From "+lastSpace+" to "+lastIndex);
							lineString = yourTextField.getXMLText(lastSpace+1,lastIndex);
							step = Math.ceil((lastIndex-lastSpace)*stepPrecent);
							/**change the lineW from the deltaW here to make stepps accesible*/
							lastIndex = lastSpace ;
							i = lastSpace;
							realLineSize = lastCharInLineLeftX-spaceLeft ;
							lastCharInLineLeftX = spaceLeft ;
						}
						else
						{
							//trace("From i "+(i+1)+" to "+lastIndex);
							lineString = yourTextField.getXMLText(i+1,lastIndex);
							step = Math.ceil((lastIndex-i+1)*stepPrecent);
							lastIndex = i ;
							i++;
							realLineSize = lastCharInLineLeftX-lastCharLeft ;
							lastCharInLineLeftX = lastCharLeft ;
						}
						//trace("realLineSize : "+realLineSize);
						if(justify)
						{
							//trace("Justif");
							//trace("textWidth : "+textWidth);
							//trace("realLineSize : "+realLineSize);
							//trace("(textWidth-realLineSize) : "+(textWidth-realLineSize));
							//trace("spaceWidth : "+spaceWidth);
							//trace("Math.floor((textWidth-realLineSize)/spaceWidth) : "+Math.floor((textWidth-realLineSize)/spaceWidth));
							lineString = insertSpaceInXML(lineString,Math.floor((textWidth-realLineSize)/spaceWidth));
						}
						linesTest.push(lineString);
						lastSpace = -1 ;
						lineW=0;
					}
					else if( cashedText.charAt(i) == ' ' )
					{
						lastSpace = i ;
						spaceLeft = charLeft ;
					}
				}
				//trace("Generate line to : "+lastIndex);
				//trace("Generate line to : "+lastIndex);
				linesTest.push(yourTextField.getXMLText(0,lastIndex));
				
				
				if(linesTest.length==1){
					//linesTest.push(parag[j]);
					continue;
				}//else V
			}
			//yourTextField.wordWrap = lastWorldWrapMode ;
			var enterXML:String = '<flashrichtext version="1"><textformat>(\n)</textformat></flashrichtext>' ;//yourTextField.getXMLText();
			yourTextField.text = '';
			l = linesTest.length ;
			for(i=0;i<linesTest.length;i++){
				//trace("linesTest["+i+"] : "+linesTest[i]);
				yourTextField.insertXMLText(yourTextField.length,yourTextField.length,linesTest[i]);
				if(i!=l-1)
				{
					yourTextField.insertXMLText(yourTextField.length,yourTextField.length,enterXML);
				}
			}
			//trace("insertXML time : "+(getTimer()-tim));
			//yourTextField.text = yourTextField.text.substring(0,yourTextField.text.length-1);
		}
		
		
		/**Inserts spaces on the text field*/
		private function insertSpaceInXML(xmlText:String,numSpaces:int=0,removeExtraSpaces:Boolean=true):String
		{
			numSpaces = Math.max(0,numSpaces);
			//trace("Start from : "+xmlText);
			//trace("Required spaces are : "+numSpaces);
			var purString:String = xmlText.substring(xmlText.indexOf('>(')+2,xmlText.lastIndexOf(')<'));
			if(false)//remove extra spaces
			{
				var removedSpaces:uint = purString.length ;
				purString = purString.replace(/^[\s]+/gi,'');
				purString = purString.replace(/[\s]+$/gi,'');
				removedSpaces -= purString.length ;
				//trace("removedSpaces : "+removedSpaces);
				numSpaces += removedSpaces;
			}
			//trace("purString : "+purString);
			
			var splitedWorld:Array = purString.split(' ');
			//trace("Insert "+numSpaces+" spaces")
			if(splitedWorld.length>1)
			{
				for(var i = 0 ; i<numSpaces ; i++)
				{
					var selectedWorld:uint = randGen(i,splitedWorld.length-1);
					splitedWorld[selectedWorld] = splitedWorld[selectedWorld]+' ';
				}
				purString = splitedWorld.join(' ');
			}
			//trace("purString : > "+purString);
			
			//var regexp:RegExp = /(>[\(])([^\)]+)/gi;
			//xmlText = str.replace(regexp,'$1'+purString)
			xmlText = xmlText.substring(0,xmlText.indexOf('>(')+2)+purString+xmlText.substring(xmlText.lastIndexOf(')<'));
			return xmlText ;
		}
		
		private function randGen(seed:uint,length:uint):uint
		{
			return Math.floor(length*0.9*seed)%length;//Math.floor((length-1)*Math.random()) ; 
		}
		
		
		
		
		/**style 0 mamooli , 1 aval chasban , 2 dovom chasban , 3 do var chasban*/
		public function toUnicode(ch,style=0){
			if(ch=='')
			{
				return '' ;
			}
			lastRtlStatus = true ;
			ch = farsiCorrection(ch);
			var matn = "";
			var v0:int,v1:int,v2:int;
			var numString='';
			var parantez;
			var chC1,chC2;
			var stringLenght:uint = ch.length ;
			
			if(ch=='')
			{
				return ch;
			}
			
			
			
			for(var i=0;i<ch.length;i++)
			{
				if(MESisEnglish(ch.charAt(i),ch,i,stringLenght))
				{
					parantez = ch.charAt(i)
					if(parantez==')' || parantez=='(')
					{
						chC1 = ch.charAt(i-1);
						chC2 = ch.charAt(i+1);
						//trace(chC1+' and '+chC2+"(charCod)"+chC2.charCodeAt(0)+' for '+parantez)
						if(chC1==' '||chC1==''){
							chC1=0
						}else if(MESisEnglish(chC1)){
							chC1=1
						}else{
							chC1=-1
						}
						if(chC2==' '||chC2==''){
							chC2=0
						}else if(MESisEnglish(chC2)){
							chC2=1
						}else{
							chC2=-1
						}
						//trace(chC1+' and '+chC2+' for '+parantez)
						if(chC1!=1&&chC2!=1){
							parantez = (parantez==')')?'(':')';
							//ch = ch.substring(0,i)+parantez+ch.substring(i+1)
						}
					}
					numString+=parantez;
					continue;
				}
				else
				{
					matn = MESbekesh(numString)+matn;
					numString=''
				}
				
				v1 = MESfindeType(ch.charAt(i));
				//trace("*v1 ; "+v1+' for '+ch.charAt(i));
				var j=1;
				do
				{
					v0 = MESfindeType(ch.charAt(i-j));
					j++
				}while(v0==4/*'-'*/);
				j=1;
				do
				{
					v2 = MESfindeType(ch.charAt(i+j));
					j++
				}while(v2==4/*'-'*/);
				
				if(i==0)
				{
					if(style==1||style==3){
						v0 = 3;//"11"
					}
				}
				if(i==ch.length-1)
				{
					if(style==2||style==3){
						v2 = 3;//"11"
					}			
				}
				//trace("* Char v1 is : "+v1);
				if(v1==4){
					v1 = (v0 & 1)+(v2 & 2);//v0.charAt(1)+v2.charAt(0);
				}else{
					//								(((v2 & 2) & (v1 & 1))<<1)+								(v1&2)&(v0&1)
					v1 = (((v2&1)<<1)&(v1&2))+((v1&1)&((v0&2)>>1));//String(Math.min(Number(v2.charAt(1)),Number(v1.charAt(0))))+''+String(Math.min(Number(v1.charAt(1)),Number(v0.charAt(0))))
				}
				//trace("* Final char v1 is : "+v1);
				//trace("Add "+ch.charAt(i)+" to the matn?? will be : "+MESbekesh(ch.charAt(i),v1));
				matn = MESbekesh(ch.charAt(i),v1)+matn;
				//trace("matn : "+matn);
			}
			matn =MESbekesh(numString)+matn;
			matn = UnicodeLaCorrector.laCorrection(matn);
			return matn;
		}
		
		//////////////////////////////////////////////////tools
		public function numCorrection(str:String):String
		{
			var I = String('۰').charCodeAt(0);
			for(var i=I ; i<I+10 ; i++){
				str = str.split(String.fromCharCode(i)).join(String(i-I));
			}
			I = String('٠').charCodeAt(0);
			for(i=I ; i<I+10 ; i++){
				str = str.split(String.fromCharCode(i)).join(String(i-I));
			}
			return str ;
		}
		
		
		public function NumberChange(str:String,zero:String='۰')
		{
			var I = String('۰').charCodeAt(0);
			for(var i=0 ; i<10 ; i++){
				str = str.split(String(i)).join(String.fromCharCode(i+I));
			}
			return str;
		}
		
		public function entersCorrection(str:String):String
		{
			return String(str).split(String.fromCharCode(13)).join(String.fromCharCode(10)).split(String.fromCharCode(10)+String.fromCharCode(10)).join(String.fromCharCode(10));
		}
		
		
		///**returns list of selected char on paragraph*/
		private function getChars(parag:String,char:String=' '):Array
		{
			var founded:Array = new Array();
			var f:int = 0 ;
			var cnt:int = -1 ;
			while((f=parag.indexOf(char,f+1))!=-1 && cnt<100)
			{
				cnt++;
				founded.push(f);
			}
			return founded; 
			
		}
		
		public function farsiCorrection(str:String)
		{
			return str.split('آ').join('آ').split('ی').join('ي').split('‌').join(' ').split('‏').join(' ').split('¬').join(' ');
		}
		
		
		
		
		
		
		private function MESisEnglish(megh:String,copleteString:String=null,charIndex:uint=0,stringLength:uint=0,lookingForard:Boolean=false){
			var test:*;
			//trace("lookingForard : "+lookingForard);
			if(smartTextAlign && copleteString!=null)
			{
				//trace("Controll on floating chars..."+megh);
				if(floatingChars.indexOf(megh)!=-1)
				{
					//trace("Megh is floating char, so the next char for : "+megh)
					for(var i = charIndex+1 ; i<stringLength ; i++)
					{
						test = MESisEnglish(copleteString.charAt(i),copleteString,i,stringLength,true);
						//trace(".... is English??? "+test);
						if(!lookingForard)
						{
							lastRtlStatus = test ;
						}
						return test ;
					}
					return lastRtlStatus ;
				}
				else if(lookingForard && notSureChars.indexOf(megh)!=-1)
				{
					//trace("Megh is floating char, so the next char for : "+megh+" on looking forward and isEnglish is : "+lastRtlStatus)
					return lastRtlStatus ;
				}
			}
			test = helperObject[megh];
			if(test!=undefined)
			{
				if(!lookingForard && notSureChars.indexOf(megh)==-1)
				{
					lastRtlStatus = test ;
				}
				//trace("Megh status : "+megh+" is English??"+test);
				return test ;
			}
			if((forceToEnglish.indexOf(megh)!=-1 || (MESlistChr[megh]==undefined && megh.charCodeAt(0)<1417 && estesna.indexOf(megh)==-1 ) || ( adad.indexOf(megh)!=-1))){
				helperObject[megh] = true ;
				if(!lookingForard && notSureChars.indexOf(megh)==-1)
				{
					lastRtlStatus = true ;
				}
				//trace("Megh status : "+megh+" is English");
				return true
			}else{
				helperObject[megh] = false;
				if(!lookingForard && notSureChars.indexOf(megh)==-1)
				{
					lastRtlStatus = false ;
				}
				//trace("Megh status : "+megh+" is Persian");
				return false;
			}
		}
		
		/**In binary format : 4:100 is Seda, 0:00 */
		private function MESfindeType(ch):int
		{
			
			var cash = typeHirostic[ch];
			if(cash!=undefined)
			{
				return cash ;
			}
			
			var typ:int = 00;//"00";
			var founded:String = MESlistChr[ch] as String ;
			if(founded!=null){
				if(founded.length==6&&founded.charAt(2)==founded.charAt(1)){
					typ = 3;//'11';//ﻭ ﻮﺗﻮﺗﻭ
				}else if(founded.length==1){
					typ = 0;//'00';
				}else if(founded.length==2){
					typ = 4;//'-';	//baraye Seda ha ًٌَُ
				}else if(founded.charAt(4)==founded.charAt(2)){
					typ = 1;//"01";
				}else if(founded.charAt(4)==founded.charAt(6)){
					typ = 2;//"10";
				}else if(founded.charAt(0)==founded.charAt(4)){
					typ = 0;//"00";
				}else{
					typ = 3;//"11";
				}
			}
			//trace("Final type is  "+typ);
			typeHirostic[ch] = typ ;
			return typ
		}
		
		
		private function MESbekesh(character,no:int = -1){
			//character=character.split('ي').join('ی').split('آ').join('آ');
			//trace("Bekesh : "+character+' no : '+no);
			var STR:String = MESlistChr[character] as String ;
			
			if(no==-1){
				if(STR != null && STR.length==1){
					return STR;
				}else{
					return character;
				}
			}
			var at=-1;
			switch(no){
				case(1/*"01"*/):{
					at=2
					break;
				}
				case(2/*"10"*/):{
					at=6
					break;
				}
				case(0/*"00"*/):{
					at=0
					break;
				}
				case(3/*"11"*/):{
					at=4
					break;
				}
			}
			if(STR!=null){
				//trace("Str is not null and at is : "+at);
				//Below line had to stay here, because of the 2 char Seda characters.
					at = Math.min(String(STR).length-1,at);
				var cash = STR.charAt(at) ;
				if(cash == undefined)
				{
					cash = STR.charAt(STR.length-1) ;
				}
				return(cash)
			}else{
				return character;
			}
		}
		
		
		public function getPorp(htm:String,color:Boolean=false,size:Boolean=false,align:Boolean=false,lending:Boolean=false){
			var cash:String = ''
			if(color){
				cash = "COLOR=\"";
			}else if(size){
				cash = "SIZE=\"";
			}else if(align){
				cash = "ALIGN=\"";
			}else if(lending){
				cash = "LEADING=\"";
			}else{
				return
			}
			htm = htm.toUpperCase()
			var I=htm.indexOf(cash)+cash.length;
			var htm2 = htm.substring(I)
			var num = (htm2.substring(0,htm2.indexOf('\"')))
			return num
		}
		
		
		
		public function setPorp(htm,variable,color=false,size=false,align=false,lending=false){
			var cash:String = ''
			var htm2=''
			if(color){
				cash = "COLOR=\"";
			}else if(size){
				cash = "SIZE=\"";
			}else if(align){
				cash = "ALIGN=\"";
			}else if(lending){
				cash = "LEADING=\"";
			}else{
				return
			}
			while(htm.indexOf(cash)!=-1){
				htm2 = htm2 + htm.substring(0,htm.indexOf(cash)+cash.length)
				htm = htm.substring(htm.indexOf(cash)+cash.length)
				htm = htm.substring(htm.indexOf('\"'))
			}
			
			htm2 = htm2 + htm
			
			htm = htm2.split(cash+'\"').join(cash+variable+'\"')
			
			return htm
		}
		
		
		/**This function will make inserted html understandable for UnicodeConvertor*/
		public static function htmlCorrect(htm:String,linkColor:int=-1,replacePwithEnter:Boolean=false,fontSizeIs:Number=20):String
		{
			var StrongFontSize:Number = fontSizeIs+5 ;
			
			var fontSize_xxSmall:Number = Math.max(1,fontSizeIs-10);
			var fontSize_xSmall:Number = Math.max(1,fontSizeIs-5);
			var fontSize_Small:Number = Math.max(1,fontSizeIs-2);
			//No need to set medum font size
			//var fontSize_medium:Number = fontSizeIs;
			var fontSize_Larg:Number = fontSizeIs+2;
			var fontSize_xLarg:Number = fontSizeIs+5;
			var fontSize_xxLarg:Number = fontSizeIs+10;
			
			var colorOpen:String= '';
			var colorClose:String = '';
			if(linkColor!=-1)
			{
				colorOpen = '<FONT COLOR="#'+linkColor.toString(16)+'">';
				colorClose = '</FONT>';
			}
			var divDeleter:RegExp = /<\/?div[^>]*>/gi;
			var brReplacer:RegExp = /<\/?br[^>]*>/gi;
			var str:String = htm.replace(divDeleter,'');//<font color="'+linkColors+'"><a href="tel:$&">$&</a></font>
			str = str.replace(brReplacer,'\n');
			str = str.split('<a').join(colorOpen+'<A')
			var linkCloser:RegExp = /<\/a[^>]*>/gi;
			str = str.replace(linkCloser,'</A>'+colorClose);
			var pTag:RegExp = /<\/?p[^>]*>/gi;
			var pColseTag:RegExp = /<\/p[^>]*>/gi;
			if(replacePwithEnter)
			{
				str = str.replace(pColseTag,'\n');
			}
			else
			{
				str = str.replace(pTag,'');
			}
			var strongReplacer:RegExp = /<strong>/gi;
			str = str.replace(strongReplacer,'<FONT SIZE="'+StrongFontSize+'">');
			var strongReplacerColser:RegExp = /<\/strong>/gi;
			str = str.replace(strongReplacerColser,'</FONT>');
			
			//<span style="color:#cc0000;">متن قرمز</span>
			var spanColorReplacer:RegExp = /<span style="color:#/gi;
			str = str.replace(spanColorReplacer,'<FONT COLOR="#');
			var spanColorReplacer2:RegExp = /;">/gi;
			str = str.replace(spanColorReplacer2,'">');
			var spanColorReplacerCloser:RegExp = /<\/span>/gi;
			str = str.replace(spanColorReplacerCloser,'</FONT>');
			
			var reg_fontSize:RegExp;
			reg_fontSize = /<span style="font-size:xx-small">/gi;
			str = str.replace(reg_fontSize,'<FONT SIZE="'+fontSize_xxSmall+'">');
			reg_fontSize = /<span style="font-size:x-small">/gi;
			str = str.replace(reg_fontSize,'<FONT SIZE="'+fontSize_xSmall+'">');
			reg_fontSize = /<span style="font-size:small">/gi;
			str = str.replace(reg_fontSize,'<FONT SIZE="'+fontSize_Small+'">');
			//No need to set mediom size
			/*reg_fontSize = /<span style="font-size:medium">/gi;
			str = str.replace(reg_fontSize,'<FONT SIZE="'+fontSizeIs+'">');*/
			reg_fontSize = /<span style="font-size:large">/gi;
			str = str.replace(reg_fontSize,'<FONT SIZE="'+fontSize_Larg+'">');
			reg_fontSize = /<span style="font-size:x-large">/gi;
			str = str.replace(reg_fontSize,'<FONT SIZE="'+fontSize_xLarg+'">');
			reg_fontSize = /<span style="font-size:xx-large">/gi;
			str = str.replace(reg_fontSize,'<FONT SIZE="'+fontSize_xxLarg+'">');
			
			var reg_left_span_corrector:RegExp = /<span[^>]*>/gi;
			str = str.replace(reg_left_span_corrector,'<FONT>');
			
			/*<p>این یک<span style="font-size:xx-small"> 8  </FONT>است.
			<p>این یک<span style="font-size:x-small"> 10  </FONT>است.
			<p>این یک<span style="font-size:small"> 12  </FONT>است.
			<p>این یک<span style="font-size:medium"> 14  </FONT>است.
			<p>این یک<span style="font-size:large"> 18  </FONT>است.
			<p>این یک<span style="font-size:x-large"> 24  </FONT>است.
			<p>این یک<span style="font-size:xx-large"> 36  </FONT>است.*/
			
			//trace(" str : "+str);
			
			return str ;
		}
		
		
		public function HTMLUnicode(tex:String){
			
			tex = htmlCorrect(tex);
			
			
			var tex2:String = '';
			/*var texC:String = '';
			var htmC1:String = '';
			var htmC2:String = '';*/
			var i:int ;
			var AnyTag:RegExp = /<[^>]*>/gi;
			//var OpenTag:RegExp = /<[^\/>][^>]*>/gi;
			//var CloseTag:RegExp = /<\/[^>]*>/gi;
			
			tex = tex;
			var cash:String = tex ;
			
			var tags:Array = [] ;
			//var levels:Array = [] ;
			var strings:Array = [] ;
			
			var tagsList:Array = tex.match(AnyTag);
			
			for(i = 0 ; i<tagsList.length ; i++)
			{
				//trace("cash : "+cash);
				var tag:String = tagsList[i] as String ;
				var tagIndex:int = cash.search(AnyTag);
				var word:String = toUnicode(cash.substr(0,tagIndex)) ;
				cash = cash.substring(tagIndex+tag.length) ;
				
				strings.push(word);
				//trace("Current tag is : "+tag);
				//trace("tags : "+tags);
				//trace("strings : "+strings);
				
				
				//levels.push(tags.length);
				if(tag.indexOf('</')!=0)
				{
					//Start tag
					tags.push(tag);
				}
				else
				{
					var close:String ;
					var open:String;
					//End tag
					if(tags.length==0)
					{
						//trace("entered HTML is wrong");
						return tex;
					}
					var str:String = '' ;
					while(strings.length>tags.length)
					{
						//trace("strings.length : "+strings.length+" VS "+tags.length);
						str=str+strings.pop();
					}
					close = tag;
					open = tags.pop();
					strings[strings.length-1] = open+str+close+strings[strings.length-1];
					//trace("Merge level : "+strings[strings.length-1]);
					
					//trace("tags : "+tags);
					//trace("strings : "+strings);
				}
			}
			strings.push(toUnicode(cash));
			for(i=0 ; i<strings.length ; i++)
			{
				tex2 = strings[i]+tex2;
			}
			
			
			
			//trace("HTMLed text is :"+tex2);
			/*while(tex.indexOf('<FONT')!=-1){
			texC = tex.substring(0,tex.indexOf('<'))
			tex2 = toUnicode(texC)+tex2;
			htmC1 = tex.substring(tex.indexOf('<FONT'),tex.indexOf('>')+1)
			tex = tex.substring(tex.indexOf('>')+1)
			texC = tex.substring(0,tex.indexOf('</FONT>'))
			tex2 = htmC1+toUnicode(texC)+"</FONT>"+tex2
			tex = tex.substring(tex.indexOf('>')+1)
			}
			while(tex.indexOf('<A')!=-1){
			texC = tex.substring(0,tex.indexOf('<'))
			tex2 = toUnicode(texC)+tex2;
			htmC1 = tex.substring(tex.indexOf('<A'),tex.indexOf('>')+1)
			tex = tex.substring(tex.indexOf('>')+1)
			texC = tex.substring(0,tex.indexOf('</A>'))
			tex2 = htmC1+toUnicode(texC)+"</A>"+tex2
			tex = tex.substring(tex.indexOf('>')+1)
			}
			tex2 = toUnicode(tex)+tex2*/
			return tex2
		}
		
		/**[[FONT COLOR="#FF0000"]]  to  FONT<br>*/
		private function TagName(fullTag:String):String
		{
			fullTag = fullTag.split('</').join('');
			var firstSpace:int = fullTag.indexOf(' ');
			var firstClose:int = fullTag.indexOf('>');
			if(firstSpace!=-1)
			{
				fullTag = fullTag.substr(0,firstSpace);
			}
			else
			{
				fullTag = fullTag.substr(0,firstClose);
			}
			return fullTag ;
		}
		
		public function justHTML(field_txt,tex:String,autoSize_F:Boolean=true){
			field_txt.text = 's'
			var cashAlign = getPorp(field_txt.htmlText,false,false,true)
			if(autoSize_F){
				field_txt.autoSize = TextFieldAutoSize.CENTER;
			}
			field_txt.htmlText = tex;
		}
		
		private function getLastSplit(tex){
			var mem = 0;
			var cash=0;
			var batel=false
			for(var i=0;i<splitters.length;i++){
				for(var j=0;j<tex.length-2;j++){
					cash = tex.charAt(j)
					if(cash=='<'){
						batel=true
					}else if(cash=='>'){
						batel=false
					}
					if(batel){
						continue
					}
					if(cash == splitters[i]){
						mem = Math.max(mem,j)
					}
				}
			}
			return mem
		}
		
		
		private function justifyUnicode(field_txt,matn){
			field_txt.text = '.';
			var lastH = field_txt.textHeight;
			var lastMatn = matn;
			var lastMatn2 = matn;
			var lastI = new Array(matn,0)
			var contor=1
			while(field_txt.textHeight<=lastH){
				contor++
					lastMatn2 = lastMatn
				lastMatn = lastI[0]
				lastI = putJUnicode(lastMatn,lastI[1])
				if(lastI[0]==false){
					break
				}
				field_txt.htmlText = HTMLUnicode(lastI[0])
				if(contor>40){
					break
				}
			}
			return lastMatn2
		}
		
		
		private function putJUnicode(matn,I){
			var batel=false
			var newMatn=matn
			var cash;
			var myI
			var shans:Array = new Array()
			for(var i=0;i<matn.length;i++){
				myI = (i+I)%matn.length
				cash = matn.charAt(myI)
				if(cash=='<'){
					batel=true
				}else if(cash=='>'){
					batel=false
				}
				if(batel){
					continue
				}
				//if(MESfindeType(matn.charAt(myI)).charAt(0)=='1'&&MESfindeType(matn.charAt(myI+1)).charAt(1)=='1'&&(matn.charAt(myI+1)!='ـ')){
				if((MESfindeType(matn.charAt(myI)) & 2 == 2) && (MESfindeType(matn.charAt(myI+1)) & 1 == 1 ) && (matn.charAt(myI+1) != 'ـ')){
					shans.push(myI+1)
				}
			}
			if(shans.length==0){
				return new Array(false,false)
			}else{
				var rand = Math.floor(Math.random()*shans.length)
				newMatn = matn.substring(0,shans[rand])+'ـ'+matn.substring(shans[rand])
				return new Array(newMatn,0)
			}
		}
		
		
		
		
		private function htmlSplit(tex,I){
			var matn1='';
			var matn2='';
			
			matn1 = tex.substring(0,I);
			matn2 = tex.substring(I);
			
			if(matn2.indexOf('>')==-1){
				//trace('addi')
			}else{
				if(matn2.indexOf('<')==-1){
					matn2 = matn1.substring(matn1.lastIndexOf('<'))+matn2;
					matn1 = matn1.substring(0,matn1.lastIndexOf('<'));
				}else{
					if(matn2.indexOf('<')<matn2.indexOf('>')){
						//trace('con1')
						if(matn2.indexOf('<')==matn2.indexOf('</FONT')){
							//trace('con2')
							matn2 = matn1.substring(matn1.lastIndexOf('<'),matn1.lastIndexOf('>')+1)+matn2;
							matn1 = matn1+'</FONT>'
						}
					}else{
						if(matn1.lastIndexOf('<')==matn1.lastIndexOf('</')||matn2.indexOf('>')==matn2.indexOf('T>')+1){
							matn2 = matn2.substring(matn2.indexOf('>')+1)
							matn1 = matn1.substring(0,matn1.lastIndexOf('<'));
							matn1 = matn1+'</FONT>'
						}else{
							matn2 = matn1.substring(matn1.lastIndexOf('<'))+matn2;
							matn1 = matn1.substring(0,matn1.lastIndexOf('<'));
						}
					}
				}
			}
			return new Array(matn1,matn2)
		}
		
		
		/////////////////////////////////////////////////////////////////////removed
		public function UnicodeSet(field_txt,tex:String,justifyFlag:Boolean=false,autoSize_F:Boolean=true,shoHTML_f:Boolean=false,myID:String='',ezafe:String='',ezafe2:String=''){
			var ZAKHIRE = tex
			if(tex==''){
				field_txt.text = ''
				return
			}
			field_txt.text = 's'
			var cashAlign = getPorp(field_txt.htmlText,false,false,true)
			if(autoSize_F){
				field_txt.autoSize = TextFieldAutoSize.CENTER;
			}
			//trace('**'+cashAlign)
			field_txt.multiline = true
			var lines:String = '';
			var cash:Array;
			var lineI = 0;
			field_txt.text = tex.charAt(0)
			var lastH = field_txt.textHeight;
			var I=0
			var split=0
			for(I=0;I<=tex.length;I++){
				cash = htmlSplit(tex,I)
				field_txt.htmlText = HTMLUnicode(cash[0]);
				if(field_txt.textHeight>lastH){
					//cash = htmlSplit(tex,I-5)
					split = getLastSplit(cash[0])
					if(split==0){
						split=I-1
					}
					cash = htmlSplit(tex,split)
					I=-1
					tex = cash[1]
					if(justifyFlag){
						//trace('justify it');
						cash[0] = justifyUnicode(field_txt,cash[0])
					}
					lines=lines+"<P ALIGN=\"CENTER\">"+HTMLUnicode(cash[0])+"</P>"
				}
			}
			lines=lines+"<P ALIGN=\"CENTER\">"+HTMLUnicode(tex)+"</P>"
			lines = setPorp(lines,cashAlign,false,false,true)
			if(shoHTML_f){
				if(ezafe!=''&&ezafe!='undefined'&&ezafe!='null'){
					ezafe = "','"+ezafe
				}else{
					ezafe = '';
				}
				if(ezafe2!=''){
					ezafe2 = "','"+ezafe2
				}else{
					ezafe2 = '';
				}
				//trace(myID+"new Array(\'"+ZAKHIRE+ezafe+"','"+lines+ezafe2+"')")
			}
			field_txt.htmlText = lines;
		}
	}
}