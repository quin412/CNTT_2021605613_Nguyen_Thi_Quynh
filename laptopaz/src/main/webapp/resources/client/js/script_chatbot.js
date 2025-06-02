function toggleChat() {
    const chatPopup = document.getElementById('chatPopup');
    chatPopup.style.display = chatPopup.style.display === 'block' ? 'none' : 'block';
}
function convertLinks(text) {
    const urlRegex = /(https?:\/\/[^\s]+)/g;
    return text.replace(urlRegex, url => `<a href="${url}" target="_blank">${url}</a>`);
}

function sendMessage() {
    const chatBody = document.getElementById('chatBody');
    const chatInput = document.getElementById('chatInput');
    const message = chatInput.value;

    if (message.trim() !== '') {
        // Display user message
        const userMessage = document.createElement('div');
        userMessage.classList.add('chat-message', 'user');
        const userText = document.createElement('p');
        userText.textContent = message;
        userMessage.appendChild(userText);
        chatBody.appendChild(userMessage);

        chatInput.value = '';
        chatBody.scrollTop = chatBody.scrollHeight;

        // Add "waiting" indicator
        const waitingMessage = document.createElement('div');
        waitingMessage.classList.add('chat-message', 'bot');
        const waitingText = document.createElement('p');
        waitingText.textContent = 'Waiting...';
        waitingMessage.appendChild(waitingText);
        chatBody.appendChild(waitingMessage);
        chatBody.scrollTop = chatBody.scrollHeight;

        // Send message to backend
        fetch('http://127.0.0.1:5000/query', {
            method: 'POST',
            body: JSON.stringify({ query: message }),
            mode: 'cors',
            headers: {
                'Content-Type': 'application/json',
            },
        })
            .then(response => response.json())
            .then(response => {
                chatBody.removeChild(waitingMessage);

                const botMessage = document.createElement('div');
                botMessage.classList.add('chat-message', 'bot');
                const botText = document.createElement('p');

                // Lấy đúng key từ response
                let text = response.answer || response.response || 'Sorry, something went wrong.';
                botText.innerHTML = convertLinks(text);
                botMessage.appendChild(botText);
                chatBody.appendChild(botMessage);
                chatBody.scrollTop = chatBody.scrollHeight;
            })

            .catch(error => {
                console.error('Error:', error);

                // Remove "waiting" indicator
                chatBody.removeChild(waitingMessage);

                // Display error message
                const botMessage = document.createElement('div');
                botMessage.classList.add('chat-message', 'bot');
                const botText = document.createElement('p');
                botText.textContent = 'Error connecting to the server.';
                botMessage.appendChild(botText);
                chatBody.appendChild(botMessage);
                chatBody.scrollTop = chatBody.scrollHeight;
            });
    }
}
function sendQuickMessage(message) {
    const chatBody = document.getElementById('chatBody');

    // Hiển thị tin nhắn user từ nút bấm
    const userMessage = document.createElement('div');
    userMessage.classList.add('chat-message', 'user');
    userMessage.innerHTML = `<p>${message}</p>`;
    chatBody.appendChild(userMessage);

    // Tương tự sendMessage, hiển thị waiting
    const waitingMessage = document.createElement('div');
    waitingMessage.classList.add('chat-message', 'bot');
    waitingMessage.innerHTML = `<p>Waiting...</p>`;
    chatBody.appendChild(waitingMessage);

    chatBody.scrollTop = chatBody.scrollHeight;

    // Gửi request backend
    fetch('http://127.0.0.1:5000/query', {
        method: 'POST',
        body: JSON.stringify({ query: message }),
        headers: { 'Content-Type': 'application/json' },
        mode: 'cors',
    })
        .then(res => res.json())
        .then(data => {
            chatBody.removeChild(waitingMessage);

            const botMessage = document.createElement('div');
            botMessage.classList.add('chat-message', 'bot');
            const botText = data.answer || data.response || 'Xin lỗi, mình chưa hiểu.';
            botMessage.innerHTML = `<p>${convertLinks(botText)}</p>`;
            chatBody.appendChild(botMessage);

            chatBody.scrollTop = chatBody.scrollHeight;
        })
        .catch(err => {
            chatBody.removeChild(waitingMessage);

            const botMessage = document.createElement('div');
            botMessage.classList.add('chat-message', 'bot');
            botMessage.innerHTML = `<p>Lỗi kết nối server.</p>`;
            chatBody.appendChild(botMessage);

            chatBody.scrollTop = chatBody.scrollHeight;
            console.error(err);
        });
}

// Add Enter key event listener
document.getElementById('chatInput').addEventListener('keydown', function (event) {
    if (event.key === 'Enter') {
        event.preventDefault(); // Prevent default form submission (if applicable)
        sendMessage();
    }
});