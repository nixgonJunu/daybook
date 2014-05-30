package nixgon.daybook;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.logging.Logger;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;
import javax.servlet.http.HttpServletRequest;

import nixgon.daybook.model.Daybook;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

@Controller
public class DaybookController {
	private static final Logger log = Logger.getLogger( DaybookController.class.getName() );

	private static String yesterday = null;
	private static String today = null;

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

	@RequestMapping(value = "/day_page")
	public String listDaybook( ModelMap model ) {
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
		String nickname = null;

		DateFormat sdFormat = new SimpleDateFormat( "yyyyMMdd" );
		Date nowDate = new Date();
		today = sdFormat.format( nowDate );

		Calendar day = Calendar.getInstance();
		day.add( Calendar.DATE, -1 );
		yesterday = new SimpleDateFormat( "yyyyMMdd" ).format( day.getTime() );

		if ( user != null ) {
			nickname = user.getNickname();
			if (nickname.indexOf( "@" ) > 0) {
				nickname = nickname.substring( 0, nickname.indexOf( "@" ) );
			}
		}

		model.addAttribute( "today", today );
		model.addAttribute( "yesterday", yesterday );
		model.addAttribute( "nickname", nickname );
		model.addAttribute( "logout_url", userService.createLogoutURL( "../login" ) );
		
		PersistenceManager pm = PMF.get().getPersistenceManager();
		Query qToday = pm.newQuery( Daybook.class );
		qToday.setFilter( "date == '" + today + "'");
		Query qYesterday = pm.newQuery( Daybook.class );
		qYesterday.setFilter( "date == '" + yesterday  + "'");

		List < Daybook > resultToday = null;
		List < Daybook > resultYesterday = null;

		try {
			resultToday = (List < Daybook >) qToday.execute();
			resultYesterday = (List < Daybook >) qYesterday.execute();

			if ( resultToday.isEmpty() ) {
				model.addAttribute( "todayDaybook", null );
			} else {
				model.addAttribute( "todayDaybook", resultToday.get( 0 ) );
			}

			if ( resultYesterday.isEmpty() ) {
				model.addAttribute( "yesterdayDaybook", null );
			} else {
				model.addAttribute( "yesterdayDaybook", resultYesterday.get( 0 ) );
			}
		} finally {
			qToday.closeAll();
			qYesterday.closeAll();
			pm.close();
		}

		return "day_page";
	}

	@RequestMapping(value = "/day_write/{date}", method = RequestMethod.GET)
	public String getAddDaybookPage( @PathVariable String date, ModelMap model ) {
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
		String nickname = null;

		if ( user != null ) {
			nickname = user.getNickname();
			nickname = nickname.substring( 0, nickname.indexOf( "@" ) );
		}

		model.addAttribute( "date", date );
		model.addAttribute( "nickname", nickname );

		return "day_write";
	}

	@RequestMapping(value = "/day_write/{date}", method = RequestMethod.POST)
	public ModelAndView add( @PathVariable String date, HttpServletRequest request, ModelMap model ) {
		String weather = request.getParameter( "weather" );
		String subject = request.getParameter( "subject" );
		String content = request.getParameter( "content" );

		log.info( date );
		log.info( weather );
		log.info( subject );
		log.info( content );

		Daybook diary = new Daybook();

		diary.setDate( date );
		diary.setWeather( weather );
		diary.setSubject( subject );
		diary.setContent( content );
		diary.setModified_date( new Date() );

		PersistenceManager pm = PMF.get().getPersistenceManager();
		try {
			pm.makePersistent( diary );
		} finally {
			pm.close();
		}

		return new ModelAndView( "redirect:../day_page" );
	}

	// @RequestMapping(value = "/modify/{name}", method = RequestMethod.GET)
	// public String getUpdateDaybookPage( @PathVariable String name,
	// HttpServletRequest reqeust, ModelMap model ) {
	// PersistenceManager pm = PMF.get().getPersistenceManager();
	//
	// Query q = pm.newQuery( Daybook.class );
	// q.setFilter( "name == nameParameter" );
	// q.setOrdering( "date desc" );
	// q.declareParameters( "String nameParameter" );
	//
	// try {
	// List < Daybook > results = (List < Daybook >) q.execute( name );
	//
	// if ( results.isEmpty() ) {
	// model.addAttribute( "Daybook", null );
	// } else {
	// model.addAttribute( "Daybook", results.get( 0 ) );
	// }
	// } finally {
	// q.closeAll();
	// pm.close();
	// }
	//
	// return "modify";
	// }
	//
	// @RequestMapping(value = "/modify", method = RequestMethod.POST)
	// public ModelAndView update( HttpServletRequest request, ModelMap model )
	// {
	// String author = request.getParameter( "author" );
	// String weather = request.getParameter( "weather" );
	// String key = request.getParameter( "key" );
	//
	// PersistenceManager pm = PMF.get().getPersistenceManager();
	//
	// try {
	// Daybook diary = pm.getObjectById( Daybook.class, key );
	//
	// diary.setAuthor( author );
	// diary.setWeather( weather );
	// diary.setDate( new Date() );
	// } finally {
	// pm.close();
	// }
	//
	// return new ModelAndView( "redirect:day_page" );
	// }
	//
	// @RequestMapping(value = "/erase/{key}", method = RequestMethod.GET)
	// public ModelAndView delete( @PathVariable String key, HttpServletRequest
	// request, ModelMap model ) {
	// PersistenceManager pm = PMF.get().getPersistenceManager();
	//
	// try {
	// Daybook diary = pm.getObjectById( Daybook.class, key );
	// pm.deletePersistent( diary );
	// } finally {
	// pm.close();
	// }
	//
	// return new ModelAndView( "redirect:../day_page" );
	// }
	//
}