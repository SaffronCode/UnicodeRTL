package
{
	import com.mteamapp.UnicodeStatic;
	
	import flash.display.Sprite;
	import flash.text.TextField;
	
	public class UnicodeMTeam_smaple extends Sprite
	{
		public function UnicodeMTeam_smaple()
		{
			super();
			
			var textField:TextField = new TextField();
				textField.textColor = 0xff0000;
				textField.width = 550 ;
				textField.height = 200 ;
				textField.y = 200 ;
			
			textField.text = UnicodeStatic.convert("هلو ورد!");
		}
	}
}