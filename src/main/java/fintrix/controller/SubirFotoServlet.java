package fintrix.controller;

import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/SubirFotoServlet")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 5 * 1024 * 1024,
        maxRequestSize = 10 * 1024 * 1024
)
public class SubirFotoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Integer usuarioId = (Integer) session.getAttribute("usuarioId");

        if (usuarioId == null) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        Part fotoPart = request.getPart("foto");

        if (fotoPart != null && fotoPart.getSize() > 0) {

            String nombreArchivo = "user_" + usuarioId + ".jpg";

            String rutaFotos = getServletContext().getRealPath("/uploads");
            File carpeta = new File(rutaFotos);
            if (!carpeta.exists()) {
                carpeta.mkdirs();
            }

            fotoPart.write(rutaFotos + File.separator + nombreArchivo);

            session.setAttribute("fotoPerfil", "uploads/" + nombreArchivo);
        }

        response.sendRedirect(request.getContextPath() + "/Html/configuracion.jsp");
    }

}
