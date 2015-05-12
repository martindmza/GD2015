using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PagoElectronico.Controller
{
    public abstract class BaseModel<TEntity>
    {
        public abstract void Agregar(TEntity value);

        public abstract void Modificar(TEntity value);

        public abstract void Borrar(int id);

        public virtual void Borrar(TEntity value)
        {
            throw new NotImplementedException();
        }

        public abstract bool Validar(TEntity value, out string mensajeError);
    }
}
