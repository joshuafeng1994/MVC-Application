# MVC-Application
A simple MVC web application using Web API of New York Times

Using maven to build this project.

Front-end for News content by consuming the Article Search API ( http://developer.nytimes.com/article_search_v2.json) made available by the New York Times (   http://developer.nytimes.com/).

This NYT API returns content formatted in JSON so that extract the content with Java code, mark that same content up in HTML, and then return it to the client (browser interface).
	
This can store the search data in a SQL database of your searched.
 
For web application initial screen, select any topic, and call the Article Search API to get articles back that User present (default site content) followed by a search UI for the user to input a query that the JSP will get as input, make a call to the Article Search API with the query as input, and then present the results returned by the API. 

This application would have a total of 2 screens as a result, 
	one to display the default content/search UI, 
	and another to display the results returned for a user-provided query.
