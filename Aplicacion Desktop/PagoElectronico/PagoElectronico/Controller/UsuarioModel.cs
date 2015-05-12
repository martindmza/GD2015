using System;
using PagoElectronico.DAO;
using PagoElectronico.Entidades;
using PagoElectronico.Herramientas;

using System.Security.Cryptography;
using System.Text;

namespace PagoElectronico.Controller
{
    public class UsuarioModel : BaseModel<Usuario>
    {
        public void CambiarPassword(Usuario user, string nuevoPass)
        {
            UsuarioDAO udb = new UsuarioDAO();
            udb.CambiarPassword(user.Username, nuevoPass);
        }
        public void ModificarRol(int usuario_ID, Rol rol)
        {
            UsuarioDAO udb = new UsuarioDAO();
            udb.ModificarRol(usuario_ID, rol.IdRol);
        }

        public Usuario LeerDatos(string Username)
        {
            Usuario u = new Usuario();
            UsuarioDAO dbu = new UsuarioDAO();
            u = dbu.Buscar(Username);

            return u;
        }

        public Usuario ModificarUsuario(string Username)
        {
            Usuario u = new Usuario();
            UsuarioDAO dbu = new UsuarioDAO();
            u = dbu.Buscar(Username);
            u.Username = Username;
            SqlConnector cnn = SqlConnector.Instance;
            cnn.executeQueryOnly("UPDATE SACA_EL_TRIGGER_QUE_HAY_EN_VOS.Usuario SET Habilitado=1 Where Username = Username");



            return u;
        }

        public Usuario CrearUsuarioPorDefault(string Username, bool cliente)
        {
            Usuario user = new Usuario();
            user.Username = Username;
            //user.Password = user.PassEncriptada( "password");
            user.PasswordEnc = "password";

            RolModel rolController = new RolModel();

            user.Rol = rolController.ObtenerRolCliente();

            return user;
        }

        public Usuario CrearClientePorDefault(string Username)
        {
            return CrearUsuarioPorDefault(Username, true);
        }


        public string TryLogIn(string unUserName, string unPassword)
        {
            UsuarioDAO db = new UsuarioDAO();
            return db.TryLogIn(unUserName, unPassword);

        }


        public override void Agregar(Usuario unUsuario)
        {
            UsuarioDAO dbUser = new UsuarioDAO();
            unUsuario.Id = dbUser.AgregarYRetornarID(unUsuario);
            /*despues agrego si es cliente o Administrador */
        }

        public override void Modificar(Usuario value)
        {
            throw new NotImplementedException();
        }

        public override void Borrar(int id)
        {
            throw new NotImplementedException();
        }

        public Usuario Buscar(Usuario value)
        {
            UsuarioDAO udb = new UsuarioDAO();
            return udb.Buscar(value.Username);

        }
        public override bool Validar(Usuario value, out string mensajeError)
        {
            bool rs = false;
            mensajeError = "";
            if (this.ExisteUsuario(value.Username))
            {
                mensajeError = "Usuario ya existente.";
                rs = true;
            }
            return rs;
        }

        private bool ExisteUsuario(string user_id)
        {
            return new UsuarioDAO().ExisteUsuario(user_id);
        }


    }
}
