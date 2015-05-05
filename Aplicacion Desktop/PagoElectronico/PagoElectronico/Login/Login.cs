using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace PagoElectronico.Login
{
    public partial class Login : Form
    {
        private String query;
        public static String Usuario_Cod;             //Guarda el id del usuario logueado
        public static String Usuario_Nombre;          //Guarda el nombre del usuario logueado
        public static String Usuario_Rol_Detalle;     //Guarda el nombre del rol del usuario
        public static decimal Usuario_Rol;            //Guarda el codigo del rol del usuario

        public Login()
        {
            InitializeComponent();
        }

        //---------------------------------------------------------------------------------------------------------------------
        private void button1_Click(object sender, EventArgs e){
            
            String usuario = this.usuario.Text;
            String password = Conexion.hash(this.password.Text);

            query =        "SELECT  Usuarios_Cod_Usuario,                               "+  
                           "        Usuarios_Usuario,                                   "+
                           "        Usuarios_Password                                   "+
                           "  FROM  Usuarios                                            "+
                           " WHERE  Usuarios_Usuario    ='"+usuario+"'                  "+
                           "   AND  Usuarios_Password   ='"+password+"'                 ";

            DataTable usuarios;
            Conexion cone   = Conexion.getInstance();
            usuarios        = cone.consultar_datatable(query);

            if(usuarios.Rows.Count != 0)                                                //si encontró el usuario
            {
                Usuario_Cod    = usuarios.Rows[0]["Usuarios_Cod_Usuario"].ToString();   //Guardo el cod de usuario
                Usuario_Nombre = usuarios.Rows[0]["Usuarios_Usuario"].ToString();       //Guardo el nombre de usuario
                                                                                        //o se puede usar: resultado["Usuarios_Cod_Usuario"].ToString();
                Frame.Frame frame = new Frame.Frame();
                this.Hide();
                frame.Show();
            }
            else
            {
                MessageBox.Show("Contraseña incorrecta");
            }

        }
        //---------------------------------------------------------------------------------------------------------------------
    }
}

