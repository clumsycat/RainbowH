package cn.ac.ict.exception;

public class UserExistException extends Exception {
	/**
	 * UserExistException ������ע�⡣
	 */
	public UserExistException() {
	 
	super();
	 
	}
	/**
	 * UserExistException ������ע�⡣
	 * @param s java.lang.String
	 */
	public UserExistException(String message, Throwable cause) {
		super(message, cause);
	}

	public UserExistException(String message) {
		super(message);
	}

	public UserExistException(Throwable cause) {
		super(cause);
	}
}
