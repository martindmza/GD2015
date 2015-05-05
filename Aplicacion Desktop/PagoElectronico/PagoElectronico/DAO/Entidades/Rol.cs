using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PagoElectronico.Entidades
{
    public class Rol
    {

        public int IdRol { get; set; }
        public string Nombre { get; set; }
        public bool Habilitada { get; set; }

        public Rol()
        {
            this.Funcionalidad = new List<Funcionalidad>();
        }

        public Rol(int IdRol, string NombreRol)
        {
            this.IdRol = IdRol;
            this.Nombre = NombreRol;
            this.Habilitada = true;
        }
        public Rol(char Tipo, int IdRol, string NombreRol, bool Activo)
        {
            this.IdRol = IdRol;
            this.Nombre = NombreRol;
            this.Habilitada = Activo;
        }
        public List<Funcionalidad> Funcionalidad { get; set; }
    }
}
