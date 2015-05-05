using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PagoElectronico.Entidades
{
    public class RolFuncionalidad
    {
        public Rol Rol;
        public Funcionalidad Funcionalidad;

        public RolFuncionalidad()
        {
        }
        public RolFuncionalidad(Rol unRol, Funcionalidad unaFuncionalidad)
        {
            this.Rol = unRol;
            this.Funcionalidad = unaFuncionalidad;
        }
    }
}
