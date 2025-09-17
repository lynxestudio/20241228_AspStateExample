<%@ Page
	Language           = "C#"
	AutoEventWireup    = "true"
	ValidateRequest    = "false"
	EnableSessionState = "true"
%>
<%@ Import Namespace="Examples.ManagingStates" %>
<script runat="server">
    DataManager manager = new DataManager();
    //using the session to store values among different pages
    //dont forget to set the property EnableSessionState to true.
    public int SessionId 
    {
        get 
        {
            var id = Convert.ToInt32(Session["UserSessionId"]);
            return id;
        }
        set 
        {
            Session["UserSessionId"] = value;
        }
    }

    public List<UserSession> Sessions
    {
        get
        {
            List<UserSession> sessions = null;
            if (Session["Sessions"] == null)
                Session["Sessions"] = sessions;
            else
                sessions = (List<UserSession>)Session["Sessions"];
            return sessions;
        }
        set { Session["Sessions"] = value; }
    }
    
    private void Page_Load(object sender, EventArgs e)
    {
        //Every time the page loads, we set the session
        if (Sessions == null)
            Sessions = new List<UserSession>();
        else
            Bind();
        try
        {
            //this code improves efficiency by querying the data 
            //if the departments list is not in the cache
            List<Department> departments = (List<Department>)Cache["DepartmentList"];
            if (departments == null)
            {
                departments = manager.GetAll();
                Cache["DepartmentList"] = departments;
            }
            if (!IsPostBack)
            {
                //Every time the page loads, we set the session
                
                cbDepartments.Items.Clear();
                cbDepartments.DataSource = departments;
                cbDepartments.DataTextField = "Name";
                cbDepartments.DataValueField = "Id";
                cbDepartments.DataBind();
            }
        }
        catch (Exception ex)
        {
            lblError.Text = ex.Message;
        }
    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        lblMsg.Text = string.Empty;
        lblError.Text = string.Empty;
        try
        {
            var id = ++SessionId;
            string selectedDepartment = cbDepartments.SelectedItem.Text;
            UserSession userSession = new UserSession(id.ToString(),txtUserName.Text,txtPassword.Text);
            userSession.Department = selectedDepartment;
            Sessions.Add(userSession);
            Bind();
            lblMsg.Text = "Record added!";
            
        }
        catch (Exception ex)
        {
            lblError.Text = ex.Message;
        }
    }

    void Bind()
    {
        DataGrid.DataSource = null;
        DataGrid.DataSource = Sessions;
        DataGrid.DataBind();
    }
</script>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>Examples ManagingStates</title>
		<meta http-equiv="content-type" content="text/html; charset=utf-8" />
		<meta http-equiv="CACHE-CONTROL" content="NO-CACHE" />
		<meta http-equiv="PRAGMA" content="NO-CACHE" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
            <div class="container mt-10">
                <div class="row justify-content-center">
                    <div class="col-md-8">
                        <div class="card shadow-lg p-4">
                            <h2 class="card-title text-center mb-11">
                                Cache and Session example</h2>
                            <div class="col-sm-5">
                            <label for="txtUserName">User</label>
                                <asp:TextBox ID="txtUserName" 
                                name="txtUserName"
                                CssClass="form-control"
                                runat="server" ToolTip="UserName"></asp:TextBox>
                            </div>
                            <div class="col-sm-5">
                            <label for="txtPassword">Password</label>
                                <asp:TextBox ID="txtPassword"
                                name="txtPassword"
                                CssClass="form-control" 
                                runat="server" TextMode="Password" ToolTip="Password"></asp:TextBox>
                            </div>
                            <div class="col-sm-5">
                            <label>Department</label>
                                <asp:DropDownList ID="cbDepartments" runat="server" CssClass="form-control">
                                </asp:DropDownList>
                            </div>
                            <div class="col-sm-2">
                                <asp:Button ID="btnLogin" runat="server" Text="Login" 
                                    CssClass="btn btn-primary w-100" onclick="btnLogin_Click"/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        <hr />
        <div class="container">
            <asp:GridView ID="DataGrid" 
                runat="server" 
                AutoGenerateColumns="False"
                CssClass="table">
                    <Columns>
                        <asp:BoundField DataField="Id" HeaderText="Id" Visible="true"/>
                        <asp:BoundField DataField="UserName" HeaderText="User" Visible="true"/>
                        <asp:BoundField DataField="Password" HeaderText="Password" Visible="true"/>
                        <asp:BoundField DataField="Department" HeaderText="Department" Visible="true"/>
                        <asp:BoundField DataField="StartTime" Visible="true"
                        HeaderText="Start" 
                        DataFormatString="{0:yyyy/MM/dd hh:mm:ss}" />
                    </Columns>
                </asp:GridView>
        </div>
                <div class="container">
                <asp:Label ID="lblError" runat="server" ForeColor="Red"></asp:Label>
                </div>
                <div>
                    <asp:Label ID="lblMsg" runat="server" ForeColor="Green"></asp:Label>
                </div>
		</form>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
	</body>
</html>
