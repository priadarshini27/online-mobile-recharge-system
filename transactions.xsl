<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/transactions">

<html>
<head>
<title>Transaction History</title>

<style>

body{
font-family:Arial;
background-image: url(images/bg.jpg);
padding:40px;
}

h2{
color: white;
}

table{
border-collapse:collapse;
width:100%;
background:white;
box-shadow:0 4px 10px rgba(0,0,0,0.1);
}

th{
background:#0072ff;
color:white;
padding:12px;
}

td{
padding:10px;
border-bottom:1px solid #ddd;
text-align:center;
}

tr:nth-child(even){
background:#f8f9ff;
}

tr:hover{
background:#eef3ff;
}

</style>

</head>

<body>

<h2>Recharge Transaction History</h2>

<table>

<tr>
<th>ID</th>
<th>Mobile</th>
<th>Amount</th>
<th>Payment Method</th>
<th>Status</th>
<th>Date</th>
</tr>

<xsl:for-each select="transaction">

<tr>

<td><xsl:value-of select="id"/></td>

<td><xsl:value-of select="mobile"/></td>

<td>₹<xsl:value-of select="amount"/></td>

<td><xsl:value-of select="payment"/></td>

<td><xsl:value-of select="status"/></td>

<td><xsl:value-of select="date"/></td>

</tr>

</xsl:for-each>

</table>

</body>
</html>

</xsl:template>

</xsl:stylesheet>