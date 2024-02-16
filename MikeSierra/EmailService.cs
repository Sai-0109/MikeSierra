using System;
using System.Net;
using System.Net.Mail;
namespace MikeSierra
{
    using System;
    using System.Net;
    using System.Net.Mail;

    namespace MikeSierra
    {
        public class EmailService
        {
            public static void SendOTP(string toEmail, string otp)
            {
                string smtpServer = "smtp.gmail.com";
                int smtpPort = 465; 
                string smtpUsername = "sayalipwalse01@gmail.com";
                string smtpPassword = "password123";
                string senderEmail = "sayalipwalse01@gmail.com";

                using (SmtpClient smtpClient = new SmtpClient(smtpServer, smtpPort))
                {
                    smtpClient.UseDefaultCredentials = false;
                    smtpClient.Credentials = new NetworkCredential(smtpUsername, smtpPassword);
                    smtpClient.EnableSsl = true;

                    MailMessage mail = new MailMessage(senderEmail, toEmail)
                    {
                        Subject = "OTP for Email Verification",
                        Body = $"Your OTP for email verification is: {otp}",
                        IsBodyHtml = false
                    };

                    try
                    {
                        smtpClient.Send(mail);
                        Console.WriteLine($"OTP email sent to {toEmail}");
                    }
                    catch (Exception ex)
                    {
                        // Handle email sending failure (log or throw exception as needed)
                        Console.WriteLine($"Error sending email: {ex.Message}");
                    }
                }
            }
        }
    }


}
