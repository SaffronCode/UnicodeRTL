// *************************
// * COPYRIGHT
// * DEVELOPER: MTEAM ( info@mteamapp.com )
// * ALL RIGHTS RESERVED FOR MTEAM
// * YOU CAN'T USE THIS CODE IN ANY OTHER SOFTWARE FOR ANY PURPOSE
// * YOU CAN'T SHARE THIS CODE
// *************************

package com.mteamapp
{
	import flash.geom.Point;

	public class StringFunctions
	{
		private static var 	arabicChars:String = 'ًٌٍَُِّْٰٜٕٖۣٞٝٓٔٗ٘ٙٚٛؕؔؓؐؑؒۖۘۗۙۚۛۜۢ‌ـ?',
							arabicSames:Array = ['ؤو','11','22','33','44','55','66','77','88','99','00',
							'0٠۰','1١۱','9٩۹','8٨۸','7٧۷','6٦۶','5٥۵','4٤۴','3٣۳','2٢۲'
							,'ييیىئ','اإأآ?','کك'],
							arabicWord:String = 'والي';
		
		
		/**returns true if there was to many arabic signes there<br>
		 * if the number of arabic sign was less than 1/4 , this function detect that the str is not arabic*/
		public static function isArabic(str:String)
		{
			var reg:RegExp = new RegExp('['+arabicChars+']','g');
			var founced:uint = 0 ;
			var L:uint = Math.min(50,str.length) ;
			
			var searchResult:Object = reg.exec(str);
			while(searchResult!=null && reg.lastIndex<L)
			{
				founced++ ;
				searchResult = reg.exec(str);
			}
			if(founced>L/4)
			{
				return true ;
			}
			else
			{
				return false ;
			}
		}
		
		/**Returns true if currenct string has at least one persian script.*/
		public static function isPersian(str:String,stringLength:Number=NaN):Boolean
		{
			var max:uint;
			if(isNaN(stringLength))
			{
				max = Math.min(str.length , 200);
			}
			else
			{
				max = Math.min(str.length , stringLength) ;
			}
			for(var i = 0 ; i<max ; i++)
			{
				if(str.charCodeAt(i)>1000)
				{
					//trace('This is arabic : '+str.charAt(i)+' at '+i+' the char code is : '+str.charCodeAt(i));
					return true ;
				}
			}
			return false;
		}
		
		/**it will returns list of points that shows index and ofsset of each word founded*/
		public static function search(str:String,searchedWord:String,fineAll:Boolean = true,arabic:Boolean=false, arabic2:Boolean=false):Vector.<Point>
		{
			var founded:Vector.<Point> = new Vector.<Point>();
			if(str == '' || str == ' ')
			{
				return founded ;
			}
			if(arabic)
			{
				//arabic search has problems
				var regularEx:String = '' ;
				var L:int = searchedWord.length ;
				var arabChars:String = arabicChars ;
				if(arabic2)
				{
					arabChars+= arabicWord ;
				}
				for(var i = 0 ; i<L ; i++)
				{
					var char:String = searchedWord.charAt(i); 
					for(var j = 0 ; j<arabicSames.length ; j++)
					{
						if(arabicSames[j].indexOf(char)!=-1)
						{
							char = '['+arabicSames[j]+']' ;
							break ;
						}
					}
					regularEx += char;
					if(i<L-1)
					{
						regularEx+='['+arabChars+']*';
					}
				}
				var reg:RegExp = new RegExp(regularEx,'g');
				var searchResult:Object = reg.exec(str);
				while(searchResult!=null)
				{
					founded.push(new Point(searchResult.index,reg.lastIndex));
					searchResult = reg.exec(str);
					if(!fineAll)
					{
						break ;
					}
				}
			}
			else
			{
				var f:int=-1 ;
				while((f=str.indexOf(searchedWord,f+1))!=-1)
				{
					founded.push(new Point(f,f+searchedWord.length));
					if(!fineAll)
					{
						break ;
					}
				}
			}
			
			return founded ;
		}
		
		
	//////////////////////////////////////////////////link generators↓
		
		/**generate link on the current string and it will returns html text*/
		public static function generateLinks(str:String,linkColors:int=-1):String
		{
			var colorTagStart:String = '';
			var colorTagEnd:String = '';
			if(linkColors!=-1)
			{
				colorTagStart = '<font color="#'+linkColors.toString(16)+'">';
				colorTagEnd = '</font>';
			}
			var str:String = str;
			//debug telephone
			if(true)
			{
				//trace('phone enabled');
				var regNumberDetection:RegExp = /([\n\r\s\t,^])([\d-]{8,})/gi;//([\n\r\s\t,])([\d-]{8,})([\t\n\r\s,])
				trace("Find the phone : "+str);
				str = str.replace(regNumberDetection,'$1'+colorTagStart+'<a href="tel:$2">$2</a>'+colorTagEnd);//
			}
			var regURLDetect:RegExp = /(www|http:\/\/)[^ \n\r]*/gi ;///(www\. | http)\S*\s/gi;
			str = str.replace(regURLDetect,colorTagStart+'<a href="http://$&">$&</a>'+colorTagEnd);
			//var regURLDetect2:RegExp = /http\S*\s/gi;
			//str = str.replace(regURLDetect2,'<font color="'+linkColors+'"><a href="$&">$&</a></font>');
			var regDetectEmail:RegExp = /[a-z\.\-1234567890_]*\@[a-z\.\-_]*/gi ;
			str = str.replace(regDetectEmail,colorTagStart+'<a href="mailto:$&">$&</a>'+colorTagEnd);
			
			var doubleHTTP:RegExp = /http:\/\/[ ]*http:\/\//gi;
			str = str.replace(doubleHTTP,'http://');
			
			return str ;
		}
		
		/***Clear in line "s in the json values:<br>
		 * {"data":"my name is "ali"."}<br>
		 * {"data":"my name is \"ali\"."}*/
		public static function clearDoubleQuartmarksOnJSON(str:String):String
		{
			//var str:String = '[{"IdNews":"585","DateNews":"1394\\/8\\/20 ","SubjectNews":"fdjsakl fjk\\"adsl jfkldsa ","ImageNews":"http:\\/\\/www.melkban24.ir\\/Files\\/News585.jpg"},{"IdNews":"584","DateNews":"1394\\/8\\/20 ","SubjectNews":"fsjdkl klfsad jklfsjadk ljfklds","ImageNews":"http:\\/\\/www.melkban24.ir\\/Files\\/News584.jpg"},{"IdNews":"583","DateNews":"1394\\/8\\/19 ","SubjectNews":"fdjks jkfjd skfkjdkslfj jkfd f","ImageNews":"http:\\/\\/www.melkban24.ir\\/Files\\/News583.jpg"},{"IdNews":"582","DateNews":"1394\\/8\\/19 ","SubjectNews":"fdjfk kfjd lfdk lfkdsjkfkdfkls jkf","ImageNews":"http:\\/\\/www.melkban24.ir\\/Files\\/News582.jpg"},{"IdNews":"581","DateNews":"1394\\/8\\/18 ","SubjectNews":"مjkf jkfdjsk jkfldjkfld kfdjkfdjk","ImageNews":"http:\\/\\/www.melkban24.ir\\/Files\\/News581.jpg"},{"IdNews":"580","DateNews":"1394\\/8\\/18 ","SubjectNews":"fksjdf kfjds klfjkdlfkdsj f sf sfd","ImageNews":"http:\\/\\/www.melkban24.ir\\/Files\\/News580.jpg"},{"IdNews":"579","DateNews":"1394\\/8\\/18 ","SubjectNews":"fdskl jfsdkj kfdsjk jkflfdks","ImageNews":"http:\\/\\/www.melkban24.ir\\/Files\\/News579.jpg"},{"IdNews":"578","DateNews":"1394\\/8\\/18 ","SubjectNews":"fdsa fad" sfdsa"fdfsaf","ImageNews":"http:\\/\\/www.melkban24.ir\\/Files\\/News578.jpg"},{"IdNews":"577","DateNews":"1394\\/8\\/17 ","SubjectNews":"jisfad jkfsdjakj lfasjfdjfsdj kfsdjkl jkf","ImageNews":"http:\\/\\/www.melkban24.ir\\/Files\\/News577.jpg"},{"IdNews":"576","DateNews":"1394\\/8\\/17 ","SubjectNews":"fdf afd fsadfdsaf afs df asfsda fsda ","ImageNews":"http:\\/\\/www.melkban24.ir\\/Files\\/News576.jpg"}]';
			var regexp:RegExp = /(":"((?!"\},\{)(?!",")(?!"\}\])(?!"\})(.))*[^\\])"((?!\},\{)(?!,")(?!\}\])(?!\}))/gi
			var lastStr:String ;
			do
			{
				lastStr = str ;
				str = str.replace(regexp,'$1\\"')
			}while(str!=lastStr)
			return str ;
		}
	
		
		
	///////////////////New Funciton on String funciont
		public static function utfToUnicode(utfString:String):String
		{
			// TODO Auto Generated method stub
			var reg:RegExp = /u[0-9a-f][0-9a-f][0-9a-f][0-9a-f]/gi;
			
			var searchResult:Object = reg.exec(utfString);
			var correctedString:String = '' ;
			var index:uint = 0 ;
			var lastIndex:uint = Infinity ;
			var currentIndex:uint ;
			while(searchResult!=null)
			{
				lastIndex = reg.lastIndex ;
				currentIndex = searchResult.index;
				
				correctedString += utfString.substring(index,currentIndex)+correctUTF(utfString.substring(currentIndex,lastIndex));
				index = lastIndex ;
				searchResult = reg.exec(utfString);
			}
			correctedString+=utfString.substring(index);
			
			return correctedString ;
		}
		
		private static function correctUTF(utfWord:String):String
		{
			// TODO Auto Generated method stub
			var num:String = utfWord.substring(1) ;
			return String.fromCharCode(parseInt(num,16)) ;
		}
		
	/////////////////////////////////////////////////Sumerize texts
		/**This function will shorten the senteces by the len vlaue*/
		public static function short(str:String,len:uint=10,removeEntersWith:String=''):String
		{
			if(str==null)
			{
				return '' ;
			}
			if(removeEntersWith!='')
			{
				str = str.split('\r').join('\n').split('\n\n').join('\n').split('\n').join(removeEntersWith);
			}
			var dotString:String = '...';
			var spaceIndex:int = str.indexOf(' ',len-dotString.length);
			if(spaceIndex == -1)
			{
				if(str.length>len)
				{
					return str.substring(0,len-dotString.length)+dotString;
				}
				else
				{
					return str ;
				}
			}
			else
			{
				if(spaceIndex>=str.length)
				{
					//remove donts from the end
					dotString='';
				}
				return str.substr(0,spaceIndex)+dotString;
			}
		}
		
		
		
	////////////////////////////////////////////////
		
		/**This function will make inserted html understandable for UnicodeConvertor*/
		public static function htmlCorrect(htm:String,linkColor:int=-1,replacePwithEnter:Boolean=false,fontSizeIs:Number=20):String
		{
			return Unicode.htmlCorrect(htm,linkColor,replacePwithEnter,fontSizeIs)
			//return Unicode.htmlCorrect(htm,linkColor);
			//I had to repeat this function here to prevent error on old projects
			/*var colorOpen:String= '';
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
			str = str.replace(pTag,'');
			
			//trace(" str : "+str);
			
			return str ;*/
		}
		
	///////////////////////////////////////////////////////Time functions
		/**return the time from seconds to string 10:54*/
		public static function timeInString(seconds:Number):String
		{
			seconds = Math.ceil(seconds);
			var min:Number = Math.floor(seconds/60);
			seconds = seconds%60;
			var hour:Number = Math.floor(min/60);
			min = min%60;
			if(hour>0)
			{
				return numToString(hour)+':'+numToString(min)+':'+numToString(seconds);
			}
			else
			{
				return numToString(min)+':'+numToString(seconds);
			}
		}
		
		/**1 > 001*/
		public static function numToString(num:*,numberLenght:uint=2)
		{
			num = String(num);
			while(num.length<numberLenght)
			{
				num = '0'+num;
			}
			return num;
		}
		
		/**Remove all html tags from the text*/
		public static function removeHTML(ReferText:String):String
		{
			// TODO Auto Generated method stub
			if(ReferText==null)
			{
				return '' ;
			}
			var htmlDeleter:RegExp = /<\/?[^>]*>/gi;
			return ReferText.replace(htmlDeleter,'');
		}
		
		
		/**Returns -1 if string1 < str2, 1 if str1>str2*/
		public static function compairFarsiString(str1:String,str2:String):int
		{
			if(str1 == null)
			{
				str1 = '';
			}
			if(str2 == null)
			{
				str2 = '' ;
			}
			
			if(str1=='' && str2=='')
			{
				return 0 ;
			}
			
			if(str1=='')
			{
				return -1 ;
			}
			if(str2=='')
			{
				return 1 ;
			}
			
			var alephba:String = "ابپتثجچهخدذرزژسشصضطظعغفقكگلمنوهیي";
			var farsiStr1:String = UnicodeStatic.KaafYe(str1);
			var farsiStr2:String = UnicodeStatic.KaafYe(str2);
			
			var index1:int = alephba.indexOf(farsiStr1.charAt(0));
			var index2:int = alephba.indexOf(farsiStr2.charAt(0));
			
			if(index1==-1 || index2 ==-1)
			{
				if(str1<str2)
				{
					return -1 ;
				}
				else if(str1>str2)
				{
					return 1 ;
				}
				else
				{
					return 0 ;
				}
			}
			
			if(index1<index2)
			{
				return -1 ;
			}
			else if(index1>index2)
			{
				return 1 ;
			}
			else
			{
				return 0 ;
			}
		}
	}
}