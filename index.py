from flask import Flask, render_template, request, redirect, url_for, flash, session
from flask_mysqldb import MySQL
import bcrypt
  
app = Flask(__name__)

#Conexion a la base de datos
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'Fabian'
app.config['MYSQL_PASSWORD'] = 'fabian1997'
app.config['MYSQL_DB'] = 'bd_tecno-agro'
mysql = MySQL(app)

# Settings
app.secret_key = 'clavesecreta'

# Semilla de encriptamiento
semilla = bcrypt.gensalt()
  
@app.route("/") 
def index(): 
    if 'nombres' in session:
        return render_template("inicio.html")
    else:
        return render_template('index.html')

@app.route('/login', methods=['GET', 'POST'])
def Login():
    if request.method == 'GET':
        if 'nombres' in session:
            return render_template("inicio.html")
        else:
            return render_template('login.html')
    else:
        correo = request.form['correoLogin']
        contrasena = request.form['contrasenaLogin']
        password_encode = contrasena.encode('utf-8')

        cur = mysql.connection.cursor()
        sql=('SELECT `nombresUsuario`,`correoUsuario`, `contrasenaUsuario` FROM `usuarios` WHERE `correoUsuario` = %s')
        cur.execute(sql,[correo])
        usuario = cur.fetchone()
        cur.close()

        if (usuario != None):
            password_encriptado_encode = usuario[2].encode()

            if (bcrypt.checkpw(password_encode,password_encriptado_encode)):  
                session['nombres'] = usuario[0]        
                session['correo'] = correo
                return render_template('inicio.html')
            else:
                flash('La contraseña es incorrecta!', 'danger')
                return render_template("login.html")
        else:
            flash('Email incorrecto!', 'danger')
            return render_template("login.html")

@app.route('/agregarUsuario', methods=['POST'])
def agregarUsuario():
    if request.method == 'POST':
        nombres = request.form['nombres']
        documento = request.form['documento']
        telefono = request.form['telefono']
        correo = request.form['correo']
        contrasena = request.form['contrasena']

        if not (nombres and  documento and telefono and correo and contrasena):
            flash('No puede haber campos vacios!', 'danger')
        else:
            password_encode = contrasena.encode('utf-8')
            password_encriptado = bcrypt.hashpw(password_encode, semilla)
            cur = mysql.connection.cursor()
            cur.execute('INSERT INTO `usuarios`(`nombresUsuario`, `documentoUsuario`, `telefonoUsuario`, `correoUsuario`, `contrasenaUsuario`) VALUES (%s, %s, %s, %s, %s)', (nombres, documento, telefono, correo, password_encriptado))
            mysql.connection.commit()

            #session['nombres'] = nombres
            #session['correo'] = correo
            #session['contrasena'] = password_encriptado

            flash('Cuenta creada exitosamente', 'success')

        return redirect(url_for('Login'))

@app.route('/inicio')
def Inicio():
    if 'nombres' in session:
        return render_template("inicio.html")
    else:
        return render_template('login.html')

@app.route('/salir')
def Salir():
    session.clear()
    return redirect(url_for('index'))

if __name__ == "__main__": 
        app.run(debug=True, port= 8000)   