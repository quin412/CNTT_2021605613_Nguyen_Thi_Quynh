<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link href="/client/css/style_chatbot.css" rel="stylesheet">
<style>
    .chat-options {
        margin-top: 10px;
        display: flex;
        flex-wrap: wrap;
        gap: 8px;
    }

    .chat-options button {
        padding: 6px 12px;
        background-color: #f5f5f5;
        border: 1px solid #ccc;
        border-radius: 16px;
        cursor: pointer;
        font-size: 14px;
        transition: background-color 0.3s ease;
        white-space: nowrap;
    }

    .chat-options button:hover {
        background-color: #e0e0e0;
    }


</style>
<div class="widget">
    <div class="chat-popup" id="chatPopup">
        <div class="chat-header" onclick="toggleChat()">💬 Chat Box</div>
        <div class="chat-body" id="chatBody">
            <div class="chat-message bot">
                <p>Xin chào, tôi có thể giúp gì cho bạn!</p>
                <div class="chat-options">
                    <button onclick="sendQuickMessage('Giới thiệu về cửa hàng')">🏬 Cửa hàng</button>
                    <button onclick="sendQuickMessage('Liên hệ hỗ trợ')">💬 Hỗ trợ</button>
                    <button onclick="sendQuickMessage('Hướng dẫn mua hàng')">🛒 Mua hàng</button>
                    <button onclick="sendQuickMessage('Hướng dẫn bảo hành')">🛠️ Bảo hành</button>
                    <button onclick="sendQuickMessage('Giới thiệu laptop')">💻 Laptop</button>
                </div>
            </div>

        </div>

        <div class="chat-footer">
            <input type="text" id="chatInput" placeholder="Send messsage...">
            <button onclick="sendMessage()">Gửi</button>
        </div>
    </div>
    <button class="open-chat-btn" onclick="toggleChat()"><i class="fas fa-robot"></i></button>
</div>
<script src="/client/js/script_chatbot.js"></script>