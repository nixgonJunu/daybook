package nixgon.daybook.model;

import java.util.Date;

import javax.jdo.annotations.IdGeneratorStrategy;
import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.Persistent;
import javax.jdo.annotations.PrimaryKey;

import com.google.appengine.api.datastore.Key;

@PersistenceCapable
public class Daybook {

	@PrimaryKey
	@Persistent(valueStrategy = IdGeneratorStrategy.IDENTITY)
	private Key key;
	
	@Persistent
	private String author;

	@Persistent
	private String date;

	@Persistent
	private String weather;
	
	@Persistent
	private String subject;

	@Persistent
	private String content;
	
	@Persistent
	private Date modified_date;

	public Key getKey() {
		return key;
	}

	public void setKey( Key key ) {
		this.key = key;
	}
	
	public String getAuthor() {
		return author;
	}

	public void setAuthor( String author ) {
		this.author = author;
	}

	public String getWeather() {
		return weather;
	}

	public void setWeather( String weather ) {
		this.weather = weather;
	}

	public String getDate() {
		return date;
	}

	public void setDate( String date ) {
		this.date = date;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject( String subject ) {
		this.subject = subject;
	}

	public String getContent() {
		return content;
	}

	public void setContent( String content ) {
		this.content = content;
	}

	public Date getModified_date() {
		return modified_date;
	}

	public void setModified_date( Date modified_date ) {
		this.modified_date = modified_date;
	}
}
