using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using PagoElectronico.Entidades;
using System.Data.SqlClient;
using System.Security.Cryptography;

namespace PagoElectronico.DAO
{
    public class UsuarioDAO : BaseDAO<Usuario>
    {
        //No transaccional
        public UsuarioDAO(): base(false){}

        //Transaccional
        public UsuarioDAO(SqlTransaction transaction): base(true)
        {
            this.Transaction = transaction;
        }

        public void ModificarRol(int IdUsuario, int IdRol)
        {
            SqlCommand command = InitializeConnection("Usuario_CambiarRol");

            command.Parameters.Add("@IdUsuario", System.Data.SqlDbType.Int).Value = IdUsuario;
            command.Parameters.Add("@IdRol", System.Data.SqlDbType.Int).Value = IdRol;

            command.ExecuteNonQuery();
        }

        public void CambiarPassword(string Username, string nuevoPass)
        {
            SqlCommand command = InitializeConnection("Usuario_CambiarPassword");
            command.Parameters.Add("Usuario_UserName", System.Data.SqlDbType.NVarChar, 50).Value = Username;
            command.Parameters.Add("Usuario_Password", System.Data.SqlDbType.NVarChar, 100).Value = new Usuario().PassEncriptada(nuevoPass);
            command.ExecuteNonQuery();
        }

        private Usuario _CargarTodo(DataTable dt)
        {
            Usuario u = new Usuario();


            u.Username = dt.Rows[0]["Username"].ToString();
            u.PasswordEnc = dt.Rows[0]["PasswordEnc"].ToString();
            u.IdRol = (int)(dt.Rows[0]["IdRol"]);
            u.Id = (int)(dt.Rows[0]["IdUsuario"]);
            u.Habilitado = ((bool)(dt.Rows[0]["Habilitado"])) == true;
            //   u.FailedPwdAttempt = ((int)(dt.Rows[0]["FailedPwdAttempt"])) == 0;

            /*Tipo de Rol */
            RolDAO dbr = new RolDAO();
            u.Rol = dbr.Buscar((int)(dt.Rows[0]["IdRol"]));
            return u;
        }
        public Usuario Buscar(string userName)
        {
            Usuario u = new Usuario();

            DataTable dt = new DataTable();

            SqlCommand command = InitializeConnection("Usuario_buscar");

            command.Parameters.Add("@nom_usuario", System.Data.SqlDbType.VarChar, 50).Value = userName;

            SqlDataAdapter da = new SqlDataAdapter(command);

            da.Fill(dt);

            if (dt.Rows.Count > 0)
                u = this._CargarTodo(dt);
            else
                return null;

            return u;

        }


        /* intenta loguear, y si falla devuelve el motivo en el string*/

        public string TryLogIn(string u, string p)
        {
            DataTable dt = new DataTable();

            SqlCommand command = InitializeConnection("Usuario_Validar");

            command.Parameters.Add("Username", System.Data.SqlDbType.NVarChar, 50).Value = u;
            command.Parameters.Add("PasswordEnc", System.Data.SqlDbType.NVarChar, 100).Value = new Usuario().PassEncriptada(p);

            SqlDataAdapter da = new SqlDataAdapter(command);

            da.Fill(dt);

            if (dt.Rows.Count > 0)
                return "Error";
            else
                return "";/*sin error */

        }


        public override int AgregarYRetornarID(Usuario entity)
        {
            DataTable dt = new DataTable();

            SqlCommand command = InitializeConnection("Usuario_Agregar");

            command.Parameters.Add("Username", System.Data.SqlDbType.NVarChar, 255).Value = entity.Username;
            command.Parameters.Add("PasswordEnc", System.Data.SqlDbType.NVarChar, 255).Value = entity.PassEncriptada(entity.PasswordEnc);
            command.Parameters.Add("IdRol", System.Data.SqlDbType.Int).Value = entity.Rol.IdRol;
            command.Parameters.Add("Habilitado", System.Data.SqlDbType.Bit).Value = entity.Habilitado;
            command.Parameters.Add("FailedPwdAttempt", System.Data.SqlDbType.Int).Value = entity.Intentos;


            SqlDataAdapter da = new SqlDataAdapter(command);

            da.Fill(dt);



            /* no estoy segura de esta parte */
            return int.Parse(dt.Rows[0][0].ToString());
        }
        public override Usuario Agregar(Usuario entity)
        {
            entity.Id = AgregarYRetornarID(entity);
            return entity;
        }

        public override Usuario Modificar(Usuario entity)
        {
            return new Usuario();
        }

        public override void Eliminar(Usuario entity)
        {
            throw new NotImplementedException();
        }

        public override void Eliminar(int entityID)
        {
            throw new NotImplementedException();
        }

        public bool ExisteUsuario(string user_name)
        {
            Usuario u = new Usuario();
            DataTable dt = new DataTable();

            SqlCommand command = InitializeConnection("SP_Existe_Usuario");

            command.Parameters.Add("Username", System.Data.SqlDbType.NVarChar, 255).Value = user_name;

            SqlDataAdapter da = new SqlDataAdapter(command);

            da.Fill(dt);

            return ((int)dt.Rows[0][0]) == 1;

        }

                public override DataTable Listar()
        {
            throw new NotImplementedException();
        }

        public override DataTable Filtrar(Usuario entity)
        {
            throw new NotImplementedException();
        }

        internal void bloquearUsuario(Usuario usuario)
        {

            using (SqlCommand command = InitializeConnection("[Bloquear_Usuario]"))
            {
                command.Parameters.Add("@id_usuario", System.Data.SqlDbType.NVarChar, 50).Value = usuario.Id;
                SqlDataReader dataReader = command.ExecuteReader();
            }
            
        }
    }

}
