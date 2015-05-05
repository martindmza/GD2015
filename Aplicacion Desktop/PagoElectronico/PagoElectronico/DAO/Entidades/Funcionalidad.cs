using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Collections;

namespace PagoElectronico.Entidades
{
    public class Funcionalidad
    {
        public int IdFuncionalidad { get; set; }
        public string Nombre { get; set; }
        public bool Habilitada { get; set; }


        public Funcionalidad()
        { }
        public Funcionalidad(string unNombreFuncionalidad)
        {
            Nombre = unNombreFuncionalidad;
        }
        public Funcionalidad(int unIDFuncionalidad, string unNombreFuncionalidad, bool Activa)
        {
            IdFuncionalidad = unIDFuncionalidad;
            Nombre = unNombreFuncionalidad;
            Habilitada = Activa;
        }

    }

}
