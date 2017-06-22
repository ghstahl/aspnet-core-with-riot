# aspnet-core-with-riot


## External Logins 
This project has twitter enabled as an external login, and you must provide your own twitter credentials.

```
app.UseIdentity()
                .UseTwitterAuthentication(
                    new TwitterOptions()
                    {
                        ConsumerKey = Configuration["Authentication:Twitter:ConsumerKey"],
                        ConsumerSecret = Configuration["Authentication:Twitter:ConsumerSecret"]
                    });
                   
```
[security-app-secrets](https://docs.microsoft.com/en-us/aspnet/core/security/app-secrets#security-app-secrets)

```
{
  "Authentication:Twitter:ConsumerKey": "{ My ConsumerKey  }",
  "Authentication:Twitter:ConsumerSecret" : "{ My ConsumerSecret  }"
}
```
## Email and SMS
This project has password recovery and two-factor authentication enabled.  So you need an email server.  I use papercut!  
Install it and have it run at startup.  Configure the listening port to be: **32525**

[papercut email](https://papercut.codeplex.com/)

```
    public class AuthMessageSender : IEmailSender, ISmsSender
    {
        public async Task SendEmailAsync(string email, string subject, string message)
        {
            var emailMessage = new MimeMessage();

            emailMessage.From.Add(new MailboxAddress("Joe Bloggs", "jbloggs@example.com"));
            emailMessage.To.Add(new MailboxAddress("", email));
            emailMessage.Subject = subject;
            emailMessage.Body = new TextPart("plain") { Text = message };

            using (var client = new SmtpClient())
            {
                client.LocalDomain = "some.domain.com";
                await client.ConnectAsync("127.0.0.1", 32525, SecureSocketOptions.None).ConfigureAwait(false);
                await client.SendAsync(emailMessage).ConfigureAwait(false);
                await client.DisconnectAsync(true).ConfigureAwait(false);
            }
        }

        public async Task SendSmsAsync(string number, string message)
        {
            await SendEmailAsync("sms@sms.com", "Some SMS Message", message);
        }
    }
```
