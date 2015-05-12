using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using PagoElectronico.DAO;
using PagoElectronico.Entidades;

namespace PagoElectronico.Controller
{
    public class RolModel : BaseModel<Rol>
    {
        public Rol BuscarByUsuario(Usuario afiliado)
        {
            RolDAO rolDAO = new RolDAO();
            return rolDAO.BuscarByUsuario(afiliado.Id);
        }

        public DataTable Funcionalidades(Rol rol)
        {
            RolDAO rolDAO = new RolDAO();

            return rolDAO.Funcionalidad(rol);
        }
        public Rol Buscar(int Rol_ID)
        {
            Rol rol = new Rol();

            RolDAO rolDAO = new RolDAO();

            rol = rolDAO.Buscar(Rol_ID);


            return rol;

        }

        public DataTable Filtrar(Rol rol)
        {
            RolDAO rolDAO = new RolDAO();

            return rolDAO.Filtrar(rol);
        }



        public Rol ObtenerRolCliente()
        {
            RolDAO rolDao = new RolDAO();
            return rolDao.ObtenerRolCliente();
        }

        public DataTable ListarClientes()
        {

            RolDAO rolDAO = new RolDAO();
            return rolDAO.ListarClienteDT();

        }

        public DataTable ListarIncluyendoEliminados()
        {
            RolDAO rolDAO = new RolDAO();
            return rolDAO.ListarDT();

            //return rolDAO.ListarDT(true);
        }

        public DataTable Listar()
        {
            RolDAO rolDAO = new RolDAO();

            return rolDAO.ListarDT();
        }
        /*
        public DataTable Listar(TipoFuncionalidad func)
        {
            RolDAO rolDAO = new RolDAO();

            return rolDAO.ListarDT(func);
        }
        */


        // agrego el rol y su listado de funcionalidades para ese rol

        public override void Agregar(Rol unRol)
        {
            RolDAO rolDAO = new RolDAO(true);
            unRol = rolDAO.Agregar(unRol);
        }

        // agrega las funcionalidades permitidas a un rol

        protected void AgregarFuncionalidades(Rol unRol)
        {
            RolFuncionalidadController cPermiso = new RolFuncionalidadController();
            //agrego solo las funcionalidades permitidas
            foreach (Funcionalidad unaFuncionalidad in unRol.Funcionalidad.FindAll(f => f.Habilitada))
            {
                cPermiso.Agregar(new RolFuncionalidad(unRol, unaFuncionalidad));
            }

        }

        // elimina todos los permisos y el rol fisicamente

        public override void Borrar(int id)
        {
            RolDAO rolDAO = new RolDAO();

            rolDAO.Eliminar(id);

        }
        public override void Borrar(Rol value)
        {
            base.Borrar(value);
        }
        public override void Modificar(Rol unRol)
        {
            //SqlConnector cnn = SqlConnector.Instance;

            try
            {

                RolDAO rolDAO = new RolDAO();
                rolDAO.Modificar(unRol);

                RolFuncionalidadController cPermiso = new RolFuncionalidadController();
                this.ModificarFuncionalidades(unRol);

            }
            catch (Exception ex)
            {
                //rollback

                throw ex;
            }
        }
        protected void ModificarFuncionalidades(Rol unRol)
        {
            RolFuncionalidadController cPermiso = new RolFuncionalidadController();
            //elimino todas y despues agrego
            cPermiso.Borrar(unRol.IdRol);

            AgregarFuncionalidades(unRol);
        }
        public override bool Validar(Rol value, out string mensajeError)
        {
            throw new NotImplementedException();
        }

        public DataTable ListarDTTodos()
        {
            RolDAO rDAO = new RolDAO();

            return rDAO.ListarDTTodos();

        }

        public DataTable ListarDTipos()
        {
            RolDAO rDAO = new RolDAO();

            return rDAO.ListarDTipos();

        }
        /*   public override void AgregarTipo(Rol value)
           {
               throw new NotImplementedException();
           }

           public override void ModificarTipo(Rol value)
           {
               throw new NotImplementedException();
           }

           public override void BorrarTipo(int id)
           {
               throw new NotImplementedException();
           }

           public override bool ValidarTipo(Rol value, out string mensajeError)
           {
               throw new NotImplementedException();
           }
           */
    }
}
