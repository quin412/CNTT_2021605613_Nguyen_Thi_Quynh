function toggleChat() {
    const chatPopup = document.getElementById('chatPopup');
    chatPopup.style.display = chatPopup.style.display === 'block' ? 'none' : 'block';
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
                botText.textContent = text;
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

// Add Enter key event listener
document.getElementById('chatInput').addEventListener('keydown', function (event) {
    if (event.key === 'Enter') {
        event.preventDefault(); // Prevent default form submission (if applicable)
        sendMessage();
    }
});