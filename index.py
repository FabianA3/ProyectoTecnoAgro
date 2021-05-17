from flask import Flask, render_template, request, redirect, url_for, flash, session
from flask_mysqldb import MySQL
import bcrypt
from werkzeug.utils import secure_filename
import os
from datetime import datetime,timedelta

UPLOAD_FOLDER = '/static/imgProductos'
ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg'}

fechaActual = datetime.now()
fechaAgregada = fechaActual + timedelta (days = 5)

app = Flask(__name__)

# Conexion a la base de datos
app.config['MYSQL_HOST'] = 'ik1eybdutgxsm0lo.cbetxkdyhwsb.us-east-1.rds.amazonaws.com'
app.config['MYSQL_USER'] = 'fxn2zdhe8ds0hcsa'
app.config['MYSQL_PASSWORD'] = 'gkc588lg8tp2pzzi'
app.config['MYSQL_DB'] = 'ch0tn8syk0hd57fh'

app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

mysql = MySQL(app)

# Settings
app.secret_key = 'clavesecreta'

# Semilla de encriptamiento
semilla = bcrypt.gensalt()

# Rutas
@app.route("/") 
def index(): 
    if 'nombres' in session:
        return render_template("inicio.html")
    else:
        cur = mysql.connection.cursor()
        cur.execute('SELECT * FROM `productos`')
        data = cur.fetchall()
        return render_template('index.html', productos = data)

@app.route('/inicio')
def Inicio():
    if 'nombres' in session:
        cur = mysql.connection.cursor()
        cur.execute('SELECT * FROM `productos`')
        data = cur.fetchall()
        session['fechaEnvio'] = FechaEnvio(fechaAgregada)
        return render_template("inicio.html", productos = data)
    else:
        return render_template('login.html')

def FechaEnvio(date):
    mes = ("Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre")
    return ("{d} de {m} del {y}".format(d = date.day, m = mes[date.month - 1], y = date.year))

@app.route('/misDatos')
def MisDatos():
    if 'nombres' in session:
        return render_template('misDatos.html')
    else:
        return render_template('index.html')
    
@app.route('/privacidad')
def Privacidad():
    if 'nombres' in session:
        return render_template('privacidad.html')
    else:
        return render_template('index.html')

@app.route('/seguridad')
def Seguridad():
    if 'nombres' in session:
        return render_template('seguridad.html')
    else:
        return render_template('index.html')

@app.route('/comunicaciones')
def Comunicaciones():
    if 'nombres' in session:
        return render_template('comunicaciones.html')
    else:
        return render_template('index.html')

@app.route('/vender')
def Vender():
    if 'nombres' in session:
        return render_template('vender.html')
    else:
        return render_template('index.html')

@app.route('/imagenes')
def Imagenes():
    if 'nombres' in session:
        cur = mysql.connection.cursor()
        cur.execute('SELECT MAX(idProducto) AS id FROM `productos`')
        dataIdProducto = cur.fetchone()

        if dataIdProducto:
            cur = mysql.connection.cursor()
            sql = ('SELECT * FROM `productos` WHERE `idproducto` = %s')
            cur.execute(sql,[dataIdProducto[0]])
            dataProducto = cur.fetchone()
            session['idProducto'] = dataProducto[0]
            session['nombreProducto'] = dataProducto[1]
            session['precioProducto'] = dataProducto[2]
            session['categoriaProducto'] = dataProducto[3]
            session['ubicacionProducto'] = dataProducto[4]
            session['descripcionProducto'] = dataProducto[5]
            session['disponibilidadProducto'] = dataProducto[6]
        return render_template('imagenes.html', productos = dataProducto)
    else:
        return render_template('index.html')

@app.route('/producto/<string:idProducto>')
def Producto(idProducto):
    if 'nombres' in session:
        cur = mysql.connection.cursor()
        cur.execute('SELECT * FROM `productos` WHERE `idproducto` = {0}'.format(idProducto))
        data = cur.fetchall()
        return render_template('producto.html', productosP = data[0])
    else:
        return render_template('index.html')

@app.route('/ayuda')
def Ayuda():
    if 'nombres' in session:
        return render_template('ayuda.html')
    else:
        return render_template('index.html')

@app.route('/salir')
def Salir():
    session.clear()
    return redirect(url_for('index'))

# Funciones Crud Usuario
@app.route('/login', methods=['POST','GET'])
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
        sql=('SELECT `idUsuario`, `nombresUsuario`, `documentoUsuario`, `telefonoUsuario`, `direccionUsuario`, `correoUsuario`, `contrasenaUsuario` FROM `usuarios` WHERE `correoUsuario` = %s')
        cur.execute(sql,[correo])
        usuario = cur.fetchone()
        cur.close()

        if (usuario != None):
            password_encriptado_encode = usuario[6].encode()

            if (bcrypt.checkpw(password_encode,password_encriptado_encode)): 
                session['idUsuario'] = usuario[0]
                session['nombres'] = usuario[1]
                session['documento'] = usuario[2]  
                session['telefono'] = usuario[3]   
                session['direccion'] = usuario[4]     
                session['correo'] = usuario[5]

                cur = mysql.connection.cursor()
                cur.execute('SELECT * FROM `productos`')
                data = cur.fetchall()

                return render_template('inicio.html', productos = data)
            else:
                flash('La contraseña es incorrecta!', 'danger')
                return render_template("login.html")
        else:
            flash('Email incorrecto!', 'danger')
            return render_template("login.html")

@app.route('/agregarUsuario', methods=['POST','GET'])
def agregarUsuario():
    if request.method == 'POST':
        nombres = request.form['nombres']
        documento = request.form['documento']
        telefono = request.form['telefono']
        direccion = request.form['direccion']
        correo = request.form['correo']
        contrasena = request.form['contrasena']

        if not (nombres and  documento and telefono and direccion and correo and contrasena):
            flash('No puede haber campos vacios!', 'danger')
        else:
            password_encode = contrasena.encode('utf-8')
            password_encriptado = bcrypt.hashpw(password_encode, semilla)
            cur = mysql.connection.cursor()
            cur.execute('INSERT INTO `usuarios`(`nombresUsuario`, `documentoUsuario`, `telefonoUsuario`, `direccionUsuario`, `correoUsuario`, `contrasenaUsuario`) VALUES (%s, %s, %s, %s, %s, %s)', (nombres, documento, telefono, direccion, correo, password_encriptado))
            mysql.connection.commit()

            flash('Cuenta creada exitosamente', 'success')

        return redirect(url_for('Inicio'))

@app.route('/eliminarUsuario/<string:id>')
def eliminarUsuario(id):
    cur = mysql.connection.cursor()
    cur.execute('DELETE FROM `usuarios` WHERE `idUsuario` = {0}'.format(id))
    mysql.connection.commit()
    flash('Usuario eliminado correctamente')
    session.clear()
    return redirect(url_for('index'))

@app.route('/modificarDomicilio/<id>', methods= ['POST','GET'])
def modificarDomicilio(id):
    if request.method == 'POST':
        direccion = request.form['direccion']
    cur = mysql.connection.cursor()
    cur.execute('UPDATE `usuarios` SET `direccionUsuario`= %s WHERE `idUsuario`= %s',(direccion, id))
    mysql.connection.commit()
    flash('Direccion Actualizada Exitosamente', 'success')
    session['direccion'] = direccion
    return redirect(url_for('MisDatos'))

@app.route('/modificarDatosP/<id>', methods= ['POST', 'GET'])
def modificarDatosP(id):
    if request.method == 'POST':
        nombres = request.form['nombres']
        documento = request.form['documento']
        telefono = request.form['telefono']
    cur = mysql.connection.cursor()
    cur.execute('UPDATE `usuarios` SET `nombresUsuario`= %s, `documentoUsuario`= %s, `telefonoUsuario`= %s WHERE `idUsuario`= %s',(nombres, documento, telefono, id))
    mysql.connection.commit()
    flash('Datos Personales Actualizados Exitosamente', 'success')
    session['nombres'] = nombres
    session['documento'] = documento
    session['telefono'] = telefono
    return redirect(url_for('MisDatos'))

@app.route('/modificarDatosC/<id>', methods= ['POST', 'GET'])
def modificarDatosC(id):
    if request.method == 'POST':
        correo = request.form['correo']
        contrasenaM = request.form['contrasena']
    
    password_encode = contrasenaM.encode('utf-8')
    password_encriptado = bcrypt.hashpw(password_encode, semilla)

    cur = mysql.connection.cursor()
    cur.execute('UPDATE `usuarios` SET `correoUsuario`= %s, `contrasenaUsuario`= %s WHERE `idUsuario`= %s',(correo, password_encriptado, id))
    mysql.connection.commit()
    flash('Datos de la Cuenta Actualizados Exitosamente', 'success')
    session['correo'] = correo
    return redirect(url_for('Seguridad'))

# Funciones crud productos
@app.route('/agregarProducto', methods= ['POST', 'GET'])
def agregarProducto():
    if request.method == 'POST':
        nombreProducto = request.form['nombreProducto']
        precioProducto = request.form['precio']
        ubicacionProducto = request.form['ubicacion']
        categoriasProducto = request.form['categorias']
        descripcionProducto = request.form['descripcion']
        disponibilidadProducto = request.form['disponibilidad']

        cur = mysql.connection.cursor()
        cur.execute('INSERT INTO `productos`(`nombreProducto`, `precioProducto`, `categoriasProducto`, `ubicacionProducto`, `descripcionProducto`, `disponibilidadProducto`, `usuarios_idusuario`) VALUES (%s, %s, %s, %s, %s, %s, %s)', (nombreProducto, precioProducto, categoriasProducto, ubicacionProducto, descripcionProducto, disponibilidadProducto, session['idUsuario']))
        mysql.connection.commit()

        flash('Producto registrado exitosamente', 'success')

        return redirect(url_for('Imagenes'))

@app.route('/agregarImagen', methods= ['POST', 'GET'])
def AgregarImagen():
    if request.method == "POST":
        files = request.files.getlist('imagenes')
        for file in files:
            filename = secure_filename(file.filename)
            img = file.save(os.getcwd() + "/static/imgProductos/" + str(session['idProducto']) + ".jpg")

            return redirect(url_for('Inicio'))

# Inicio app
if __name__ == "__main__": 
    app.run(debug=True)   