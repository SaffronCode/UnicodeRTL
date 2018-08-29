// *************************
// * COPYRIGHT
// * DEVELOPER: MTEAM ( info@mteamapp.com )
// * ALL RIGHTS RESERVED FOR MTEAM
// * YOU CAN'T USE THIS CODE IN ANY OTHER SOFTWARE FOR ANY PURPOSE
// * YOU CAN'T SHARE THIS CODE
// *************************

//these lines cause of crashes on flash bulder
package com.mteamapp {
	import flash.text.*;
	import flash.utils.getTimer;
	

	internal class UnicodeLaCorrector {
		
		public static function laCorrection(str:String):String
		{
			return str.split('ﺎﻟ').join('ﻻ').split(String.fromCharCode(160)).join('').split('ﺄﻠ').join('ﻸ').split('ﺈﻠ').join('ﻺ').split('ﺂﻠ').join('ﻶ').split('ﺎﻠ').join('ﻼ').split('ﺄﻟ').join('ﻷ').split('ﺂﻟ').join('ﻵ').split('ﺈﻟ').join('ﻹ');
		}
	}
	
}
