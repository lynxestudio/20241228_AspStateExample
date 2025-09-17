using System;

namespace Examples.ManagingStates
{
    public class UserSession
    {
        private string _id;
        private string _username;
        private string _password;
        public UserSession(string id,string userName,string password)
        {
            this.Id = id;
            this.UserName = userName;
            this.Password = password;
            this.StartTime = DateTime.Now;
        }

        public string Id { get; set; }
        public string UserName { get; set; }
        public string Password 
        {
            get { return _password; }
            set { 
                char[] oldChars = value.ToCharArray();
                char[] newChars = new char[oldChars.Length];
                for(var i = 0;i < oldChars.Length;i++)
	            {
                    newChars[i] = '*';
	            }
                _password = new string(newChars);
            } 
        }
        public string Department { get; set; }
        public DateTime StartTime { get; private set; }
    }
}
