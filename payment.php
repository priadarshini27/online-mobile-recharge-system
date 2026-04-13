<?php
$conn = new mysqli("localhost", "root", "", "ors");

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$plan_id = $_GET['plan_id'];
$amount = $_GET['amount'];
$mobile = $_GET['mobile'];
$payment = $_GET['payment'];

$user_id = $_GET['user_id'];

if (!$user_id) {
    die("User not logged in!");
}

// Generate transaction reference

function generateTransactionRef() {
    return "TXN" . time();
}

$txn_ref = generateTransactionRef();

// Insert transaction
$sql = "INSERT INTO transactions 
        (user_id, plan_id, mobile_number, amount, payment_method, payment_status, transaction_ref)
        VALUES (?, ?, ?, ?, ?, 'SUCCESS', ?)";

$stmt = $conn->prepare($sql);
$stmt->bind_param("iisdss", $user_id, $plan_id, $mobile, $amount, $payment, $txn_ref);

if ($stmt->execute()) {

    echo "<h2>Payment Successful</h2>";
    echo "<p>Transaction ID: $txn_ref</p>";
    echo "<p>Amount: ₹$amount</p>";
    echo "<br><a href='http://localhost:8080/ors/home.jsp'>Go Back to Home</a>";

} else {
    echo "Payment Failed!";
}

$stmt->close();
$conn->close();
?>
