using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using PagoElectronico.Entidades;
using PagoElectronico.Herramientas;

using System.Data.SqlClient;

namespace PagoElectronico.DAO
{
    public class RolDAO : BaseDAO<Rol>
    {
        public RolDAO()
            : base(false)
        {

        }

        public RolDAO(bool conTransaccion)
            : base(conTransaccion)
        {

        }

        public readonly int Rol_ID_Cliente = 2;
        public readonly int Rol_ID_Administradores = 3;

        public Rol BuscarByUsuario(int IdUsuario)
        {
            Rol rol = new Rol();
            using (SqlCommand command = InitializeConnection("Rol_BuscarByUser"))
            {
                command.Parameters.Add("@IdUsuario", System.Data.SqlDbType.Int).Value = IdUsuario;
                SqlDataReader dataReader = command.ExecuteReader();
                while (dataReader.Read())
                {
                    rol.IdRol = (int)dataReader["IdRol"];
                    rol.Nombre = (string)dataReader["NombreRol"];
                }
            }
            return rol;
        }

        public DataTable Funcionalidad(Rol rol)
        {
            DataTable dt = new DataTable();
            SqlCommand command = InitializeConnection("Rol_Funcionalidad");
            command.Parameters.Add("NombreRol", System.Data.SqlDbType.NVarChar, 50).Value = rol.Nombre;

            SqlDataAdapter da = new SqlDataAdapter(command);

            da.Fill(dt);

            return dt;
        }
        public Rol Buscar(int Rol_IdRol)
        {
            Rol rol = new Rol();
            DataTable dt = new DataTable();
            SqlCommand command = InitializeConnection("Fun_ListarByRol");
            command.Parameters.Add("Rol_ID", System.Data.SqlDbType.Int).Value = Rol_IdRol;

            SqlDataAdapter da = new SqlDataAdapter(command);

            da.Fill(dt);
            rol.IdRol = (int)dt.Rows[0][0];
            rol.Nombre = dt.Rows[0][1].ToString();
            FuncionalidadDAO fdao = new FuncionalidadDAO();
            rol.Funcionalidad = fdao.Listar(rol.IdRol);
            return rol;
        }

        public override DataTable Filtrar(Rol rol)
        {
            DataTable dt = new DataTable();
            SqlCommand command = InitializeConnection("Rol_Filtrar");
            command.Parameters.Add("NombreRol", System.Data.SqlDbType.NVarChar, 50).Value = rol.Nombre;

            SqlDataAdapter da = new SqlDataAdapter(command);

            da.Fill(dt);

            return dt;
        }

        public Rol ObtenerRolCliente()
        {
            Rol rol = new Rol();
            using (SqlCommand command = InitializeConnection("Rol_Buscar"))
            {
                command.Parameters.Add("IdRol", System.Data.SqlDbType.Int).Value = Rol_ID_Cliente;
                SqlDataReader dataReader = command.ExecuteReader();
                while (dataReader.Read())
                {
                    rol.IdRol = (int)dataReader["IdRol"];
                    rol.Nombre = (string)dataReader["NombreRol"];
                }
            }
            return rol;
        }

        public Rol ObtenerRolAdministrador()
        {
            Rol rol = new Rol();
            using (SqlCommand command = InitializeConnection("Rol_Buscar"))
            {
                command.Parameters.Add("IdRol", System.Data.SqlDbType.Int).Value = Rol_ID_Administradores;
                SqlDataReader dataReader = command.ExecuteReader();
                while (dataReader.Read())
                {
                    rol.IdRol = (int)dataReader["IdRol"];
                    rol.Nombre = (string)dataReader["NombreRol"];
                }
            }
            return rol;
        }

        public DataTable ListarAdministradorDT()
        {
            DataTable dt = new DataTable();
            SqlCommand command = InitializeConnection("Rol_Buscar");
            command.Parameters.Add("IdRol", System.Data.SqlDbType.Int).Value = Rol_ID_Administradores;

            SqlDataAdapter da = new SqlDataAdapter(command);

            da.Fill(dt);
            return dt;
        }

        public DataTable ListarClienteDT()
        {
            DataTable dt = new DataTable();
            SqlCommand command = InitializeConnection("Rol_Buscar");
            command.Parameters.Add("IdRol", System.Data.SqlDbType.Int).Value = Rol_ID_Cliente;
            SqlDataAdapter da = new SqlDataAdapter(command);
            da.Fill(dt);
            return dt;
        }
        public void Habilitado(Rol unRol)
        {
            SqlCommand command = InitializeConnection("Rol_Deshabilitar");
            command.Parameters.Add("IdRol", System.Data.SqlDbType.Int).Value = unRol.IdRol;
            command.ExecuteNonQuery();
        }

        // devuelvo un datatable para el combobox
        public DataTable ListarDT()
        {
            DataTable dt = new DataTable();
            using (SqlCommand command = InitializeConnection("Rol_Listar"))
            {
                SqlDataAdapter da = new SqlDataAdapter(command);
                da.Fill(dt);
            }
            if (dt.Rows.Count > 0)
                return dt;
            return null;
        }




        public override Rol Agregar(Rol entity)
        {
            try
            {
                DataTable dt = new DataTable();

                SqlCommand command = InitializeConnection("Rol_Crear");

                command.Parameters.Add("descripcion", System.Data.SqlDbType.NVarChar, 50).Value = entity.Nombre;
                SqlDataAdapter da = new SqlDataAdapter(command);

                da.Fill(dt);
                entity.IdRol = int.Parse(dt.Rows[0][0].ToString());


                /* this.AgregarFuncionalidad(unRol)*/
                RolFuncionalidadDAO cRolFuncionalidad = new RolFuncionalidadDAO(this.Transaction);
                /*agrego solo las funcionalidades permitidas */
                foreach (Funcionalidad unaFuncionalidad in entity.Funcionalidad.FindAll(f => f.Habilitada))
                {
                    cRolFuncionalidad.Agregar(new RolFuncionalidad(entity, unaFuncionalidad));
                }

                this.Commit();

                return entity;
            }
            catch (Exception excepcion)
            {
                this.RollBack();
                throw excepcion;

            }
        }
        public override int AgregarYRetornarID(Rol entity)
        {

            DataTable dt = new DataTable();

            SqlCommand command = InitializeConnection("Rol_Agregar");

            command.Parameters.Add("Nombre", System.Data.SqlDbType.NVarChar, 50).Value = entity.Nombre;
            command.Parameters.Add("Activo", System.Data.SqlDbType.Bit).Value = entity.Habilitada; /* tengo que crearlo activado*/

            SqlDataAdapter da = new SqlDataAdapter(command);

            da.Fill(dt);


            return int.Parse(dt.Rows[0][0].ToString());


        }


        // elimina todos los permisos y el rol fisicamente

        public override void Eliminar(int entityID)
        {

            SqlCommand command = InitializeConnection("Rol_BajaLogica");

            command.Parameters.Add("IdRol", System.Data.SqlDbType.Int).Value = entityID;
            /*   command.Parameters.Add("Activo", System.Data.SqlDbType.Bit).Value = entity.Activo; */

            command.ExecuteNonQuery();
            //CerrarConexion();
        }

        public override void Eliminar(Rol entity)
        {
            throw new NotImplementedException();
        }

        /*modifica el nombre de un ROl y si esta habilitado o no
        En caso de que este deshabilitado limpia todos sos permisos */

        public override Rol Modificar(Rol unRol)
        {

            SqlCommand command = InitializeConnection("Rol_Modificar");

            command.Parameters.Add("IdRol", System.Data.SqlDbType.Int).Value = unRol.IdRol;
            command.Parameters.Add("NombreRol", System.Data.SqlDbType.NVarChar, 50).Value = unRol.Nombre;
            command.Parameters.Add("Activo", System.Data.SqlDbType.Bit).Value = unRol.Habilitada;


            command.ExecuteNonQuery();
            return null;

        }
        private Int16 BoolToInt(bool unBool)
        {
            Int16 Habilitar;
            if (unBool)
                Habilitar = 1;
            else
                Habilitar = 0;

            return Habilitar;
        }

        public DataTable ListarDTTodos()
        {
            SqlCommand cmd = InitializeConnection("Rol_ListarTodosTipos");
            SqlDataAdapter da = new SqlDataAdapter(cmd);

            DataTable dt = new DataTable();

            da.Fill(dt);
            return dt;
        }
        public DataTable ListarDTipos()
        {
            SqlCommand cmd = InitializeConnection("Rol_ListarTipos");
            SqlDataAdapter da = new SqlDataAdapter(cmd);

            DataTable dt = new DataTable();

            da.Fill(dt);
            return dt;
        }

        /* public override Rol AgregarTipo(Rol entity)
         {
             throw new NotImplementedException();
         }
    
         public override void EliminarTipo(int entityID)
         {
             throw new NotImplementedException();
         }
         public override void EliminarTipo(Rol entity)
         {
             throw new NotImplementedException();
         }
         public override Rol ModificarTipo(Rol entity)
         {
             throw new NotImplementedException();
         }
         */

        public override DataTable Listar()
        {
            throw new NotImplementedException();
        }
    }


}
