using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using PagoElectronico.Properties;

namespace PagoElectronico.Herramientas
{
    public static class Config
    {
        #region Metodos
        public static string Get(string key)
        {
            return Settings.Default[key].ToString();
        }

        #endregion

        #region Propiedades

        public static class Base
        {
            public static string ConnectionString
            {
                get { return Settings.Default.Connection; }
            }
        }
    }
}

        #endregion


