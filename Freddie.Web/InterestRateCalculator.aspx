<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="InterestRateCalculator.aspx.cs" Inherits="Freddie.Web.InterestRateCalculator" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <h1>Super Fancy Interest Calculator</h1>
    <h6>It's fancy on the backend</h6>
    <div>
        Credit Score: <asp:TextBox runat="server" ID="tbCreditScore"></asp:TextBox> <br />
        Loan to Value: <asp:TextBox runat="server" ID="tbLTV"></asp:TextBox> <br />
        Monthly Income: <asp:TextBox runat="server" ID="tbIncome"></asp:TextBox> <br />
        Monthly Debt Payments: <asp:TextBox runat="server" ID="tbDebt"></asp:TextBox> <br />
        Loan Amount: <asp:TextBox runat="server" ID="tbAmount"></asp:TextBox> <br />

        <asp:Button runat="server" ID="btnCalculate" Text="Calculate" OnClick="btnCalculate_Click" />
        <br />
        <br />
        Calculated Interest Rate: <asp:Label runat="server" ID="lbInterestRate"></asp:Label>
    </div>
    </form>
</body>
</html>
