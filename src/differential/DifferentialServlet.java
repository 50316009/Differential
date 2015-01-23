package differential;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.*;

@SuppressWarnings("serial")
public class DifferentialServlet extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
		Differential diff = new Differential();			//実際は目的関数、偏微分も渡す
		diff.calDf();
		diff.calCdf();
		req.setAttribute("res",diff);
		try {
			this.getServletContext().getRequestDispatcher("/Differential.jsp").forward(req,resp);
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		Differential diff = new Differential();			//実際は目的関数、偏微分も渡す
		diff.calDf();
		req.setAttribute("res",diff);
		this.getServletContext().getRequestDispatcher("/Differential.jsp").forward(req,resp);
	}
}
