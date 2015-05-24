
﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using PagoElectronico.Entidades;
using PagoElectronico.DAO;

namespace PagoElectronico.Controller
{
    public class RolFuncionalidadController : BaseModel<RolFuncionalidad>
    {
        public override void Agregar(RolFuncionalidad unRolFuncionalidad)
        {

            RolFuncionalidadDAO RolFuncionalidadDAO = new RolFuncionalidadDAO();

            RolFuncionalidadDAO.Agregar(unRolFuncionalidad);


        }

        public override void Borrar(int id)
        {
            RolFuncionalidadDAO RolFuncionalidadDAO = new RolFuncionalidadDAO();
            RolFuncionalidadDAO.Eliminar(id);
        }
        /**
        public override void Borrar(RolFuncionalidad value)
        {
            base.Borrar(value);
        }
        **/
        public override void Modificar(RolFuncionalidad unRolFuncionalidad)
        {
            throw new NotImplementedException();
        }

        public override bool Validar(RolFuncionalidad value, out string mensajeError)
        {
            throw new NotImplementedException();
        }
    }
}
