package com.banking.controller;

import com.banking.model.Beneficiary;
import com.banking.model.User;
import com.banking.service.BeneficiaryService;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/beneficiaries")
public class BeneficiaryServlet extends HttpServlet {
    private BeneficiaryService beneficiaryService;

    @Override
    public void init() throws ServletException {
        beneficiaryService = new BeneficiaryService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        User user = (User) session.getAttribute("user");
        try {
            request.setAttribute("beneficiaries", beneficiaryService.getBeneficiariesByOwner(user.getId()));
            request.getRequestDispatcher("beneficiaries.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Failed to load beneficiaries");
            request.getRequestDispatcher("beneficiaries.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        User user = (User) session.getAttribute("user");
        String action = request.getParameter("action");

        try {
            if ("add".equals(action)) {
                int beneficiaryUserId = Integer.parseInt(request.getParameter("beneficiaryUserId"));
                int beneficiaryAccountId = Integer.parseInt(request.getParameter("beneficiaryAccountId"));
                String nickname = request.getParameter("nickname");
                Beneficiary b = new Beneficiary();
                b.setOwnerUserId(user.getId());
                b.setBeneficiaryUserId(beneficiaryUserId);
                b.setBeneficiaryAccountId(beneficiaryAccountId);
                b.setNickname(nickname);
                if (beneficiaryService.addBeneficiary(b)) {
                    request.getSession().setAttribute("successMessage", "Beneficiary added.");
                } else {
                    request.getSession().setAttribute("errorMessage", "Unable to add beneficiary.");
                }
            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                if (beneficiaryService.deleteBeneficiary(id, user.getId())) {
                    request.getSession().setAttribute("successMessage", "Beneficiary deleted.");
                } else {
                    request.getSession().setAttribute("errorMessage", "Unable to delete beneficiary.");
                }
            }
        } catch (Exception ex) {
            request.getSession().setAttribute("errorMessage", "Error processing request.");
        }
        response.sendRedirect("beneficiaries");
    }
}


