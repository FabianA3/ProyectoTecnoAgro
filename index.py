from flask import Flask, render_template, request, redirect, url_for, flash
from flask_mysqldb import MySQL
  
app = Flask(__name__)

#Conexion a la base de datos
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'Fabian'
app.config['MYSQL_PASSWORD'] = 'fabian1997'
app.config['MYSQL_DB'] = 'bd_tecno-agro'
mysql = MySQL(app)

# Settings
app.secret_key = 'clavesecreta'
  
@app.route("/") 
def index(): 
    return render_template("index.html")

@app.route('/login')
def Login():
    return render_template("login.html")

@app.route('/agregarUsuario', methods=['POST'])
def agregarUsuario():
    if request.method == 'POST':
        nombres = request.form['nombres']
        documento = request.form['documento']
        telefono = request.form['telefono']
        correo = request.form['correo']
        contrasena = request.form['contrasena']
        cur = mysql.connection.cursor()
        cur.execute('INSERT INTO `usuarios`(`nombresUsuario`, `documentoUsuario`, `telefonoUsuario`, `correoUsuario`, `contrasenaUsuario`) VALUES (%s, %s, %s, %s, %s)', (nombres, documento, telefono, correo, contrasena))
        mysql.connection.commit()
        return redirect(url_for('Login'))

if __name__ == "__main__": 
        app.run(debug=True) 