<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="org.joda.time.DateTime"%>
<%@page import="java.util.Date"%>
<%@page import="java.io.IOException"%>
<%@page import="com.google.gson.stream.JsonReader"%>
<%@page import="java.net.URL"%>
<%@page import="neu.edu.ArticleSearch"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="java.io.InputStreamReader"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Filtered Articles</title>
</head>
<body>
<%
//has to specify the serverTimezone explicitly in the connection string
	final String URL = "jdbc:mysql://localhost:3306/joshuafeng?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
	final String USER = "root";
	final String PASSWORD = "123456";	


	String searchContent = null;
	String selectedTypeOfMaterial = null;
	String sortedArticles = null;
	String beginDate = null;
	String endDate = null;
	String orgUrl = "http://api.nytimes.com/svc/search/v2/articlesearch.json";
	String api_key = "api-key=6c7d0870ff6e48719b4d3561b75e38d3";
	String sUrl = null;
	String type_of_material_all = "All";
	
//	System.out.println(!request.getParameter("begin_date").isEmpty());
//	System.out.println(request.getParameter("end_date").isEmpty());
	
	if(!request.getParameter("searchBar").isEmpty()){
		searchContent = "q="+(String)request.getParameter("searchBar").replace(" ", "+");
		sUrl = orgUrl + "?" + searchContent + "&hl=true";
		System.out.println(sUrl);
	}else{
		sUrl = orgUrl + "?";
		System.out.println(sUrl);
	}
	
	if(request.getParameter("type_of_material").equals(type_of_material_all)){
		sortedArticles = "sort="+ (String)request.getParameter("sort");
		sUrl = sUrl+"&"+sortedArticles;
		System.out.println(sUrl);
	}else 
	{
		sortedArticles = "sort="+ (String)request.getParameter("sort");
		selectedTypeOfMaterial = "type_of_material:"+(String)request.getParameter("type_of_material");
		sUrl = sUrl+"&"+"fq="+selectedTypeOfMaterial+"&"+sortedArticles;
		System.out.println(sUrl);
		
	}
	
	
	if(request.getParameter("begin_date").isEmpty()&&request.getParameter("end_date").isEmpty()){
			sUrl = sUrl+"&"+api_key;
			
			System.out.println(sUrl);
	}
	else if(!request.getParameter("begin_date").isEmpty()&&request.getParameter("end_date").isEmpty()){
		
		String receivedBeginDate = new DateTime(request.getParameter("begin_date")).toString("yyyyMMdd");
		beginDate = "begin_date="+receivedBeginDate;
		sortedArticles = "sort="+ (String)request.getParameter("sort");
		selectedTypeOfMaterial = "type_of_material:"+(String)request.getParameter("type_of_material");
		sUrl = sUrl+"&"+beginDate+"&"+api_key;
		System.out.println(sUrl);
		
	}else if(!request.getParameter("end_date").isEmpty()&&request.getParameter("begin_date").isEmpty()){
		
		String receivedEndDate = new DateTime(request.getParameter("end_date")).toString("yyyyMMdd");
		endDate = "end_date="+receivedEndDate;
		sortedArticles = "sort="+ (String)request.getParameter("sort");
		selectedTypeOfMaterial = "type_of_material:"+(String)request.getParameter("type_of_material");
		sUrl = sUrl+"&"+endDate+"&"+api_key;
		System.out.println(sUrl);
		
	}else if(!request.getParameter("end_date").isEmpty()&&!request.getParameter("begin_date").isEmpty()){
		
		String receivedBeginDate = new DateTime(request.getParameter("begin_date")).toString("yyyyMMdd");
		String receivedEndDate = new DateTime(request.getParameter("end_date")).toString("yyyyMMdd");
		beginDate = "begin_date="+receivedBeginDate;
		endDate = "end_date="+receivedEndDate;
		sortedArticles = "sort="+ (String)request.getParameter("sort");
		selectedTypeOfMaterial = "type_of_material:"+(String)request.getParameter("type_of_material");
		sUrl = sUrl+"&"+beginDate+"&"+endDate+"&"+"&"+api_key;
		System.out.println(sUrl);
		
	}
	
	

	
//	System.out.println(sUrl);
	
	URL url = new URL(sUrl);
	
	try{
		JsonReader reader = new JsonReader(new InputStreamReader(url.openStream(), "UTF-8"));
		Gson gson = new GsonBuilder().setPrettyPrinting().create();
		ArticleSearch article = gson.fromJson(reader, ArticleSearch.class);
		
		//1.load driver
			Class.forName("com.mysql.jdbc.Driver");
		//2.get database connection
			Connection conn = DriverManager.getConnection(URL,USER,PASSWORD);
		
		
		%>
		<a href="index.jsp">Return to have a new search</a><hr>
		
		<% 
		
		for(int i = 0; i<article.getResponse().getDocs().size();i++){
			
			
			
			//docs
			String webUrl = article.getResponse().getDocs().get(i).getWeb_url();
			String main = article.getResponse().getDocs().get(i).getHeadline().getMain();
			String snippet = article.getResponse().getDocs().get(i).getSnippet();
			String ID = article.getResponse().getDocs().get(i).get_id();
			
			String storedID = "SELECT _id FROM article WHERE _id = ?";
			
			//munipulate db
			Statement stmt = conn.createStatement();
			
			PreparedStatement psID = conn.prepareStatement(storedID);
			psID.setString(1, ID);
			ResultSet rs = psID.executeQuery();
			
			if(!rs.next()){
			
			String sql = "INSERT INTO article(web_url, snippet, main, _id) VALUES (?,?,?,?)";
			PreparedStatement ps = conn.prepareStatement(sql);  
			ps.setString(1, webUrl);
			ps.setString(2, main);
			ps.setString(3, snippet);
			ps.setString(4, ID);
			ps.executeUpdate();
			
			}else{
				System.out.println(ID+"has exist");
			}
			
			
			%><a href="<% out.println(webUrl);%>">
			<%
			out.println(main);%></a><br>
			
	<%
		if(snippet!=null){
		out.println(snippet+"<br><br>");}
	
	
	
	//ByLine
	
			
		if(article.getResponse().getDocs().get(i).getByline()!=null){
		if(article.getResponse().getDocs().get(i).getByline().getOrganization()!=null)
			out.print("<br>"+article.getResponse().getDocs().get(i).getByline().getOrganization());
		if(article.getResponse().getDocs().get(i).getByline().getOriginal()!=null)
			out.print("<br>"+"Original: "+article.getResponse().getDocs().get(i).getByline().getOriginal()+"<br>");
		
		if(article.getResponse().getDocs().get(i).getByline().getPerson()!=null)
		for(int j = 0; j<article.getResponse().getDocs().get(i).getByline().getPerson().size();j++){
			
			String firstName = article.getResponse().getDocs().get(i).getByline().getPerson().get(j).getFirstname();
			String middleName = article.getResponse().getDocs().get(i).getByline().getPerson().get(j).getMiddlename();
			String lastName = article.getResponse().getDocs().get(i).getByline().getPerson().get(j).getLastname();
			String personOrganization = article.getResponse().getDocs().get(i).getByline().getPerson().get(j).getOrganization();
			
			out.print("<br>"+"By Author: ");
			if(firstName!=null){
			out.print(firstName+" ");}
			if(middleName!=null){
				out.print(middleName+" ");}
			if(lastName!=null){
				out.print(lastName+" ");}
			if(personOrganization!=null){
				if(!personOrganization.isEmpty())
				out.print("( "+personOrganization+" )");}
			
			out.println("<br>");
		}}
		
		
	//	String leadParagraph = ;
	//	String abstractContent = ;
	//	String printPage = ;
	//	String source = ;
	//	String documentType = ;
	//	String newsDesk = ;
	//	String sectionName = ;
	//	String subsectionName = ;
	//	String typeOfMaterial = ;
	//	String ID = article.getResponse().getDocs().get(i).get_id();
	//	String wordCount = ;
	//	String slideShowCredit = ;
		
		if(article.getResponse().getDocs().get(i).getLead_paragraph()!=null){
			out.println("Lead_paragraph: "+article.getResponse().getDocs().get(i).getLead_paragraph()+"<br>");}
		
		if(article.getResponse().getDocs().get(i).getAbstractContent()!=null){
		out.println("AbstractContent: "+article.getResponse().getDocs().get(i).getAbstractContent()+"<br>");}
		
		if(article.getResponse().getDocs().get(i).getPrint_page()!=null){
		out.println("Print_page: "+article.getResponse().getDocs().get(i).getPrint_page()+"<br>");}
		
		if(article.getResponse().getDocs().get(i).getBlog().toString()!="{}"){
		out.println("Blog: "+article.getResponse().getDocs().get(i).getBlog()+"<br>");}
		
		if(article.getResponse().getDocs().get(i).getSource()!=null){
		out.println("Source: "+article.getResponse().getDocs().get(i).getSource()+"<br>");}
		
		if(article.getResponse().getDocs().get(i).getPub_date()!=null){
		DateTime date = new DateTime(article.getResponse().getDocs().get(i).getPub_date());//.toDate();
		out.println("Publish date: "+ date.toString("MMMM dd, yyyy, HH:mm:ss")+"<br>");}
		
		if(article.getResponse().getDocs().get(i).getDocument_type()!=null)
		out.println("Document_type: "+article.getResponse().getDocs().get(i).getDocument_type()+"<br>");
		
		if(article.getResponse().getDocs().get(i).getNews_desK()!=null)
		out.println("News_desK: "+article.getResponse().getDocs().get(i).getNews_desK()+"<br>");
		
		if(article.getResponse().getDocs().get(i).getSection_name()!=null)
		out.println("Section_name: "+article.getResponse().getDocs().get(i).getSection_name()+"<br>");
		
		if(article.getResponse().getDocs().get(i).getSubsection_name()!=null)
		out.println("Subsection_name: "+article.getResponse().getDocs().get(i).getSubsection_name()+"<br>");
		
		if(article.getResponse().getDocs().get(i).getType_of_material()!=null)
		out.println("Type_of_material: "+article.getResponse().getDocs().get(i).getType_of_material()+"<br>");
		
		if(ID!=null)
		out.println("ID: "+ID+"<br>");
		
		if(article.getResponse().getDocs().get(i).getWord_count()!=null)
		out.println("Word_count: "+article.getResponse().getDocs().get(i).getWord_count()+"<br>");
		
		if(article.getResponse().getDocs().get(i).getSlideshow_credits()!=null)
		out.println("Slideshow_credits: "+article.getResponse().getDocs().get(i).getSlideshow_credits()+"<br>");
		%>
		<hr>
		<%
		
		}
		
		%>
		
		
			
			
		<%
	}catch(IOException e){
		out.println("Don't find any articles, please have a new search");
		%>
		<a href="index.jsp">Return to main page</a>
		<%
	}
	catch (SQLException e) {
		out.println("Something wrong with the database");
	}
	%>
	
	

</body>
</html>