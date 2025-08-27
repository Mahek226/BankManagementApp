# 🏦 Banking Application

A comprehensive Java web application built with Servlets, JSPs, and MySQL following the MVC (Model-View-Controller) architecture pattern.

## ✨ Features

### Customer Features
- **Account Management**: Create and manage multiple bank accounts
- **Fund Transfers**: Transfer funds between accounts securely
- **Loan Applications**: Apply for various types of loans
- **Transaction History**: View detailed transaction records
- **Profile Management**: Update personal information

### Admin Features
- **User Management**: Add, edit, and manage customer accounts
- **Loan Approval**: Review and approve/reject loan applications
- **System Monitoring**: View system statistics and overview
- **Customer Support**: Manage customer accounts and status

## 🏗️ Architecture

The application follows the **MVC (Model-View-Controller)** pattern:

- **Model**: Java classes representing business entities (User, Account, Transaction, Loan)
- **View**: JSP pages for the user interface
- **Controller**: Servlets handling HTTP requests and business logic
- **DAO Layer**: Data Access Objects for database operations
- **Service Layer**: Business logic and validation

## 🛠️ Technology Stack

- **Backend**: Java Servlets, JSP
- **Database**: MySQL
- **Frontend**: HTML5, CSS3, JavaScript
- **Server**: Apache Tomcat (or any Java EE compatible server)
- **Build Tool**: Standard Java project (no Maven required)

## 📁 Project Structure

```
BankingApplication/
├── src/
│   └── main/
│       ├── java/
│       │   └── com/
│       │       └── banking/
│       │           ├── controller/     # Servlets
│       │           ├── model/          # Entity classes
│       │           ├── dao/            # Data Access Objects
│       │           └── service/        # Business logic
│       ├── resources/
│       └── webapp/
│           ├── WEB-INF/
│           │   ├── web.xml
│           │   └── jsp/
│           ├── *.jsp                  # JSP pages
│           └── error.jsp              # Error handling
├── database_schema.sql                # Database setup
└── README.md                          # This file
```

## 🚀 Setup Instructions

### Prerequisites
- Java JDK 8 or higher
- MySQL Server 5.7 or higher
- Apache Tomcat 9.0 or higher
- Any Java IDE (Eclipse, IntelliJ IDEA, NetBeans)

### 1. Database Setup
1. Install and start MySQL Server
2. Open MySQL command line or workbench
3. Execute the `database_schema.sql` file:
   ```sql
   source path/to/database_schema.sql
   ```
4. Verify the database and tables are created:
   ```sql
   USE banking_db;
   SHOW TABLES;
   ```

### 2. Database Configuration
Update the database connection details in `src/main/java/com/banking/util/DatabaseUtil.java`:
```java
private static final String URL = "jdbc:mysql://localhost:3306/banking_db";
private static final String USERNAME = "your_mysql_username";
private static final String PASSWORD = "your_mysql_password";
```

### 3. Project Setup
1. Import the project into your Java IDE
2. Add required libraries:
   - `mysql-connector-java-8.0.xx.jar`
   - `jstl-1.2.jar`
   - `servlet-api.jar` (usually included with Tomcat)
3. Configure the project as a Dynamic Web Project
4. Set the target runtime to Tomcat

### 4. Deploy and Run
1. Build the project
2. Deploy to Tomcat server
3. Start Tomcat
4. Access the application: `http://localhost:8080/BankingApplication`

## 🔐 Default Login Credentials

### Admin User
- **Username**: `admin`
- **Password**: `admin123`
- **Role**: Administrator

### Sample Customer Users
- **Username**: `john_doe` | **Password**: `password123`
- **Username**: `jane_smith` | **Password**: `password123`
- **Username**: `bob_wilson` | **Password**: `password123`

## 📱 Application Flow

1. **Login**: Users authenticate with username/password
2. **Role-based Routing**: 
   - Customers → Customer Dashboard
   - Admins → Admin Dashboard
3. **Feature Access**: Users access features based on their role
4. **Session Management**: Secure session handling with automatic logout

## 🔒 Security Features

- **Session Management**: Secure user sessions with timeout
- **Input Validation**: Client-side and server-side validation
- **SQL Injection Prevention**: Prepared statements usage
- **Role-based Access Control**: Feature access based on user roles
- **Password Protection**: Secure password handling

## 🎨 UI Features

- **Responsive Design**: Mobile-friendly interface
- **Modern UI**: Clean, professional banking interface
- **Interactive Elements**: Hover effects, animations, and feedback
- **Form Validation**: Real-time input validation
- **Message System**: Success/error message display

## 🚨 Error Handling

- **Global Error Page**: Custom error handling for all exceptions
- **User-friendly Messages**: Clear error and success messages
- **Logging**: Console logging for debugging
- **Graceful Degradation**: Application continues to function despite errors

## 📊 Database Schema

### Core Tables
- **users**: User accounts and profiles
- **accounts**: Banking accounts
- **transactions**: Financial transactions
- **loans**: Loan applications and details

### Views
- **active_accounts**: Active account summary
- **pending_loans**: Pending loan applications
- **transaction_summary**: Transaction details with user info

## 🧪 Testing

### Manual Testing Scenarios
1. **User Authentication**
   - Login with valid credentials
   - Login with invalid credentials
   - Session timeout handling

2. **Customer Operations**
   - Create new account
   - Transfer funds
   - Apply for loan
   - View transaction history

3. **Admin Operations**
   - Add new user
   - Edit user details
   - Approve/reject loans
   - View system statistics

## 🔧 Configuration

### Database Connection
Update `DatabaseUtil.java` with your MySQL credentials.

### Session Timeout
Modify `web.xml` to adjust session timeout (default: 30 minutes).

### Error Pages
Customize error handling in `error.jsp` and `web.xml`.

## 🚀 Deployment

### Production Considerations
1. **Database Security**: Use strong passwords and restricted access
2. **HTTPS**: Enable SSL/TLS for secure communication
3. **Logging**: Implement proper logging and monitoring
4. **Backup**: Regular database backups
5. **Performance**: Database indexing and connection pooling

### Environment Variables
Consider using environment variables for database credentials in production.

## 📝 API Endpoints

### Authentication
- `POST /login` - User authentication
- `GET /logout` - User logout

### Customer Operations
- `GET /account` - View accounts
- `POST /account` - Create account or transfer funds
- `GET /loan` - View loans
- `POST /loan` - Apply for loan

### Admin Operations
- `GET /userManagement` - Manage users
- `POST /userManagement` - Add/edit/delete users
- `POST /loan` - Approve/reject loans

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

## 🆘 Support

For support and questions:
- Check the error logs
- Verify database connectivity
- Ensure all required libraries are included
- Check Tomcat configuration

## 🔄 Updates and Maintenance

### Regular Maintenance
- Database optimization
- Security updates
- Performance monitoring
- User feedback integration

### Future Enhancements
- Mobile app development
- API development
- Advanced reporting
- Multi-currency support
- Integration with payment gateways

---

**Note**: This is a demonstration application. For production use, implement additional security measures, proper logging, and comprehensive testing.
