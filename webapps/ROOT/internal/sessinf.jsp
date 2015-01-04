<%@ page language="java" import="javax.servlet.http.*,java.util.*"%>
<% pageContext.setAttribute("pageName", "login", PageContext.REQUEST_SCOPE); 
%><% pageContext.setAttribute("pageCategory", "login", PageContext.REQUEST_SCOPE); 
%><html>
<head>
<title>Session info</title>
</head>
<body>
<table border="1">
	<tr><th>Runtime</th><th align="left">Value</th></tr>
	<tr><td>Vendor</td><td><%=System.getProperty("java.vendor")%></td></tr>
	<tr><td>Version</td><td><%=System.getProperty("java.version")%></td></tr>
	<tr><td>freeMemory</td><td><%=java.lang.Runtime.getRuntime().freeMemory()%></td></tr>
	<tr><td>totalMemory</td><td><%=java.lang.Runtime.getRuntime().totalMemory()%></td></tr>
	<tr><td></td><td></td></tr>
	<tr><th>Session Attribute</th><th align="left">Value</th></tr>
	<tr><td>SessionId</td><td><%=session.getId()%></td></tr>
	<tr><td>isNew</td><td><%=session.isNew()%></td></tr>
	<tr><td>isValid?</td><td><%=request.isRequestedSessionIdValid()%></td></tr>
	<tr><td>contextName</td><td><%=session.getServletContext().getServletContextName()%></td></tr>
	<tr><td>fromCookie?</td><td><%=request.isRequestedSessionIdFromCookie()%></td></tr>
	<tr><td>fromUrl?</td><td><%=request.isRequestedSessionIdFromURL()%></td></tr>
	<tr><td>request url</td><td><%=request.getRequestURL()%></td></tr>
	<tr><td>request scheme</td><td><%=request.getScheme()%></td></tr>
	<tr><td>request server</td><td><%=request.getServerName()%></td></tr>
	<tr><td>request server port</td><td><%=request.getServerPort()%></td></tr>
	<tr><td>request uri</td><td><%=request.getRequestURI()%></td></tr>
	<tr><td>request pathinfo</td><td><%=request.getPathInfo()%></td></tr>
	<tr><td>request query string</td><td><%=request.getQueryString()%></td></tr>
	<tr><td>RemoteUser</td><td><%=request.getRemoteUser()%></td></tr>
	<tr><td>Locale</td><td><%=request.getLocale()%></td></tr>
	<tr><td>LocalUser</td><td><%=sUserLocal%></td></tr>
	<tr><td>MaxInactiveInterval</td><td><%=session.getMaxInactiveInterval()%></td></tr>
	<tr><td>creationTime</td><td><%=session.getCreationTime()%></td></tr>
	<tr><td>Current time</td><td><%=System.currentTimeMillis()%></td></tr>
	<tr><td>lastAccessed</td><td><%=session.getLastAccessedTime()%></td></tr>
	<tr><td>sessionAge</td><td><%=(System.currentTimeMillis() - session.getCreationTime())/1000%></td>

	<tr><th>Request</th><th align="left">Value</th></tr>
	<tr><td>Request URI</td><td><code><%= request.getRequestURI () %></code></td></tr>
	<tr><td>getRemoteAddr</td><td><%=request.getRemoteAddr()%></td></tr>
	<tr><td>getRemoteHost</td><td><%=request.getRemoteHost()%></td></tr>
	<tr><td>isSecure</td><td><%=request.isSecure()%></td></tr>

        <tr><th>Session Attributes</th></tr>
        <%
        
          Enumeration enum = session.getAttributeNames();
          for (; enum.hasMoreElements(); ) {
            // Get the name of the attribute
            String sessionAttributeName = (String)enum.nextElement();
            // Get the value of the attribute
            Object sessionAttributeValue = session.getAttribute(sessionAttributeName);
        %>
        <tr><td><code><%= sessionAttributeName %></code></td>
          <%
            if (sessionAttributeValue == null){
          %>
          <td>&lt;null&gt;</td></tr>
        <%
        } else {
        %>
        <td><code><%= sessionAttributeValue %></code></td></tr>
      <%
      }
    }

	Enumeration headers = request.getHeaderNames();
	Enumeration parameters = request.getParameterNames();
 
	Properties sysproperties = System.getProperties();
	Enumeration properties = sysproperties.propertyNames();

		javax.servlet.http.Cookie[] blokiCookies = request.getCookies();
 
		if (headers == null){
			%><tr><td colspan=2">No Request Headers</td></tr><%
		} else {
			String headername;
			String headerval;
			%>
			<tr><th colspan="2" align="left">Request Headers</th></tr>
			<%
			while (headers.hasMoreElements ()){
				headername = (String) headers.nextElement ();
				headerval = request.getHeader (headername);
				%>
				<tr><td><code><%= headername %></code></td>
				<%
				if (headerval == null){
					%>
					<td>&lt;null&gt;</td></tr>
					<%
				} else {
					%>
					<td><code><%= headerval %></code></td></tr>
					<%
				}
			}
		}
		if (parameters == null){
			%><tr><th colspan="2">No Request Parameters</th></tr><%
		} else {
			String parametername;
			String parameterval;
			%>
			<tr><th colspan="2" align="left">Request Parameters</th></tr>
			<%
			while (parameters.hasMoreElements ()){
				parametername = (String) parameters.nextElement ();
				String[] parametervals = request.getParameterValues (parametername);
				for (int i=0;i<parametervals.length;i++){
					%>
					<tr><td><code><%= parametername %></code></td>
					<%
					if (parametervals[i] == null){
						%>
						<td>&lt;null&gt;</td></tr>
						<%
					} else {
						%>
						<td><code><%= parametervals[i] %></code></td></tr>
						<%
					}
				}
			}
		}
		if (properties == null){
			%><tr><th colspan="2">No System Properties</th></tr><%
		} else {
			%>
			<tr><th colspan="2" align="left">System Properties</th></tr>
			<%
			while (properties.hasMoreElements ()){
				String name = (String) properties.nextElement ();
				String value = (String) sysproperties.get(name);
				%>
				<tr><td><code><%= name %></code></td>
				<%
				if (value.equals("null")){
					%>
					<td>&lt;null&gt;</td></tr>
					<%
				} else {
					%>
					<td><code><%= value %></code></td></tr>
					<%
				}
			}
		}
	        if (blokiCookies == null){
			%><tr><th colspan="2">No Cookies</th></tr><%
		} else {
			%>
			<tr><th colspan="2" align="left">Request Cookies</th></tr>
			<%
			for (int i = 0; i < blokiCookies.length; i++){
				%>
				<tr><<td><code><%= blokiCookies[i].getName() %></code></td>
				<%
				String cookieValue = java.net.URLDecoder.decode(blokiCookies[i].getValue());
				if (cookieValue == null){
					%>
					<td>&lt;null&gt;</td></tr>
					<%
				} else {
					%>
					<td><code><%= cookieValue %></code></td><td></td></tr>
					<tr><td>Comment</td><td><code><%= blokiCookies[i].getComment() %></code></td></tr>
					<tr><td>Domain</td><td><code><%= blokiCookies[i].getDomain() %></code></td></tr>
					<tr><td>MaxAge</td><td><code><%= blokiCookies[i].getMaxAge() %></code></td></tr>
					<tr><td>Path</td><td><code><%= blokiCookies[i].getPath() %></code></td></tr>
					<tr><td>Secure</td><td><code><%= blokiCookies[i].getSecure() %></code></td></tr>
					<tr><td>Version</td><td><code><%= blokiCookies[i].getVersion() %></code></td></tr>
					<%
				}
			}
		}
	
	        javax.servlet.ServletContext context = getServletContext();
		if (context == null){
			%><tr><th colspan="2">No Context Parameters</th></tr><%
		} else {
			%>
			<tr><th colspan="2" align="left">Context Parameters</th></tr>
			<%
			java.util.Enumeration initParams = context.getInitParameterNames();
			while(initParams.hasMoreElements()){
				String name = initParams.nextElement().toString();
				String value = context.getInitParameter(name).toString();
				%>
				<tr><td><%=name%></td><td><%=value%></td></tr>
				<%
			}
		}
%>
</table>
	
<ul>
	<li>
		Thanks to:
		<a href="http://agnes.dida.physik.uni-essen.de/~elug/themenabende/tomcat/jsp/showhdrs.html">http://agnes.dida.physik.uni-essen.de/~elug/themenabende/tomcat/jsp/showhdrs.html</a>
	</li>
	<li>

		<a href="http://jakarta.apache.org/tomcat/tomcat-4.0-doc/servletapi/javax/servlet/http/HttpSession.html">
		javax.servlet.http.HttpSession Intervace Javadocs
		</a>
	</li>
</ul>
	
</body>
</html>
	
