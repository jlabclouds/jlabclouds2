// Global variables for Copilot chat
let chatMessages = [];
const MAX_MESSAGES = 50;

// Dropdown toggle functions with added click outside handling
function toggleExamGuidesDropdown(event) {
    event.stopPropagation();
    const menu = document.getElementById('examguidesDropdownMenu');
    menu.style.display = (menu.style.display === 'block') ? 'none' : 'block';
}

function toggleAppsDropdown(event) {
    event.stopPropagation();
    const menu = document.getElementById('appsDropdownMenu');
    menu.style.display = (menu.style.display === 'block') ? 'none' : 'block';
}

// Close dropdowns when clicking outside
document.addEventListener('click', function(event) {
    const dropdowns = document.querySelectorAll('.dropdown-menu');
    dropdowns.forEach(dropdown => {
        if (dropdown.style.display === 'block') {
            dropdown.style.display = 'none';
        }
    });
});

// Enhanced icon dialog with error handling
function showIconDialog(title, description, url) {
    try {
        const dialog = document.createElement('dialog');
        dialog.className = 'icon-dialog';
        
        dialog.innerHTML = `
            <div class="dialog-content">
                <h3>${title || 'Information'}</h3>
                <p>${description || 'No description available.'}</p>
                <div class="dialog-buttons">
                    ${url ? `<button onclick="window.open('${url}', '_blank')">Visit Site</button>` : ''}
                    <button onclick="this.closest('dialog').close()">Close</button>
                </div>
            </div>
        `;
        
        document.body.appendChild(dialog);
        dialog.showModal();

        // Add click outside to close
        dialog.addEventListener('click', (e) => {
            if (e.target === dialog) dialog.close();
        });
    } catch (error) {
        console.error('Error showing dialog:', error);
    }
}

// Improved GitHub Copilot chat
function openCopilotChat() {
    const chatWindow = document.createElement('dialog');
    chatWindow.className = 'copilot-chat';
    
    chatWindow.innerHTML = `
        <div class="chat-header">
            <h3>GitHub Copilot Chat</h3>
            <button class="close-btn" onclick="this.closest('dialog').close()">×</button>
        </div>
        <div class="chat-messages" id="chatMessages"></div>
        <div class="chat-input">
            <input type="text" placeholder="Ask a question..." id="chatInput"
                   onkeypress="if(event.key === 'Enter') sendMessage()">
            <button onclick="sendMessage()">Send</button>
        </div>
    `;
    
    document.body.appendChild(chatWindow);
    chatWindow.showModal();

    // Add click outside to close
    chatWindow.addEventListener('click', (e) => {
        if (e.target === chatWindow) chatWindow.close();
    });
}

// Add message sending functionality
function sendMessage() {
    const input = document.getElementById('chatInput');
    const messagesDiv = document.getElementById('chatMessages');
    
    if (input.value.trim()) {
        const message = {
            text: input.value,
            timestamp: new Date().toLocaleTimeString(),
            type: 'user'
        };
        
        chatMessages.push(message);
        if (chatMessages.length > MAX_MESSAGES) chatMessages.shift();
        
        updateChatDisplay(messagesDiv);
        input.value = '';
    }
}

function updateChatDisplay(messagesDiv) {
    if (!messagesDiv) return;
    
    messagesDiv.innerHTML = chatMessages
        .map(msg => `
            <div class="message ${msg.type}">
                <span class="timestamp">${msg.timestamp}</span>
                <p>${msg.text}</p>
            </div>
        `)
        .join('');
    
    messagesDiv.scrollTop = messagesDiv.scrollHeight;
}


// Replace the existing toggleDropdown function with these two separate functions:

// Exam Guides Dropdown
function toggleExamGuidesDropdown() {
    const menu = document.getElementById('examguidesDropdownMenu');
    menu.style.display = (menu.style.display === 'block') ? 'none' : 'block';
}

// Apps Dropdown
function toggleAppsDropdown() {
    const menu = document.getElementById('appsDropdownMenu');
    menu.style.display = (menu.style.display === 'block') ? 'none' : 'block';
}
