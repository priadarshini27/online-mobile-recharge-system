function loadRecentTransactions() {

    const xhr = new XMLHttpRequest();
    xhr.open("GET", "TransactionServlet?limit=4", true);

    xhr.onreadystatechange = function () {

        if (xhr.readyState === 4 && xhr.status === 200) {

            const xml = xhr.responseXML;
            const transactions = xml.getElementsByTagName("transaction");

            const container = document.getElementById("transactionList");

            let html = "";

            // JavaScript Array
            let transactionArray = [];

            // Control statement (for loop)
            for (let i = 0; i < transactions.length; i++) {

                const t = transactions[i];

                const amount = t.getElementsByTagName("amount")[0].textContent;
                const mobile = t.getElementsByTagName("mobile")[0].textContent;
                const status = t.getElementsByTagName("status")[0].textContent;
                const date = t.getElementsByTagName("date")[0].textContent;

                // JavaScript Object
                const transaction = {
                    amount: amount,
                    mobile: mobile,
                    status: status,
                    date: date
                };

                // Store object in array
                transactionArray.push(transaction);

                // Control statement (ternary)
                const statusClass = status === "SUCCESS" ? "success" : "pending";

                html += `
                    <div class="transaction-item ${statusClass}">
                        <h4>₹${transaction.amount}</h4>
                        <p><strong>Number:</strong> ${transaction.mobile}</p>
                        <p><strong>Date:</strong> ${transaction.date}</p>
                        <span class="status ${statusClass}">${transaction.status}</span>
                    </div>
                `;
            }

            container.innerHTML = html;
        }
    };

    xhr.send();
}
function addCardHoverEffects() {
    document.querySelectorAll('.dashboard-card').forEach(card => {
        card.addEventListener('mouseenter', function() {
            const icon = this.querySelector('.card-icon i');
            icon.style.transform = 'scale(1.2)';
            icon.style.transition = 'transform 0.3s ease';
        });
        
        card.addEventListener('mouseleave', function() {
            const icon = this.querySelector('.card-icon i');
            icon.style.transform = 'scale(1)';
        });
    });
}

function openUserSettings() {
    window.location.href = "user-settings.jsp";
}
function openRecharge() {
    window.location.href="recharge.jsp";/////////
}

function openPlans() {
    window.location.href = "plans.jsp";
}

function openHistory() {
    window.location.href="TransactionServlet?limit=all";
}

// Add to existing script.js file
function goToLogin() {
    window.location.href="login.jsp"///////
}

function goToRegister() {
    window.location.href="register.jsp"///////////
}

function sendMessage(){

    let input = document.getElementById("chat-input");
    let message = input.value;

    if(message.trim() === "") return;

    let chatBody = document.getElementById("chat-body");

    chatBody.innerHTML += "<div><b>You:</b> " + message + "</div>";

    fetch("chatbot", {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded"
        },
        body: "message=" + encodeURIComponent(message)
    })
    .then(response => response.text())
    .then(data => {
        chatBody.innerHTML += "<div><b>Bot:</b> " + data + "</div>";
        chatBody.scrollTop = chatBody.scrollHeight;
    });

    input.value="";
}

document.addEventListener('DOMContentLoaded', function() {
    //updateUserInfo();
    //displayTransactions();
    loadRecentTransactions();
    addCardHoverEffects();
});