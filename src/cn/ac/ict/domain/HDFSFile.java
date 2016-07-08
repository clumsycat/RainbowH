package cn.ac.ict.domain;

import java.sql.Timestamp;

/**
 * @author weilu
 * @creation 2015Äê10ÔÂ10ÈÕ
 * 
 */
public class HDFSFile {
	/*
		DROP TABLE IF EXISTS `deleteinfo`;
		CREATE TABLE `deleteinfo` (
		  `IndexID` char(36) COLLATE utf8_unicode_ci NOT NULL,
		  `ParentID` char(36) COLLATE utf8_unicode_ci NOT NULL,
		  `IndexType` int(20) COLLATE utf8_unicode_ci NOT NULL,
		  `IndexLevel` int(20) COLLATE utf8_unicode_ci NOT NULL,
		  `IndexName` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
		  `AuthorName` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
		  `AuthorId` char(36) COLLATE utf8_unicode_ci NOT NULL,
		  `FileSize` int(20) unsigned COLLATE utf8_unicode_ci NOT NULL, 
		  `IndexHeat` int(20) unsigned COLLATE utf8_unicode_ci NOT NULL, 
		  `IndexDownload` varchar(1200) COLLATE utf8_unicode_ci NOT NULL,
		  `IndexFullPath` varchar(1200) COLLATE utf8_unicode_ci NOT NULL,
		  `KeyWords` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
		  `IndexAbstract` varchar(2000) COLLATE utf8_unicode_ci NOT NULL,
		  `UpdateTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
		  `OperationType` char(4) COLLATE utf8_unicode_ci NOT NULL,
		  `DeleteUser` char(36) COLLATE utf8_unicode_ci NOT NULL,
		  `DeleteTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
		  PRIMARY KEY (`IndexId`),
		  UNIQUE KEY `deleteinfo_file_title_unique` (`IndexName`)
		) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

	 */
	int file_size;//`FileSize` 
	int view_count;// `IndexHeat` 
	int download_count;// `IndexDownload` 
	int file_type;// `IndexType` 
	int index_level;//`IndexLevel` 
	String author_id;//`AuthorId` 
	String author_name;//`AuthorName` 
	String file_id; // `IndexID` 
	String parent_id; // `ParentID` 
	String file_title;// `IndexName` 
	String key_words;//`KeyWords` 
	String index_fullpath;//`IndexFullPath` 
	String index_abstract;//`IndexAbstract` 
	String delete_user;//`DeleteUser` 
	String operation_type;//`OperationType` 
	Timestamp update_time;//`UpdateTime` 
	Timestamp delete_time;//`DeleteTime` 


	public String getParent_id() {
		return parent_id;
	}

	public void setParent_id(String parent_id) {
		this.parent_id = parent_id;
	}

	public String getIndex_abstract() {
		return index_abstract;
	}

	public void setIndex_abstract(String index_abstract) {
		this.index_abstract = index_abstract;
	}

	public String getOperation_type() {
		return operation_type;
	}

	public void setOperation_type(String operation_type) {
		this.operation_type = operation_type;
	}

	public String getAuthor_id() {
		return author_id;
	}

	public void setAuthor_id(String author_id) {
		this.author_id = author_id;
	}

	public String getAuthor_name() {
		return author_name;
	}

	public void setAuthor_name(String author_name) {
		this.author_name = author_name;
	}

	public String getFile_id() {
		return file_id;
	}

	public void setFile_id(String file_id) {
		this.file_id = file_id;
	}

	public int getFile_size() {
		return file_size;
	}

	public void setFile_size(int file_size) {
		this.file_size = file_size;
	}

	public String getFile_title() {
		return file_title;
	}

	public void setFile_title(String file_title) {
		this.file_title = file_title;
	}

	public int getFile_type() {
		return file_type;
	}

	public void setFile_type(int file_type) {
		this.file_type = file_type;
	}

	public int getIndex_level() {
		return index_level;
	}

	public void setIndex_level(int index_level) {
		this.index_level = index_level;
	}

	public String getKey_words() {
		return key_words;
	}

	public void setKey_words(String key_words) {
		this.key_words = key_words;
	}

	public String getIndex_fullpath() {
		return index_fullpath;
	}

	public void setIndex_fullpath(String index_fullpath) {
		this.index_fullpath = index_fullpath;
	}

	public int getView_count() {
		return view_count;
	}

	public void setView_count(int view_count) {
		this.view_count = view_count;
	}

	public int getDownload_count() {
		return download_count;
	}

	public void setDownload_count(int download_count) {
		this.download_count = download_count;
	}

	public Timestamp getUpdate_time() {
		return update_time;
	}

	public void setUpdate_time(Timestamp update_time) {
		this.update_time = update_time;
	}

	public Timestamp getDelete_time() {
		return delete_time;
	}

	public void setDelete_time(Timestamp delete_time) {
		this.delete_time = delete_time;
	}

	public String getDelete_user() {
		return delete_user;
	}

	public void setDelete_user(String delete_user) {
		this.delete_user = delete_user;
	}
}
