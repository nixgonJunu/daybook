package nixgon.daybook;

import java.util.logging.Logger;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

@Controller
public class DaybookController {

	private static final Logger log = Logger.getLogger( DaybookController.class.getName() );

	@RequestMapping("/login")
	public String loginUser() {
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();

		if ( user != null ) {
			return "redirect:day_page";
		} else {
			return "redirect:" + userService.createLoginURL( "../day_page" );
		}
	}

	@RequestMapping(value = "/day_page", method = RequestMethod.GET)
	public String getDaybook( ModelMap model ) {
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
		String nickname = null;

		if ( user != null ) {
			nickname = user.getNickname();
			nickname = nickname.substring( 0, nickname.indexOf( "@" ) );
		}

		model.addAttribute( "nickname", nickname );

		return "day_page";
	}
}