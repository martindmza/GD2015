using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using PagoElectronico.Entidades;
using System.Data;

namespace PagoElectronico.DAO
{
    public class RolFuncionalidadDAO : BaseDAO<RolFuncionalidad>
    {
        public RolFuncionalidadDAO()
            : base(false)
        {
        }

        public RolFuncionalidadDAO(SqlTransaction transaction)
            : base(true)
        {
            this.Transaction = transaction;
        }

        public override RolFuncionalidad Agregar(RolFuncionalidad entity)
        {
            SqlCommand command = InitializeConnection("Rol_Funcionalidad_Agregar");

            command.Parameters.Add("idRol", System.Data.SqlDbType.Int).Value = entity.Rol.IdRol;
            command.Parameters.Add("idFuncionalidad", System.Data.SqlDbType.Int).Value = entity.Funcionalidad.IdFuncionalidad;


            command.ExecuteNonQuery();


            //this.CerrarConexion();
            return null;

        }
        public override int AgregarYRetornarID(RolFuncionalidad entity)
        {
            throw new NotImplementedException();
        }
        public override void Eliminar(int entityID)
        {
            SqlCommand command = InitializeConnection("RolFuncionalidad_EliminarByRol");

            command.Parameters.Add("Rol_ID", System.Data.SqlDbType.Int).Value = entityID;

            command.ExecuteNonQuery();
        }
        public override void Eliminar(RolFuncionalidad entity)
        {
            throw new NotImplementedException();
        }

        public override RolFuncionalidad Modificar(RolFuncionalidad entity)
        {
            SqlCommand command = InitializeConnection("RolFuncionalidad_Modificar");

            command.Parameters.Add("Rol_ID", System.Data.SqlDbType.Int).Value = entity.Rol.IdRol;
            command.Parameters.Add("Fun_ID", System.Data.SqlDbType.Int).Value = entity.Funcionalidad.IdFuncionalidad;


            command.ExecuteNonQuery();


            //this.CerrarConexion();
            return null;

        }

        public override DataTable Listar()
        {
            throw new NotImplementedException();
        }

        public override DataTable Filtrar(RolFuncionalidad entity)
        {
            throw new NotImplementedException();
        }
    }
}
