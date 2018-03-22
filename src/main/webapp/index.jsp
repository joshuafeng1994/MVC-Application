<%@page import="org.joda.time.DateTime"%>
<%@page import="java.util.Date"%>
<%@page import="com.google.gson.stream.JsonReader"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.io.Reader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="org.apache.commons.io.FileUtils"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@ page import="com.google.gson.JsonArray" %>
<%@ page import="com.google.gson.JsonObject" %>
<%@ page import="com.google.gson.*" %>
<%@ page import="neu.edu.*" %>


<html>
<body>
<h2>Articles from NEW YORK TIMES</h2>


<%
	String sUrl = "http://api.nytimes.com/svc/search/v2/articlesearch.json?api-key=6c7d0870ff6e48719b4d3561b75e38d3";
	URL url = new URL(sUrl);
	JsonReader reader = new JsonReader(new InputStreamReader(url.openStream(), "UTF-8"));
	Gson gson = new GsonBuilder().setPrettyPrinting().create();
	
	ArticleSearch article = gson.fromJson(reader, ArticleSearch.class);
	

	%>
	<form action="FilteredArticle.jsp" method="get">
	Input whatever you want to get from New York Times!
	<br>
	<input type="search" placeholder="Search" name="searchBar">
	<br>
	<br>
	What Types of Material Value you want to see?
	<br>
		<select name="type_of_material">
			<option selected="selected" value="All">All</option>
			<option value="Addendum">Addendum</option>
			<option value="An Analysis">An Analysis</option>
			<option value="An Appraisal">An Appraisal</option>
			<option value="Article">Article</option>
			<option value="Banner">Banner</option>
			<option value="Biography">Biography</option>
			<option value="Birth Notice">Birth Notice</option>
			<option value="Blog">Blog</option>
			<option value="Brief">Brief</option>
			<option value="Caption">Caption</option>
			<option value="Chronology">Chronology</option>
			<option value="Column">Column</option>
			<option value="Correction">Correction</option>
			<option value="Economic Analysis">Economic Analysis</option>
			<option value="Editorial">Editorial</option>
			<option value="Editorial Cartoon">Editorial Cartoon</option>
			<option value="Editors' Note">Editors' Note</option>
			<option value="First Chapter">First Chapter</option>
			<option value="Front Page">Front Page</option>
			<option value="Glossary">Glossary</option>
			<option value="Interactive Feature">Interactive Feature</option>
			<option value="Interactive Graphic">Interactive Graphic</option>
			<option value="Interview">Interview</option>
			<option value="Letter">Letter</option>
			<option value="List">List</option>
			<option value="Marriage Announcement">Marriage Announcement</option>
			<option value="Military Analysis">Military Analysis</option>
			<option value="News">News</option>
			<option value="News Analysis">News Analysis</option>
			<option value="Newsletter">Newsletter</option>
			<option value="Obituary">Obituary</option>
			<option value="Obituary (Obit)">Obituary (Obit)</option>
			<option value="Op-Ed">Op-Ed</option>
			<option value="Paid Death Notice">Paid Death Notice</option>
			<option value="Postscript">Postscript</option>
			<option value="Premium">Premium</option>
			<option value="Question">Question</option>
			<option value="Quote">Quote</option>
			<option value="Recipe">Recipe</option>
			<option value="Review">Review</option>
			<option value="Schedule">Schedule</option>
			<option value="SectionFront">SectionFront</option>
			<option value="Series">Series</option>
			<option value="Slideshow">Slideshow</option>
			<option value="Special Report">Special Report</option>
			<option value="Statistics">Statistics</option>
			<option value="Summary">Summary</option>
			<option value="Text">Text</option>
			<option value="Video">Video</option>
			<option value="Web Log">Web Log</option>		
		</select>
		<br>
		<br>
		I want to see the <select name="sort">
								<option selected="selected" value="newest">Latest</option>
								<option value="oldest">Oldest</option>
							</select> news.
		<br><br>
		I want to see the article from <input type="date" name="begin_date" placeholder="YYYYMMDD" 
		pattern="(?:18|19|20)[0-9]{2}(?:(?:0[1-9]|1[0-2])(?:0[1-9]|1[0-9]|2[0-9])|(?:(?!02)(?:0[1-9]|1[0-2])-(?:30))|(?:(?:0[13578]|1[02])-31))
		"> 
		to <input type="date" name="end_date" placeholder="YYYYMMDD" 
		pattern="(?:18|19|20)[0-9]{2}(?:(?:0[1-9]|1[0-2])(?:0[1-9]|1[0-9]|2[0-9])|(?:(?!02)(?:0[1-9]|1[0-2])-(?:30))|(?:(?:0[13578]|1[02])-31))
		">
		
		<br>
		<input type="submit" value="Search">
	</form>
	
	
	<br>
	<% out.println("Page is: "+article.getResponse().getMeta().getOffset());%>
	<hr>
	<% 
	
	for(int i = 0; i<article.getResponse().getDocs().size();i++){
		%><a href="<% out.println(article.getResponse().getDocs().get(i).getWeb_url());%>">
		<%
		out.println(article.getResponse().getDocs().get(i).getHeadline().getMain());%></a><br>
		
		<%
		
		//"Snippet: "
		
		if(article.getResponse().getDocs().get(i).getSnippet()!=null)
		out.println(article.getResponse().getDocs().get(i).getSnippet()+"<br><br>");
		
		if(article.getResponse().getDocs().get(i).getHeadline().getKicker()!=null)
		out.println("<br>Kicker:"+article.getResponse().getDocs().get(i).getHeadline().getKicker()+"<br>");
		
		if(article.getResponse().getDocs().get(i).getByline().getOrganization()!=null)
			out.print("<br>"+article.getResponse().getDocs().get(i).getByline().getOrganization());
		if(article.getResponse().getDocs().get(i).getByline().getOriginal()!=null)
			out.print("<br>"+"Original: "+article.getResponse().getDocs().get(i).getByline().getOriginal()+"<br>");
		if(article.getResponse().getDocs().get(i).getByline().getPerson()!=null)
		for(int j = 0; j<article.getResponse().getDocs().get(i).getByline().getPerson().size();j++){
			
			
			out.print("<br>"+"By Author: ");
			if(article.getResponse().getDocs().get(i).getByline().getPerson().get(j).getFirstname()!=null){
			out.print(article.getResponse().getDocs().get(i).getByline().getPerson().get(j).getFirstname()+" ");}
			if(article.getResponse().getDocs().get(i).getByline().getPerson().get(j).getMiddlename()!=null){
				out.print(article.getResponse().getDocs().get(i).getByline().getPerson().get(j).getMiddlename()+" ");}
			if(article.getResponse().getDocs().get(i).getByline().getPerson().get(j).getLastname()!=null){
				out.print(article.getResponse().getDocs().get(i).getByline().getPerson().get(j).getLastname()+" ");}
			if(article.getResponse().getDocs().get(i).getByline().getPerson().get(j).getOrganization()!=null){
				if(!article.getResponse().getDocs().get(i).getByline().getPerson().get(j).getOrganization().isEmpty())
				out.print("( "+article.getResponse().getDocs().get(i).getByline().getPerson().get(j).getOrganization()+" )");}
			
			out.println("<br>");
		}
		
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
		
		if(article.getResponse().getDocs().get(i).get_id()!=null)
		out.println("ID: "+article.getResponse().getDocs().get(i).get_id()+"<br>");
		
		if(article.getResponse().getDocs().get(i).getWord_count()!=null)
		out.println("Word_count: "+article.getResponse().getDocs().get(i).getWord_count()+"<br>");
		
		if(article.getResponse().getDocs().get(i).getSlideshow_credits()!=null)
		out.println("Slideshow_credits: "+article.getResponse().getDocs().get(i).getSlideshow_credits()+"<br>");%><br>
		
		
		
		<%
	//	out.println(article.getResponse().getDocs().get(i).getByline().getOriginal());
		if(article.getResponse().getDocs().get(i).getKeywords()!=null){
			if(!article.getResponse().getDocs().get(i).getKeywords().isEmpty())
			out.println("Rank:&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp Keywords include: "+"<br>");
		for(int k = 0; k<article.getResponse().getDocs().get(i).getKeywords().size();k++){
			out.println( "&nbsp&nbsp&nbsp"+article.getResponse().getDocs().get(i).getKeywords().get(k).getRank()
				+"&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp"+ article.getResponse().getDocs().get(i).getKeywords().get(k).getValue()+"<br>");
		}
		}
		
		
		%><hr><%
	}

%>


<br>
<br>


</body>
</html>
