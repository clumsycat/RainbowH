package cn.ac.ict.dao.impl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
/*import com.cloudera.impala.jdbc41.Driver ;
import  com.cloudera.impala.jdbc41.DataSource ;*/

public class MineImpala {
	

	
  //private static final String SQL_STATEMENT = "select * from benchmark.index_raw_parquet limit 10";
  //set the impalad host
  private static final String IMPALAD_HOST = "10.10.108.70";
  //port 21050 is the default impalad JDBC port 
  private static final String IMPALAD_JDBC_PORT = "21050";
  private static final String CONNECTION_URL = "jdbc:impala://" + IMPALAD_HOST  + ':' + IMPALAD_JDBC_PORT;

  private static final String JDBC_DRIVER_NAME = "com.cloudera.impala.jdbc41.Driver";
  public static Connection con = null;
  public static Statement stmt = null;
  
  
	 static{
		try {
			Class.forName(JDBC_DRIVER_NAME);
			if(con==null){
			con = DriverManager.getConnection(CONNECTION_URL);
			stmt = con.createStatement();
			}
		} catch (ClassNotFoundException e) {
			System.out.println("Class Not Found");
			e.printStackTrace();
		}catch (SQLException e) {
			System.out.println("Some problem happened in SQLDataBase Connecting");
			e.printStackTrace();
		}
	}
	
	public static void chooseDatabase(String database){
		String choice = "use "+database;
		try {
			stmt.execute(choice);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public static boolean Update(String query) throws SQLException{
		boolean flag=false;
		if(stmt.executeUpdate(query)==-1)
			flag=true;
		System.out.println(flag);
		return flag;
		
	}
	
	public static void execute(String query) throws SQLException{
		System.out.println(stmt.execute(query));
	}
	
	public static void executeLargeUpdate(String query) throws SQLException{
		System.out.println(stmt.executeLargeUpdate(query));
	}
  /**
   * Ö´ÐÐ²éÑ¯£¬·µ»Ø½á¹û,µÚÒ»¸öStringÎª¸÷¸ö×Ö¶Î£¬ºóÃæµÄStringÎªËùÓÐµÄ²éÑ¯½á¹û
 * @param String 
 * @return List<String>
 */
public static List<String> Query(String QueryRequest) {//Ö´ÐÐ²éÑ¯£¬·µ»Ø½á¹û,µÚÒ»¸öStringÎª¸÷¸ö×Ö¶Î£¬ºóÃæµÄStringÎªËùÓÐµÄ²éÑ¯½á¹û
	
		
	List<String> QueryAnswer = new ArrayList<String>();
	  QueryRequest = QueryRequest.trim();
	  QueryRequest = QueryRequest.toLowerCase();
	  ResultSet rs = null;
	  String temp = "";
	  
	try {
		rs = stmt.executeQuery(QueryRequest);
		ResultSetMetaData rsmd = rs.getMetaData();
		int columnCount = rsmd.getColumnCount();//»ñÈ¡ÁÐÊý
		int i;
		System.out.println("columnCount::"+columnCount);
		for(i=1;i<columnCount;i++){
			temp += rsmd.getColumnName(i);
			temp+=',';
		}
		temp += rsmd.getColumnName(i);//»ñµÃ×îºóÒ»¸ö£¬ÒÔ±£Ö¤Ã»ÓÐ¶àÓà·Ö¸ô·û
		QueryAnswer.add(temp);
		
		while (rs.next()) {
			String tempString = "";
			for(i=1;i<columnCount;i++){				
				tempString += rs.getString(i);
				tempString+=',';
			}
			tempString += rs.getString(i);//»ñµÃ×îºóÒ»¸ö£¬ÒÔ±£Ö¤Ã»ÓÐ¶àÓà·Ö¸ô·û
		    QueryAnswer.add(tempString);
		    System.out.println("tempString::"+tempString);
		} 
		

	} catch (SQLException e) {
		System.out.println("Some Problem had happened in SQL Querying");
		e.printStackTrace();
	} finally{
		System.out.println("database is closed");
	}     
        return QueryAnswer;
    }
  
  
  /**
 * ¶Ï¿ªÁ¬½Ó
 */
public static void CloseConnection(){//¶Ï¿ªÁ´½Ó
	  try {
		if(!stmt.isClosed()){
			stmt.close();
		}
		if(!con.isClosed())
			  con.close();
	  }catch (SQLException e) {
		  System.out.println("failed to close the connection");
		  e.printStackTrace();
	  }
  }
  


	enum Symbol {
		Like,in,parallel,bigger,smaller,noFound
	}
/**
 *  @author shusheng
 * ·Ö½â¹Ø¼ü×Ö,Ö»Ö§³Ö"=","in","like",µ«±¾·½·¨²»Ö§³Ö">","<",Ö»ÊÇÖ§³Ö²ð½â³öÀ´
 *  ÒÔ¼òµ¥sqlÎªÀý£ºselect * from benchmark.index_raw_parquet where IndexID='\\'e1a3019912584ae3a3aa\\'' and sourceid
 *  like '%abc%' and type in (a,c,v)
 * ·Ö½âÍêÖ®ºó·µ»Ø½á¹ûÎª[indexID] ['\'e1a3019912584ae3a3aa\''] [sourceid] ['%abc%'] [type] [(a,c,v)]
 * ¶à¸öÌõ¼þÔòwhereºóÃæµÄ²¿·Ö¶¼»á²ð·Ö³öÀ´
 * @param String 
 * @return String[][]
 */
	public static String[][] split(String QueryRequest) throws Exception{//·Ö½â¹Ø¼ü×Ö
		Symbol symbol = null;
		  String sql;
		  sql=QueryRequest.trim();
	      sql=sql.toLowerCase();
	      String[] splitTwo = null;
	      
		  String[] splitOne = sql.split(" where");
		  if(sql.split(" where").length<2){
			  System.out.println("no where conditition");
			  return null;
		  }
			  
		  if (QueryRequest.indexOf("group by")!=-1){
			  splitTwo = splitOne[1].split("group by");
		  }else if (QueryRequest.indexOf("order by")!=-1){
			  splitTwo = splitOne[1].split("order by");
		  }else{
			  splitTwo = splitOne;
		  }
		  String[] splitThree = splitTwo[0].split(" and ");
		  List<String> splitFour = new ArrayList<String>();
		  int i=0,j=0;	  
		  while(i<splitThree.length){
			  if (splitThree[i].indexOf(" or ")==-1)
				  splitFour.add(splitThree[i++].trim());
			  else {
				  String[] splitTemp = splitThree[i++].split(" or ");			  
				  splitFour.add(splitTemp[0].trim());
				  splitFour.add(splitTemp[1].trim());
			  }			 
		  }
		  i = splitFour.size();
		  String[][] splitFive=new String[i][2];
		  j=0;
		  while(j<i){
			  if (splitFour.get(j).indexOf(" like ")!=-1) symbol = Symbol.Like;
			  else if (splitFour.get(j).indexOf(" in ")!=-1) symbol = Symbol.in;
			  else if (splitFour.get(j).indexOf("=")!=-1) symbol = Symbol.parallel;
			  else if (splitFour.get(j).indexOf(">")!=-1) symbol = Symbol.bigger;
			  else if (splitFour.get(j).indexOf("<")!=-1) symbol = Symbol.smaller;
			  else symbol = Symbol.noFound;
			  switch (symbol) {
			case Like: 
				splitFive[j] = splitFour.get(j).split(" like "); j++;
				break;
			case in: 
				splitFive[j] = splitFour.get(j).split(" in "); j++;
				break;
			case parallel: splitFive[j] = splitFour.get(j).split("="); j++;
				break;
			case bigger: splitFive[j] = splitFour.get(j).split(">"); j++;
				break;
			case smaller: splitFive[j] = splitFour.get(j).split("<"); j++;
				break;
			case noFound:
				throw new Exception("the relation between key and value in criterias is not carify");
			default:
				break;
			}
		  }
		  return splitFive;   
	  }
 /**
  * ¶þ´Î·Ö½â¹Ø¼ü×Ö£¬È¥µôIndexIDÌõ¼þ,ÈôÒªÈ¥µô¶à¸ö£¬ÔòÔÚIfÖÐÉÔ×÷ÐÞ¸Ä¼´¿É
 * @param String[][]
 * @return String[][]
 */
public static String[][] Secondsplit(String[][] splited){//¶þ´Î·Ö½â¹Ø¼ü×Ö£¬È¥µôIndexIDÌõ¼þ,ÈôÒªÈ¥µô¶à¸ö£¬ÔòÔÚIfÖÐÉÔ×÷ÐÞ¸Ä¼´¿É
	  String[][] SecondSplited = new String[splited.length][2];
	  int i = 0,j=0,count=0;
	  String IndexID = "IndexID";
	  while (i < splited.length){
		  if (!splited[i][0].equalsIgnoreCase(IndexID)){
			  SecondSplited[j][0] = splited[i][0];
			  SecondSplited[j++][1] = splited[i++][1];	  
		  }else{
			  i++;
			  count++;
		  }		  
	  } 
	  if (count > 0){
		  String changeArray[][] = new String [splited.length-count][2];
		  for(i = 0;i<splited.length-count;i++){
			  changeArray[i][0] = SecondSplited[i][0];
			  changeArray[i][1] = SecondSplited[i][1];
		  }
		 return changeArray;
	  }
	  return SecondSplited;
 }

  /**
   * @author shusheng
   * ¸ù¾ÝIndexIDÀ´Éú³ÉÔ¤È¡Ïà¹ØIndexIDÓï¾ä:È¡Ïà¹ØIDµÄ¸¸ID
 * @param String[][]
 * @return String
 * @throws Exception
 */
public static String prefetchFatherID(String[][] splited) throws Exception{//¸ù¾ÝIndexIDÀ´Éú³ÉÔ¤È¡Ïà¹ØIndexIDÓï¾ä:È¡Ïà¹ØIDµÄ¸¸ID
	  String ParentID = null,GetParentQuery,QueryKey;
	  int i=0;
	  String Indexid = "indexid";
	  while(i<splited.length){
		  if(splited[i++][0].equalsIgnoreCase(Indexid))
			  break;
	  }
	  if (i==splited.length){
		  if (!splited[splited.length-1][0].equalsIgnoreCase(Indexid))
			  {
			  	System.out.println("nothing about indexid exists");
			  	return null;
			  }
	  }
	  QueryKey = splited[--i][1];
	  QueryKey = processString2(QueryKey);
	  GetParentQuery = "select ParentID from benchmark.index_raw_parquet where IndexID like '%"+QueryKey+"%'";
	  List<String> list = new ArrayList<String>();
	  list = Query(GetParentQuery);
	  
	 /* for(String string : list)
		  System.out.println(string);//´Ë´¦¿É¿´È¡µÃµÄ½á¹û¼¯*/
	  
	  if(list != null && list.size() >= 2)
		  ParentID=Query(GetParentQuery).get(1);
	  if(ParentID==null)
		  throw new Exception("failed to find the ParentID");	
	  

	  
	  return ParentID;
  }
  
/*  public String ProcessString (String ParentID){//¼Ó¹¤´®£¬½«ÐÎÈç×Ö·û´®¡®abcdefg¡¯×ª±ä³ÉÐÎÈç\'abcdefg\'
	  ParentID = "\\" + ParentID;
	  int location = ParentID.lastIndexOf("'");
	  ParentID = ParentID.substring(0, location);
	  ParentID = ParentID + "\\'";
	  
	  return ParentID;
  }*/
  
  	/**
  	 * @author shusheng
  	 * ¶Ô×Ö·û´®½øÐÐÈ¥µ¥ÒýºÅ´¦Àí,´Ë´¦½öÕë¶ÔÓÚ±¾Êý¾Ý¿â
  	 * @param String
  	 * @return String
  	 */
  	public static String processString2(String ParentID){//¶Ô×Ö·û´®½øÐÐÈ¥µ¥ÒýºÅ´¦Àí
  		int locationa = ParentID.indexOf("'");
  		int locationb = ParentID.lastIndexOf("'");
  		if(locationa != -1){
  			if(locationb != locationa)
  				ParentID = ParentID.substring(locationa+1, locationb);
  			else
  				ParentID = ParentID.substring(locationa+1);
  		}
  			return ParentID;
  	}
  
  /**
   * Í¨¹ý²éÑ¯Óï¾ä»ñÈ¡Ëù²éÑ¯µÄ±íÃû£¬ÔÝÊ±Ã»ÓÃ
   * @author shusheng
 * @param String
 * @return StringBuffer
 */
public static StringBuffer GetTableName(String QueryRequest){//Í¨¹ý²éÑ¯Óï¾ä»ñÈ¡Ëù²éÑ¯µÄ±íÃû£¬ÔÝÊ±Ã»ÓÃ
	  StringBuffer TableName = new StringBuffer();
	  QueryRequest = QueryRequest.trim();
	  QueryRequest = QueryRequest.toLowerCase();
	  int location = QueryRequest.indexOf("from");
	  QueryRequest = QueryRequest.substring(location+4);
	  QueryRequest = QueryRequest.trim();
//	  QueryRequest = QueryRequest.replaceAll("\\s*", " ");  
	  char [] stringArr = QueryRequest.toCharArray();
	  
	  for (int i = 0;i<stringArr.length;i++){
		  if (' '==stringArr[i]){
			  break;
		  }else{
			  TableName.append(stringArr[i]);
		  }
	  }
	  return TableName;
  }
  
  /**
  * »ñÈ¡ÍêÕû ²éÑ¯Ìõ¼þ
  * @author shusheng
 * @param QueryRequest
 * @return String
 * 
 */
public static String GetCondition(String QueryRequest){//»ñÈ¡ÍêÕû²éÑ¯Ìõ¼þ£¬µ«²»°üÀ¨group by¡¢order by¡¢limitµÈÓï¾ä
		String sql=QueryRequest.trim();	  
	    sql=sql.toLowerCase();
		String Condition = null;
		int locationWhere = QueryRequest.indexOf("where");
/*
 * 0.1°æÄÚÈÝÎªÒÀ´Î¶¨Î»£¬ÓÐbug£¬¼´µ±sqlÓï¾äÖÐgroup by £¬order by£¬limitµÈ³öÏÖ²»°´´ÎÐòµÄ»°£¬Ôò»á³öÏÖÎóÅÐ
 *ÐÞ¸Äºó£º
 *ÉèÖÃlocation±äÁ¿£¬¼ÇÂ¼group by,order by,limitÖÐ×îÔç³öÏÖµÄÄÇ¸öµÄÎ»ÖÃ£¬½øÐÐ½Ø»ñ
 * 
 * 		int locationGroup = QueryRequest.indexOf("group");
		int locationOrder = QueryRequest.indexOf("order");
		int locationLimit = QueryRequest.indexOf("limit");
		
		if(locationWhere==-1){
			return null;
		}else if(locationGroup!=-1){
			Condition = QueryRequest.substring(locationWhere, locationGroup);
		}else if (locationOrder!=-1){
			Condition = QueryRequest.substring(locationWhere, locationOrder);
		}else if (locationLimit!=-1){
			Condition = QueryRequest.substring(locationWhere, locationLimit);
		}else{
			Condition = QueryRequest.substring(locationWhere);
		}*/

	//ÒÔÏÂÎª0.2°æÄÚÈÝ
		int location = -1;
		int min = -1;
		location = sql.indexOf(" group by");
		if(locationWhere==-1){
			return null;
		}
		if (location!=-1)
			min = location;
		location = sql.indexOf(" order by");
		if ((location!=-1&&location<min)||(min==-1))
			min = location;
		location = sql.indexOf(" limit ");
		if ((location!=-1&&location<min)||(min==-1))
			min = location;
		if(min == -1)
			Condition = QueryRequest.substring(locationWhere);
		else 
			Condition = QueryRequest.substring(locationWhere, min);
		
		return Condition;
	}
  
  /**
   * É¾¼õ²éÑ¯Ìõ¼þ£¬È¥µôIndexIDÏà¹ØÏî£¬´Ë´¦Ö»¿¼ÂÇand£¬ÔÝÎ´¿¼ÂÇor
   * @author shusheng
 * @param String
 * @return String
 */
public static String ShorterCondition(String Condition){//É¾¼õ²éÑ¯Ìõ¼þ£¬È¥µôIndexIDÏà¹ØÏî£¬´Ë´¦Ö»¿¼ÂÇand£¬ÔÝÎ´¿¼ÂÇor
	  if (Condition==null)
		  return null;
	  Condition = Condition.trim();
	  Condition = Condition.toLowerCase();
	  String forDelete = "indexid";//´Ë´¦×Ö·û´®±ØÐëÈ«²¿ÎªÐ¡Ð´
	  String ConditionTemp,ConditionFront,ConditionBack,ShorterCondition;
	  if (Condition.indexOf(forDelete)==-1)
		  return Condition;
	  int locationForDelete = Condition.indexOf(forDelete);
	  int locationLastAnd = Condition.lastIndexOf("and");
	  
	  if (locationForDelete > locationLastAnd){
		  //É¾³ý×îºóÒ»¸öand ºÍÌõ¼þ
		  ShorterCondition = Condition.substring(0, locationLastAnd);
	  }else{
		 //É¾³ýÌõ¼þºÍ¸ÃÌõ¼þºóµÄÄÇ¸öand
		  ConditionTemp = Condition.substring(locationForDelete);
		  int Offset = ConditionTemp.indexOf("and");
		  ConditionFront = Condition.substring(0, locationForDelete);
		  ConditionFront = ConditionFront.trim();//Ïû³ýºóÃæµÄ¿Õ¸ñ
		  ConditionBack = Condition.substring(locationForDelete+Offset+3);
		  ShorterCondition = ConditionFront + ConditionBack;
	  }
	  return ShorterCondition;
  }
  
  /**
   * ¸ù¾ÝindexID²éÑ¯Ïà¹ØµÄËùÓÐÐÖµÜ½áµã
   * @author shusheng
 * @param String
 * @return List<String>
 * @throws Exception
 */
public static List<String> prefetchBrotherIndexID(String QueryRequest)throws Exception{//¸ù¾ÝindexID²éÑ¯Ïà¹ØµÄËùÓÐÐÖµÜ½áµã
	  String Condition = null;
	  String prefetchBrothers = null;
	  List<String> QueryAnswer = new ArrayList<String>();
	  
	  String[][] splited = split(QueryRequest);
	  
	  //ÐÂÔö£º¹Ø¼ü×ÖÖÐÃ»ÓÐwhereÌõ¼þµÄ£¬²»Ô¤È¡
	  if(splited==null){
		  System.out.println("no conditition exist, can not prefetch by conditition");
		  return null;
	  }
	  //
	  String ParentID = null;
	  try {
		  ParentID = prefetchFatherID(splited);
	  } catch (Exception e) {
		  e.printStackTrace();
	  }
	  Condition = GetCondition(QueryRequest);
	  if(Condition==null){
		 throw new Exception("there is no Condition exist, can not Prefetch the relevant information");
	  }else if(Condition.toLowerCase().indexOf("indexid")==-1){
		  throw new Exception("there is no information about indexid in Condition,can not prefetch ");
	  }
	  ParentID = processString2(ParentID);//´¦ÀíËù»ñµÄ¸¸½Úµã£¬È¥µôÍ·Î²¿ÉÄÜ´æÔÚµÄµ¥ÒýºÅ
	  if(ParentID!=null){
		  prefetchBrothers = "select DestineID from benchmark.Relation_Pair_parquet where SourceID like '%"+ParentID
				  +"%' and PairType=0";//´Ë´¦pairtypeÎªÁã²Å»áÓÐ¶àÌõ£¬ÒòÎª´ËÊ±È¡µÄÊÇº¢×ÓÃÇ£¬Îª1ÔòÈ¡Æä¸¸
		 QueryAnswer = Query(prefetchBrothers);		  
	  }
	  return QueryAnswer;
  }
  
  /**
   * ´¦ÀíÐÖµÜ½á¹û¼¯,ÒÔ×Ö·û´®ÐÎÊ½·µ»Ø£¬ÒÔ±ã²éÑ¯
   * @author shusheng
 * @param List<String>
 * @return String
 */
public static String processList(List<String> QueryAnswer){//´¦ÀíÐÖµÜ½á¹û¼¯,ÒÔ×Ö·û´®ÐÎÊ½·µ»Ø£¬ÒÔ±ã²éÑ¯
	  //ÓÉÓÚÊý¾Ý¿âÖÐdestineidµÄ×Ö·û´®ÐÎÊ½¶¼Ö»ÓÐ×óÒýºÅ£¬¹Ê×öÒ»ÏÂ´¦Àí£¬ÈÃÆäÒ²ÓÐÓÒÒýºÅ£¬Í¬Ê±£¬ÌáÇ°×öºÃÒýºÅµÄ×ªÒå
	  String NewQueryAnswer = "";
	  String list;
	  for (int i=1;i<QueryAnswer.size();i++){//´ÓµÚÒ»´®¿ªÊ¼»ñÈ¡£¬µÚ0´®ÊÇ×Ö¶ÎÃû
		//ÎªÊ¹ÏÂÒ»²½²éÑ¯Óï¾äÖÐµÄin£¬±ØÐë½«µ¥ÒýºÅ×ªÒå£¬¹Ê´Ë´¦»¹µÃ×ö×ªÒå²Ù×÷£¬Ê¹Æä½á¹ûÎª'\'abc1\'','\'abc2\'','\'abc3\''
		//´Ë´¦Ã¿¸ö»ñµÃµÄ´®QueryAnswer.get(i)¶¼ÊÇÐÎÈç¡®abc1ÕâÖÖ£¬Ã»ÓÐÓÒÒýºÅ£¬Ðè¼Ó¹¤³É'\'abc1\''
		  list = "'\\"+QueryAnswer.get(i)+"\\''";
		  NewQueryAnswer+=list;
		  NewQueryAnswer+=",";
	  }
	  int location = NewQueryAnswer.lastIndexOf(",");
	  NewQueryAnswer = NewQueryAnswer.substring(0, location);//Ê¹µÃ×îºóÒ»¸ö´®ºóÃæ²»ÔÙ´øÓÐ","  
	  return NewQueryAnswer;	  
  }
  
  /**
   * Ô¤È¡ÎåÌõÈÈÊý¾Ý,Ö»¸ù¾ÝIndexid£¬ÆäËüÌõ¼þÉáÆú,È¡µÃ½á¹ûÎªÎåÌõIndexID
   * @author shusheng
 * @param String
 * @return List<String>
 * @throws Exception
 */
public static List<String> prefetchHotFiveBySingle(String  QueryRequest)throws Exception{//Ô¤È¡ÎåÌõÈÈÊý¾Ý,Ö»¸ù¾ÝIndexid£¬ÆäËüÌõ¼þÉáÆú,È¡µÃ½á¹ûÎªÎåÌõIndexID
	  List<String> brothers = new ArrayList<String>();
	  String finallBrothers = null;
	  
	  String hotRequest;
	  List<String> Hotfive = new ArrayList<String>();
	  brothers = prefetchBrotherIndexID(QueryRequest);
	  finallBrothers = processList(brothers);
	  hotRequest = "select indexid from benchmark.index_raw_parquet where IndexID in ("
		        +finallBrothers+") "
		        +" order by IndexHeat desc"
		        +" limit 5";
	 /* System.out.println(finallBrothers);
	  System.out.println(hotRequest);*/
	  Hotfive = Query(hotRequest);
	  return Hotfive;
  }
  
  /**
   * ¸ù¾ÝËùÓÐ²éÑ¯Ìõ¼þÀ´Ô¤È¡5ÌõÊý¾Ý£¬Ö÷ÒªÏÞÖÆÎªIndexid£¬ÆäËüÏÞÖÆ±£Áô£¬ËùÈ¡½á¹ûÎª5ÌõIndexID
   * @author shusheng
 * @param String
 * @return List<String>
 * @throws Exception
 */
public static List<String> prefetchHotFiveByAll(String QueryRequest) throws Exception {//¸ù¾ÝËùÓÐ²éÑ¯Ìõ¼þÀ´Ô¤È¡5ÌõÊý¾Ý£¬Ö÷ÒªÏÞÖÆÎªIndexid£¬ÆäËüÏÞÖÆ±£Áô£¬ËùÈ¡½á¹ûÎª5ÌõIndexID	
	  //ÓÉÓÚ±¾Êý¾Ý¿âÖÐParentIDºÍIndexheatÏÞÖÆÌõ¼þÒ²±È½ÏÈÝÒ×¶¨ËÀ£¬ËùÒÔ²»µ÷ÓÃ±¾º¯Êý
	  String Condition = null,ShorterCondition = null;
	  List<String> brothers = new ArrayList<String>();
	  String finallBrothers = null;
	  
	  String hotRequest;
	  List<String> Hotfive = new ArrayList<String>();
	  brothers = prefetchBrotherIndexID(QueryRequest);
	  finallBrothers = processList(brothers);
	  
	  Condition =GetCondition(QueryRequest);
	  if(Condition==null){
		 throw new Exception("there is no Condition exist, can not Prefetch the relevant information");
	  }else if(Condition.toLowerCase().indexOf("indexid")==-1){
		  throw new Exception("there is no information about indexid in Condition,can not prefetch ");
	  }
	  ShorterCondition = ShorterCondition(Condition);
	  hotRequest = "select indexid from benchmark.index_raw_parquet where IndexID in ("
		        +finallBrothers+") and"+ ShorterCondition.substring(5)
		        +" order by IndexHeat desc"
		        +" limit 5";

	  Hotfive = Query(hotRequest);
	  return Hotfive;
  }
  
  /**
   * »ñÈ¡ÒªKeyÖµ£¬¼´¿ÉÄÜµÄ²éÑ¯Óï¾ä£¬ÊäÈë²ÎÊýÎªËù²éÑ¯µÄÎå¸öÈÈµãIndexid
   * @author shusheng
 * @param List<String>
 * @return String[]
 */
public static String[] getKeys(List<String> list){//»ñÈ¡ÒªKeyÖµ£¬¼´¿ÉÄÜµÄ²éÑ¯Óï¾ä£¬ÊäÈë²ÎÊýÎªËù²éÑ¯µÄÎå¸öÈÈµãIndexid
	  String[] Keys = new String[list.size()-1];
	  String temp = "";
	  for ( int i=0,j=1;j<list.size();i++,j++){
		  temp = processString2(list.get(j));//È¥³ýÍ·Î²¿ÉÄÜ´æÔÚµÄµ¥ÒýºÅ
		  Keys[i] = "select * from benchmark.index_raw_parquet where indexid like '%"
				  + temp + " %'";
	  }
	  return Keys;
  }
  
  /**
   * Ð´ÄÚ´æ£¬ÊäÈë²ÎÊýÎªÒ»Ìõ²éÑ¯Óï¾ä
   * @author shusheng
 * @param String
 * @return null
 * @throws Exception
 */
public static void WriteMemory(String Keys)throws Exception{//Ð´ÄÚ´æ£¬ÊäÈë²ÎÊýÎªÒ»Ìõ²éÑ¯Óï¾ä
	  //SpymemcachedClient sc;//µ÷ÓÃ»º´æ¿Í»§¶ËÀà
		  List<String> value = new ArrayList<String>();//´æÈëµÄ²éÑ¯Óï¾ä
		  value = Query(Keys);//Ö´ÐÐ²éÑ¯£¬»ñµÃÒª´æÈëÄÚ´æµÄ²éÑ¯½á¹û
		  //¿ªÊ¼´æÈëÄÚ´æ
		  /*
		  boolean set = false;
		  set = sc.set_global(Keys,value);
			if(set=false)
				throw new Exception("something is wrong when writing to memorycache ");*/
  }
  public static void ReadMemory(){//¶ÁÄÚ´æ
	  
  }
  /**
   * »ñÈ¡selectµÄ¾ßÌåÄÚÈÝ
   * @author shusheng
 * @param String
 * @return String[]
 */
public static String[] getSelectValue (String sql){//»ñÈ¡selectµÄ¾ßÌåÄÚÈÝ
	  String[] selectvalue = sql.split("from");
	  selectvalue = selectvalue[0].split("select");
	  selectvalue[1] = selectvalue[1].trim();//Ïû³ýÇ°ÃæµÄµÚÒ»¸ö¿Õ¸ñ
	  selectvalue = selectvalue[1].split(",");
	  
	  return selectvalue;
  }
  
}
