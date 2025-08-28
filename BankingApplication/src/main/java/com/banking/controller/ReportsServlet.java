package com.banking.controller;

import com.banking.dao.AccountDAO;
import com.banking.dao.TransactionDAO;
import com.banking.dao.UserDAO;
import com.banking.model.Transaction;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet({"/reports","/reports.csv"})
public class ReportsServlet extends HttpServlet {
    private UserDAO userDAO;
    private AccountDAO accountDAO;
    private TransactionDAO transactionDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
        accountDAO = new AccountDAO();
        transactionDAO = new TransactionDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null ||
            (session.getAttribute("userRole") != null && !"ADMIN".equals(session.getAttribute("userRole")))) {
            response.sendRedirect("login.jsp");
            return;
        }

        String path = request.getServletPath();
        try {
            if ("/reports.csv".equals(path)) {
                exportTransactionsCsv(response);
            } else {
                request.setAttribute("totalCustomers", userDAO.getUsersByRole("CUSTOMER").size());
                request.setAttribute("totalAccounts", accountDAO.getAllAccounts().size());
                request.setAttribute("transactions", transactionDAO.getAllTransactions());
                request.getRequestDispatcher("adminDashboard.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Failed to load reports");
            request.getRequestDispatcher("adminDashboard.jsp").forward(request, response);
        }
    }

    private void exportTransactionsCsv(HttpServletResponse response) throws Exception {
        List<Transaction> txs = transactionDAO.getAllTransactions();
        response.setContentType("text/csv");
        response.setHeader("Content-Disposition", "attachment; filename=transactions.csv");
        try (PrintWriter out = response.getWriter()) {
            out.println("ID,Type,Amount,Status,Date,FromAccount,ToAccount");
            for (Transaction t : txs) {
                out.printf("%d,%s,%s,%s,%tF %<tT,%d,%d%n",
                        t.getId(), t.getTransactionType(), t.getAmount().toPlainString(), t.getStatus(),
                        t.getTransactionDate(), t.getFromAccountId(), t.getToAccountId());
            }
        }
    }
}


