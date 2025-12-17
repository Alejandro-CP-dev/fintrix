package fintrix.controller;

import fintrix.dao.*;
import fintrix.model.Usuario;
import java.io.IOException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.google.api.client.googleapis.auth.oauth2.GoogleAuthorizationCodeTokenRequest;
import com.google.api.client.googleapis.auth.oauth2.GoogleTokenResponse;
import com.google.api.client.http.GenericUrl;
import com.google.api.client.http.HttpRequest;
import com.google.api.client.http.HttpRequestFactory;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.jackson2.JacksonFactory;

import org.json.JSONObject;

/**
 *
 * @author Alejandro
 */
@WebServlet("/google-callback")
public class GoogleCallbackServlet extends HttpServlet {

    private static final String CLIENT_ID = "98988323402-69becp4ocs53usgf56oqbea1i6ig5jbc.apps.googleusercontent.com";
    private static final String CLIENT_SECRET = "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";
    private static final String REDIRECT_URI = "http://localhost:8080/Fintrix/google-callback";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String code = request.getParameter("code");
        if (code == null) {
            response.sendRedirect("index.jsp?error=google");
            return;
        }

        // Intercambiar code por token
        GoogleTokenResponse tokenResponse
                = new GoogleAuthorizationCodeTokenRequest(
                        new NetHttpTransport(),
                        JacksonFactory.getDefaultInstance(),
                        "https://oauth2.googleapis.com/token",
                        CLIENT_ID,
                        CLIENT_SECRET,
                        code,
                        REDIRECT_URI
                ).execute();

        String accessToken = tokenResponse.getAccessToken();

        // Obtener datos del usuario
        HttpRequestFactory requestFactory
                = new NetHttpTransport().createRequestFactory();

        GenericUrl url
                = new GenericUrl("https://www.googleapis.com/oauth2/v2/userinfo");

        HttpRequest googleRequest
                = requestFactory.buildGetRequest(url);
        googleRequest.getHeaders().setAuthorization("Bearer " + accessToken);

        String json = googleRequest.execute().parseAsString();

        JSONObject userInfo = new JSONObject(json);
        String email = userInfo.getString("email");
        String nombre = userInfo.getString("name");

        UsuarioDAO usuarioDAO = new UsuarioDAO();
        Usuario usuario = usuarioDAO.obtenerPorEmail(email);

        if (usuario != null && "LOCAL".equals(usuario.getProveedor())) {
            response.sendRedirect("index.jsp?error=local");
            return;
        }

        if (usuario == null) {
            boolean creado = usuarioDAO.insertarUsuarioGoogle(nombre, email);
            if (!creado) {
                response.sendRedirect("index.jsp?error=insert");
                return;
            }
            usuario = usuarioDAO.obtenerPorEmail(email);
        }

        if (!"GOOGLE".equals(usuario.getProveedor())) {
            response.sendRedirect("index.jsp?error=proveedor");
            return;
        }

        HttpSession session = request.getSession(true);
        session.setAttribute("usuarioId", usuario.getId());
        session.setAttribute("usuario", usuario);

        response.sendRedirect("Html/PControl_Finanzas.jsp");
    }
}
