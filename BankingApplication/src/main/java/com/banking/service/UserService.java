package com.banking.service;

import com.banking.dao.UserDAO;
import com.banking.model.User;
import java.sql.SQLException;
import java.util.List;

public class UserService {
    private UserDAO userDAO;
    
    public UserService() {
        this.userDAO = new UserDAO();
    }
    
    public User authenticateUser(String username, String password) throws SQLException {
        if (username == null || username.trim().isEmpty() || 
            password == null || password.trim().isEmpty()) {
            return null;
        }
        return userDAO.authenticateUser(username.trim(), password.trim());
    }
    
    public List<User> getAllUsers() throws SQLException {
        return userDAO.getAllUsers();
    }
    
    public User getUserById(int id) throws SQLException {
        return userDAO.getUserById(id);
    }
    
    public boolean addUser(User user) throws SQLException {
        if (user == null || user.getUsername() == null || user.getUsername().trim().isEmpty() ||
            user.getPassword() == null || user.getPassword().trim().isEmpty()) {
            return false;
        }
        return userDAO.addUser(user);
    }
    
    public boolean updateUser(User user) throws SQLException {
        if (user == null || user.getId() <= 0) {
            return false;
        }
        return userDAO.updateUser(user);
    }
    
    public boolean deleteUser(int id) throws SQLException {
        if (id <= 0) {
            return false;
        }
        return userDAO.deleteUser(id);
    }
    
    public boolean validateUserData(User user) {
        if (user == null) return false;
        if (user.getUsername() == null || user.getUsername().trim().isEmpty()) return false;
        if (user.getPassword() == null || user.getPassword().trim().isEmpty()) return false;
        if (user.getFullName() == null || user.getFullName().trim().isEmpty()) return false;
        if (user.getEmail() == null || user.getEmail().trim().isEmpty()) return false;
        if (user.getPhone() == null || user.getPhone().trim().isEmpty()) return false;
        if (user.getAddress() == null || user.getAddress().trim().isEmpty()) return false;
        return true;
    }
}
