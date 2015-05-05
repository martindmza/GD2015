using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using PagoElectronico.Entidades;
using System.Data;
using System.Data.SqlClient;
using PagoElectronico.Herramientas;

namespace PagoElectronico.DAO
{
    public class FuncionalidadDAO : BaseDAO<Funcionalidad>
    {

        public void Guardar(Funcionalidad unaFuncionalidad, int Rol_ID)
        {
            SqlConnector cnn = SqlConnector.Instance;

            cnn.executeQueryOnly("exec LA_LIGA.RolFuncionalidad_Insertar " + Rol_ID + " ," + unaFuncionalidad.IdFuncionalidad);

        }

        public List<Funcionalidad> Listar(int Rol_ID)
        {
            SqlConnector cnn = SqlConnector.Instance;
            Funcionalidad unaF;
            List<Funcionalidad> laFuncionalidad = new List<Funcionalidad>();

            DataTable dt = cnn.executeQuery("exec LA_LIGA.Fun_ListarByRol " + Rol_ID);

            foreach (DataRow dr in dt.Rows)
            {

                unaF = new Funcionalidad();
                unaF.IdFuncionalidad = (int)dr["fun_ID"];
                unaF.Nombre = dr["fun_nombre"].ToString();

                //es o cero o uno
                if (dr["Activo"].ToString() == "1")
                    unaF.Habilitada = true;
                else
                    unaF.Habilitada = false;


                laFuncionalidad.Add(unaF);

            }

            return laFuncionalidad;

        }

        public override int AgregarYRetornarID(Funcionalidad entity)
        {
            throw new NotImplementedException();
        }

        public override Funcionalidad Agregar(Funcionalidad entity)
        {
            throw new NotImplementedException();
        }

        public override Funcionalidad Modificar(Funcionalidad entity)
        {
            throw new NotImplementedException();
        }

        public override void Eliminar(Funcionalidad entity)
        {
            throw new NotImplementedException();
        }

        public override void Eliminar(int entityID)
        {
            throw new NotImplementedException();
        }

        public override DataTable Listar()
        {
            DataTable dt = new DataTable();
            using (SqlCommand command = InitializeConnection("Funcionalidad_Listar"))
            {
                SqlDataAdapter da = new SqlDataAdapter(command);
                da.Fill(dt);
            }
            if (dt.Rows.Count > 0)
                return dt;
            else
                return null;
        }

        public override DataTable Filtrar(Funcionalidad entity)
        {
            throw new NotImplementedException();
        }
        public DataTable listar(Rol rol)
        {
            if (rol != null)
            {
                DataTable dt = new DataTable();
                using (SqlCommand command = InitializeConnection("[FuncionalidadListarPorRol]"))
                {
                    command.Parameters.AddWithValue("@id", rol.IdRol);
                    SqlDataAdapter da = new SqlDataAdapter(command);
                    da.Fill(dt);
                }

                if (dt.Rows.Count > 0)
                    return dt;
            }
            return null;

        }

    }
}
