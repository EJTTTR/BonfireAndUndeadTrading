using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using System.Net.Mail;
using System.IO;
using System.Net;

namespace CapaNegocio
{
    public class CNRecursos
    {
        public static string ConvertirSHA256(string input)
        {
            StringBuilder stringBuilder = new StringBuilder();

            using (SHA256 hash = SHA256Managed.Create())
            {
                Encoding enc = Encoding.UTF8;
                byte[] result = hash.ComputeHash(enc.GetBytes(input));

                foreach (byte b in result)
                {
                    stringBuilder.Append(b.ToString("x2"));
                }
            }
            return stringBuilder.ToString();
        }

        public static string GenerarContrasena()
        {
            string contra = Guid.NewGuid().ToString("N").Substring(0,8);
            return contra;
        }

        public static bool EnviarCorreo(string email, string asunto, string mensaje)
        {
            string from = "engeltejadaxd2004@gmail.com";
            string pass = "azephbpyphqhkauo";
            bool resultado = false;
            try
            { 
                //confi del cliente SMTP
                var smtp = new SmtpClient()
                {
                    Credentials = new NetworkCredential(from, pass),
                    Host = "smtp.gmail.com",
                    Port = 587,
                    EnableSsl = true
                };

                //mensaje
                MailMessage msg = new MailMessage();
                msg.From = new MailAddress(from);
                msg.To.Add(email);
                msg.Subject = asunto;
                msg.Body = mensaje;
                msg.IsBodyHtml = true;
                smtp.Send(msg);

                resultado = true;
            }
            catch (SmtpException smtpEx)
            {
                resultado = false;
                Console.WriteLine($"SMTP Error: {smtpEx.Message}");
            }
            catch (Exception ex)
            {
                resultado = false;
                Console.WriteLine($"Error: {ex.Message}");
            }
            return resultado;
        }

        public static string ConversionBase64(string ruta, out bool conversion) 
        {
            string textBase64 = string.Empty;
            conversion = true;

            try
            {
                byte[] bytes = File.ReadAllBytes(ruta);
                textBase64 = Convert.ToBase64String(bytes);
            }
            catch 
            {
                conversion = false;
            }
            return textBase64;
        }
    }
}
