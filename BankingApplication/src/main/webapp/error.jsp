<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error - Banking Application</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #333;
        }
        
        .error-container {
            background: white;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 600px;
            text-align: center;
        }
        
        .error-icon {
            font-size: 4em;
            margin-bottom: 20px;
            color: #dc3545;
        }
        
        .error-title {
            font-size: 2em;
            color: #dc3545;
            margin-bottom: 15px;
        }
        
        .error-message {
            color: #666;
            margin-bottom: 30px;
            font-size: 1.1em;
            line-height: 1.6;
        }
        
        .error-details {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 30px;
            text-align: left;
            font-family: monospace;
            font-size: 0.9em;
            color: #495057;
            max-height: 200px;
            overflow-y: auto;
        }
        
        .error-code {
            background: #e9ecef;
            color: #495057;
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 0.9em;
            font-weight: 600;
            display: inline-block;
            margin-bottom: 20px;
        }
        
        .action-buttons {
            display: flex;
            gap: 15px;
            justify-content: center;
            flex-wrap: wrap;
        }
        
        .btn {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 12px 24px;
            border: none;
            border-radius: 8px;
            text-decoration: none;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.2s ease;
            display: inline-block;
        }
        
        .btn:hover {
            transform: translateY(-2px);
        }
        
        .btn-secondary {
            background: #6c757d;
        }
        
        .btn-danger {
            background: #dc3545;
        }
        
        @media (max-width: 768px) {
            .error-container {
                margin: 20px;
                padding: 30px 20px;
            }
            
            .action-buttons {
                flex-direction: column;
            }
            
            .btn {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <div class="error-container">
        <div class="error-icon">⚠️</div>
        <h1 class="error-title">Oops! Something went wrong</h1>
        
        <c:choose>
            <c:when test="${not empty requestScope['javax.servlet.error.status_code']}">
                <div class="error-code">
                    Error ${requestScope['javax.servlet.error.status_code']}
                </div>
                <p class="error-message">
                    <c:choose>
                        <c:when test="${requestScope['javax.servlet.error.status_code'] == 404}">
                            The page you're looking for doesn't exist. It might have been moved or deleted.
                        </c:when>
                        <c:when test="${requestScope['javax.servlet.error.status_code'] == 500}">
                            We're experiencing technical difficulties. Please try again later.
                        </c:when>
                        <c:otherwise>
                            An unexpected error occurred. Please try again or contact support.
                        </c:otherwise>
                    </c:choose>
                </p>
            </c:when>
            <c:otherwise>
                <div class="error-code">
                    System Error
                </div>
                <p class="error-message">
                    An unexpected error occurred while processing your request. 
                    Our team has been notified and is working to resolve the issue.
                </p>
            </c:otherwise>
        </c:choose>
        
        <c:if test="${not empty requestScope['javax.servlet.error.message']}">
            <div class="error-details">
                <strong>Error Details:</strong><br>
                ${requestScope['javax.servlet.error.message']}
            </div>
        </c:if>
        
        <c:if test="${not empty exception}">
            <div class="error-details">
                <strong>Exception:</strong><br>
                ${exception.class.name}: ${exception.message}
            </div>
        </c:if>
        
        <div class="action-buttons">
            <a href="javascript:history.back()" class="btn btn-secondary">Go Back</a>
            <a href="login.jsp" class="btn">Go to Login</a>
            <a href="javascript:location.reload()" class="btn btn-danger">Try Again</a>
        </div>
        
        <div style="margin-top: 30px; color: #666; font-size: 0.9em;">
            <p>If this problem persists, please contact our support team.</p>
            <p>Error ID: ${requestScope['javax.servlet.error.request_uri']}</p>
        </div>
    </div>

    <script>
        // Auto-refresh after 30 seconds if it's a 500 error
        setTimeout(function() {
            if (window.location.href.includes('error.jsp')) {
                window.location.reload();
            }
        }, 30000);
        
        // Log error details to console for debugging
        console.error('Error occurred:', {
            url: window.location.href,
            timestamp: new Date().toISOString(),
            userAgent: navigator.userAgent
        });
    </script>
</body>
</html>
