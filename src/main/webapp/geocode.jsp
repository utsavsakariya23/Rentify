<%@ page contentType="application/json;charset=UTF-8" language="java" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.net.URL" %>
<%
    response.setContentType("application/json; charset=UTF-8");
    String lat = request.getParameter("lat");
    String lng = request.getParameter("lon");

    if (lat == null || lng == null) {
        response.setStatus(400);
        out.print("{\"error\": \"Missing lat/lon\"}");
        return;
    }

    try {
        String urlStr = "https://nominatim.openstreetmap.org/reverse?format=json&lat=" + lat + "&lon=" + lng + "&zoom=18&addressdetails=1";
        URL url = new URL(urlStr);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("User-Agent", "CarentEnterpriseSys/1.0 (utsavsakariya23@gmail.com)");
        conn.setRequestProperty("Accept-Language", "en-US,en;q=0.9");

        if (conn.getResponseCode() != 200) {
            response.setStatus(conn.getResponseCode());
            out.print("{\"error\": \"Upstream Nominatim error " + conn.getResponseCode() + "\"}");
            return;
        }

        BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        String inputLine;
        StringBuilder content = new StringBuilder();
        while ((inputLine = in.readLine()) != null) {
            content.append(inputLine);
        }
        in.close();
        out.print(content.toString());
    } catch (Exception e) {
        response.setStatus(500);
        out.print("{\"error\": \"" + e.getMessage() + "\"}");
    }
%>
