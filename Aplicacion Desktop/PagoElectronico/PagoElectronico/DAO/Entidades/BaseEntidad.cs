using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PagoElectronico.Entidades
{
    public abstract class BaseEntidad<TEntity>
    {
        public int Id { get; set; }
        public string Nombre { get; set; }
    }
}
