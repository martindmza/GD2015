using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Windows.Forms;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.IO;
using System.Collections;

namespace PagoElectronico
{
    class Conexion
    {
        private static Conexion dbInstance;
        private readonly SqlConnection conexion;
        private String conectionString;

        //get singleton
        public static Conexion getInstance()
        {
            if (dbInstance == null)
            {
                MessageBox.Show("new instance!!!");
                dbInstance = new Conexion();
            }
            else {
                MessageBox.Show("used instance!!!");
            }

            return dbInstance;
        }

        //construct
        public Conexion()
        {

            string fileName = "credentials.json";
            string path = @"C:\Users\Administrador\Desktop\Backup\FACULTAD\Gestión de Datos\2015\TP\GD2015\Aplicacion Desktop\PagoElectronico\PagoElectronico\config\";
            conectionString = "";

            //obtengo los datos de conexión a la base de datos
            try {
                //recorro el file de configuración
                System.IO.StreamReader file = new System.IO.StreamReader(path+fileName);
                string line;
                while ((line = file.ReadLine()) != null) {
                     conectionString += line + ";";
                }
                //quito el ultimo punto y coma
                conectionString = conectionString.Remove(conectionString.Length - 1);
            
            } catch (DirectoryNotFoundException e) {
                Console.WriteLine("Config file not found" + e);
                return;
            }
            
            try
            {
                this.conexion = new SqlConnection(conectionString);
                conexion.Open();
                conexion.Close();
            }
            catch (SqlException e)
            {
                MessageBox.Show("Database conection error :" + e);
            }
             
        }
        //--------------------------------------------------------------------

        //--------------------------------------------------------------------
        public void conectar()
        {
            this.conexion.Open();
        }
        //--------------------------------------------------------------------

        //--------------------------------------------------------------------
        public void cerrar()
        {
            this.conexion.Close();
        }
        //--------------------------------------------------------------------

        //--------------------------------------------------------------------
        //ejecuciones SQL sin retorno
        public void consultar(String query)
        {

            try
            {
                conexion.Open();
                SqlCommand comando = new SqlCommand(query, conexion);
                SqlDataReader resultado = comando.ExecuteReader();
                conexion.Close();
            }

            catch (SqlException e)
            {
                MessageBox.Show(e.Message);
            }

        }
        //--------------------------------------------------------------------

        //--------------------------------------------------------------------
        //ejecuciones SQL con retorno
        public DataTable consultar_datatable(String query)
        {
            SqlDataAdapter adapter = new SqlDataAdapter(query, this.conexion);  //Ejecuta la consulta

            DataTable tabla = new DataTable();
            adapter.Fill(tabla);									//abre y cierra de forma implícita la conexión
            return tabla;
        }
        //--------------------------------------------------------------------

        //--------------------------------------------------------------------
        public static string hash(string input)
        {
            SHA256 hash = SHA256.Create();

            // Convertir la cadena en un array de bytes y calcular hash
            byte[] data = hash.ComputeHash(Encoding.UTF8.GetBytes(input));

            // Copiar cada elemento del array a un
            // StringBuilder en formato hexadecimal
            StringBuilder sBuilder = new StringBuilder();
            for (int i = 0; i < data.Length; i++)
            {
                sBuilder.Append(data[i].ToString("x2"));
            }

            return sBuilder.ToString();
        }
        //--------------------------------------------------------------------
    }
}
