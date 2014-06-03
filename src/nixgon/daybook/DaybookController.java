package nixgon.daybook;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
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
	public String getDaybook( ModelMap model ) {
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
		String nickname = null;
		String author = null;
		
		DateFormat sdFormat = new SimpleDateFormat( "yyyyMMdd" );
		Date nowDate = new Date();
		String today = sdFormat.format( nowDate );

		if ( user != null ) {
			author = user.getEmail();
			if ( author.indexOf( "@" ) > 0 ) {
				nickname = author.substring( 0, author.indexOf( "@" ) );
			}
			
			if (nickname == null) {
				nickname = author;
			}
		}

		model.addAttribute( "today", today );
		model.addAttribute( "nickname", nickname );
		model.addAttribute( "author", author );
		model.addAttribute( "logout_url", userService.createLogoutURL( "../login" ) );

		PersistenceManager pm = PMF.get().getPersistenceManager();
		Query qToday = pm.newQuery( Daybook.class );
		qToday.setFilter( "date == '" + today + "' && author == '" + author + "'" );
		
		List < Daybook > resultToday = null;

		try {
			resultToday = (List < Daybook >) qToday.execute();

			if ( resultToday.isEmpty() ) {
				model.addAttribute( "todayDaybook", null );
			} else {
				model.addAttribute( "todayDaybook", resultToday.get( 0 ) );
			}
		} finally {
			qToday.closeAll();
			pm.close();
		}
		
		return "day_page";
	}

	@RequestMapping(value = "/day_write/today", method = RequestMethod.POST)
	public String writeTodayDaybook ( HttpServletRequest request, ModelMap model ) {
		String nickname = request.getParameter( "nickname" );
		String author = request.getParameter( "author" );
		String today = request.getParameter( "today" );

		model.addAttribute( "date", today );
		model.addAttribute( "nickname", nickname );
		model.addAttribute( "author", author );

		return "day_write";
	}

	@RequestMapping(value = "/day_write/{date}", method = RequestMethod.POST)
	public ModelAndView writeDaybook( @PathVariable String date, HttpServletRequest request, ModelMap model ) {
		String weather = request.getParameter( "weather" );
		String subject = request.getParameter( "subject" );
		String content = request.getParameter( "content" );
		String author = request.getParameter( "author" );

		Daybook diary = new Daybook();

		diary.setDate( date );
		diary.setAuthor( author );
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

	@RequestMapping(value = "/day_modify/today", method = RequestMethod.POST)
	public String modifyTodayDaybook( HttpServletRequest request, ModelMap model ) {
		String nickname = request.getParameter( "nickname" );
		String date = request.getParameter( "today" );
		String author = request.getParameter( "author" );

		model.addAttribute( "date", date );
		model.addAttribute( "nickname", nickname );

		PersistenceManager pm = PMF.get().getPersistenceManager();
		Query q = pm.newQuery( Daybook.class );
		q.setFilter( "date == dateParameter && author == '" + author + "'" );
		q.declareParameters( "String dateParameter" );

		try {
			List < Daybook > results = (List < Daybook >) q.execute( date );

			if ( results.isEmpty() ) {
				model.addAttribute( "Daybook", null );
			} else {
				model.addAttribute( "Daybook", results.get( 0 ) );
			}
		} finally {
			q.closeAll();
			pm.close();
		}

		return "day_modify";
	}

	@RequestMapping(value = "/day_modify/{date}", method = RequestMethod.POST)
	public ModelAndView modifyDaybook( @PathVariable String date, HttpServletRequest request, ModelMap model ) {
		String weather = request.getParameter( "weather" );
		String subject = request.getParameter( "subject" );
		String content = request.getParameter( "content" );
		String author = request.getParameter( "author" );
		String key = request.getParameter( "key" );

		PersistenceManager pm = PMF.get().getPersistenceManager();

		try {
			Daybook diary = pm.getObjectById( Daybook.class, key );

			diary.setDate( date );
			diary.setAuthor( author );
			diary.setWeather( weather );
			diary.setSubject( subject );
			diary.setContent( content );
			diary.setModified_date( new Date() );
		} finally {
			pm.close();
		}
		log.info("33333");

		return new ModelAndView( "redirect:../day_page" );
	}

	@RequestMapping(value = "/erase/{key}", method = RequestMethod.POST)
	public ModelAndView delete( @PathVariable String key, HttpServletRequest request, ModelMap model ) {
		PersistenceManager pm = PMF.get().getPersistenceManager();

		try {
			Daybook diary = pm.getObjectById( Daybook.class, key );
			pm.deletePersistent( diary );
		} finally {
			pm.close();
		}

		return new ModelAndView( "redirect:../day_page" );
	}

}