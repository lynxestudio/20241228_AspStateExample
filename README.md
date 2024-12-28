# This example shows how to manage states in an ASP.NET Web Application


<strong>Introduction</strong>
<p align="justify">
Most Web applications need to store, retrieve, and display information as a user navigates between the different pages that make up the web site. This type of information is known as state data, and is used to add coherence and functionality to the Web Application.
In a typical Web application, a user might visit a page and fill out a form, performing actions such as typing in text boxes, selecting option buttons, selecting items in drop-down lists, and so on. The user might then click a button to submit the information to the web application running on the server. Prior to ASP.NET, a Web page did not automatically preserve the information on the page after the submission.
The submission of control data to the same page is commonly referred to as <i>postback</i>, and the mechanism for storing the state of controls throughout the postback cycle is called ViewState. 
</p>
<strong>What is ViewState?</strong>
<p align="justify">
ViewState is the mechanism provided by ASP.NET for preserving the contents and the state of the controls on a Web Page when a user has entered data and submitted the form and when the page is re-displayed. You do not have to write code to implement ViewState; ASP.NET implements ViewState for you by storing the appropriate information in a hidden field on the form.
</p>
<strong>What is Control State?</strong>
<p>
If you are developing your own Web Server control, you can specify that it maintains state data even if ViewState is disabled for the page on which it runs. You can achieve this by working with the control's ControlState data. ASP.NET enables controls to preserve their <strong>ControlState</strong> even when <strong>ViewState</strong> is disabled.
</p>
<strong>The application Object</strong>
<p>
An ASP.NET application consists of the pages, files, handlers, and code that reside within a given virtual directory and its subdirectories. ASP.NET maintains a <strong>single Application</strong> object for each application on your Web server. This object is created in memory when the first user makes the first request to the application, and it remains in memory until the application is stopped. An application is stopped when the server is shut down, the Web Server is stopped, or the site (or Web Service) is stopped. An application can also be stopped by an application failure or when you deploy a new version of the application.
</p>
<p>
When an object is stored in the Application object, any page in the Web application can access it, regardless of which user has made the request. However, because the application can restart without warning, you should not use the Application object to cache critical information, and you should always check that a value exists in the cache before you attempt to use it.
</p>
<strong>Application Events</strong>
<p>
The <strong>Application</strong> object exposes three important events:
</p>
<ul>
<li><strong>Application Start:</strong> This event is raised when the first user makes the first request to a page in the application. If the server, Web service, or Web site has been restarted, this event will fire on the next request.</li>
<li><strong>Application End:</strong> This event fires when the server, Web service, or Web site is stopped or restarted. This event is a good place to clean up resources that the application has used. This event will not be raised if an application failure occurs.</li>
<li><strong>Application Error:</strong> This event is raised if an otherwise-unhandled exception occurs in the application. If the error is handled with a try...catch block, or at the page level, this event will not fire.This event is a good place to write code to handle any unexpected errors that may occur in the application.</li>
</ul>
<p>
To write handlers for these events, add a file called <strong>Global.asax</strong> to the root folder of your application, and then place the event handlers in it.
</p>
<strong>The Session Object</strong>
<p>
An ASP.NET Session object is an object that represents a user's visit to your application. A session begins when the user makes the first request for a page or file. Sessions usually expire when a configurable period of time has elapsed since the last request. You can set this time by using the <strong>Session.Timeout</strong> property. You can also end a session by calling the <strong>Session.Abandon</strong> method.
The <strong>Session</strong> object, as does the <strong>Application</strong> object, enables you to share values between ASP.NET pages. However, each user has his own <strong>Session</strong> object, so you should use the <strong>Session</strong> object only to store information specific to a user.
</p>
<strong>Session Events</strong>
<p>
The <strong>Session</strong> object exposes two important events:
<ul>
<li><strong>Session.Start: </strong>This event fires when a user begins a session in your application by requesting a page. It is a good place to initialize values that are specific to a user.</li>
<li><strong>Session.End:</strong> This event fires when a user session expires or when the <strong>Session.Abandon</strong> method is called.</li>
</ul>
</p>
<p>
<strong>Note</strong> The <strong>Session.End</strong> event is fired only when the default <strong>InProc</strong> mode is used for storing session state. If you are using <strong>StateServer</strong> mode or <strong>SQLServer</strong> mode, the event does not fire.
</p>
