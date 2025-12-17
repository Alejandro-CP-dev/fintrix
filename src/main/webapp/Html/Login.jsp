<%@ page import="fintrix.dao.UsuarioDAO, fintrix.model.Usuario" %>
<%
request.setCharacterEncoding("UTF-8");

String email = request.getParameter("email");
String clave = request.getParameter("clave");

UsuarioDAO dao = new UsuarioDAO();
Usuario usuario = dao.login(email, clave);

if (usuario != null) {
    session.setAttribute("usuarioId", usuario.getId());
    response.sendRedirect("PControl_Finanzas.jsp");
} else {
    response.sendRedirect("../index.jsp?error=1");
}
%>