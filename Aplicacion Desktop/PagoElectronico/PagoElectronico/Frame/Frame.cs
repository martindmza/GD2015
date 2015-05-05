using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace PagoElectronico.Frame
{
    public partial class Frame : Form
    {

        private String query;

        //______________________________________________________________________________________________________________________
        public Frame()
        {
            InitializeComponent();
            this.label1.Text = Login.Login.Usuario_Nombre;

            //Busco los roles del usuario
            query = "   SELECT Roles_Cod_Rol,                               " +
                    "          Roles_Detalle                                " +
                    "     FROM Roles                                        " +
                    "     JOIN Usuarios_Roles ON Roles_Cod_Rol = Cod_Rol    " +
                    "    WHERE Cod_Usuario =" + Login.Login.Usuario_Cod;

            DataTable roles;
            Conexion cone = new Conexion();
            roles = cone.consultar_datatable(query);

            //Si encuentra más de un rol, muestra opciones de rol con el cual entrar
            if (roles.Rows.Count > 1)
            {
                /*
                Form abmroles = new Roles_Elegir(roles, this);
                abmroles.MdiParent = this;
                abmroles.Show();
                */
            }

        }
        //______________________________________________________________________________________________________________________

        //----------------------------------------------------------------------------------------------------------------------
        public void set_label1(String valor)
        {
            label1.Text = Login.Login.Usuario_Nombre + valor;
        }
        //----------------------------------------------------------------------------------------------------------------------

        
    }
}
