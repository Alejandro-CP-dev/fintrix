/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package fintrix.controller;

import java.io.IOException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author Alejandro
 */
@WebServlet("/google-login")
public class GoogleLoginServlet extends HttpServlet {

    private static final String CLIENT_ID = "98988323402-69becp4ocs53usgf56oqbea1i6ig5jbc.apps.googleusercontent.com";
    private static final String REDIRECT_URI
            = "http://localhost:8080/Fintrix/google-callback";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String url = "https://accounts.google.com/o/oauth2/v2/auth"
                + "?client_id=" + CLIENT_ID
                + "&redirect_uri=" + REDIRECT_URI
                + "&response_type=code"
                + "&scope=openid email profile"
                + "&access_type=online";

        response.sendRedirect(url);
    }
}
