using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Security.Cryptography;

namespace PagoElectronico.Entidades
{
    public class Usuario
    {
        public int Id { get; set; }
        public int IdRol { get; set; }
        public string Username { get; set; }
        public string PasswordEnc { get; set; }
        public bool Habilitado { get; set; }
        public decimal Intentos { get; set; }
        public Rol Rol { get; set; }
        private bool esAdministrador;

        public string PassEncriptada(string PasswordEnc)
        {
            return GetSHA256Encriptado(PasswordEnc);
        }

        public bool EsAdministrador
        {
            get { return esAdministrador; }
            set
            {
                /* si es cliente es true */
                if (value)
                {
                    esAdministrador = true;
                    esCliente = false;
                }
            }
        }


        private bool esCliente;
        public bool EsCliente
        {
            get { return esCliente; }
            set
            {
                if (value)
                {
                    esCliente = true;
                    esAdministrador = false;
                }
            }
        }


        public Usuario()
        {
        }

        private string BytesAString(byte[] bytes)
        {
            StringBuilder str = new StringBuilder();

            for (int i = 0; i < bytes.Length; i++)

                str.AppendFormat("{0:x2}", bytes[i]);

            return str.ToString();

        }
        private string ComputeHash(string input, HashAlgorithm algorithm)
        {
            Byte[] inputBytes = Encoding.UTF8.GetBytes(input);

            Byte[] hashedBytes = algorithm.ComputeHash(inputBytes);

            return BitConverter.ToString(hashedBytes);
        }

        private string GetSHA256Encriptado(string password)
        {
            SHA256 sha256 = new SHA256Managed();
            byte[] sha256Bytes = Encoding.Default.GetBytes(password);
            byte[] cryString = sha256.ComputeHash(sha256Bytes);
            string resultEncriptado = string.Empty;
            for (int i = 0; i < cryString.Length; i++)
            {
                resultEncriptado += cryString[i].ToString("X");
            }

            return resultEncriptado;
        }

        public string _Sha256Encriptar(string input)
        {
            byte[] data = new byte[input.Length];
            data = Encoding.UTF8.GetBytes(input);


            byte[] result;
            SHA256 shaM = new SHA256Managed();
            result = shaM.ComputeHash(data);

            StringBuilder output = new StringBuilder();
            foreach (byte b in result)
            {
                output.Append(Convert.ToChar(b));
            }
            return output.ToString();

        }

        public Boolean estaEsTuPass(String pass)
        {
            String realPass = this.GetSHA256Encriptado(pass);
            //"E6B87050BFCB8143FCB8DB170A4DC9ED0D904DDD3E2A4AD1B1E8DCFDC9BE7" desde app
            //"E6B87050BFCB8143FCB8DB0170A4DC9ED00D904DDD3E2A4AD1B1E8DC0FDC9BE7" desde Usuario en base
            //"E6B87050BFCB8143FCB8DB0170A4DC9ED00D904DDD3E2A4AD1B1E8DC0FDC9BE7"
            if (realPass.CompareTo(this.PasswordEnc) == 0)
            {
                return true;
            }

            return false;
        }

        public Boolean estoyHabilitado()
        {
            return this.Habilitado;
        }
    }
}
