const {pool} = require('./conexion');


//GET 
const getEmpleados = async (req,res) =>{
    const response = await pool.query('SELECT * FROM EMPLEADO;');
    console.log(response.rows);
    res.send(response.rows);
}

const getProductos = async (req,res) =>{
    const response = await pool.query('SELECT * FROM PRODUCTO;');
    console.log(response.rows);
    res.send(response.rows);
   
}

const getHistorial = async (req,res) =>{
    const response = await pool.query('SELECT * FROM getHistorial();')
    console.log(response.rows);
    res.send(response.rows);
}

const getRegistros = async (req,res) => {
    const response = await pool.query('SELECT * FROM getRegistros();');
    console.log(response.rows);
    res.send(response.rows);

}
/*
const getRegistros = async (req,res) => {
    const response = await pool.query('SELECT id_registro,fecha_hora,cantidad,monto,E.nombre AS empleado,P.nombre AS producto '+
                                      'FROM REGISTRO '+
                                      'JOIN EMPLEADO E ON EMPLEADO_id_empleado=id_empleado '+
                                      'JOIN PRODUCTO P ON PRODUCTO_id_producto=id_producto;')
        console.log(response.rows);
        res.send(response.rows);
}
 */

//DELETE

const deleteEmpleado = async (req,res) => {
    console.log(req.params.id);
    const id_empleado = req.params.id;

    const response = await pool.query('DELETE FROM EMPLEADO WHERE id_empleado=$1;',[id_empleado], (error,result) =>
    {
      if(error == undefined)
      {
        res.send({msg:'Se ha removido el producto exitosaente.'});

      }
      else{
        res.send({msg:'Error'})
      }   
    });

}

const deleteProducto = async (req,res) => {
    console.log(req.params.id);
    const id_producto = req.params.id;

    const response = await pool.query('DELETE FROM PRODUCTO WHERE id_producto=$1;',[id_producto], (error,result) =>
    {
      if(error == undefined)
      {
        res.send({msg:'Se ha removido el producto exitosaente.'});

      }
      else{
        res.send({msg:'Error'})
      }   
    });
    
}

//POST
const postEmpleado = async (req,res) =>{
    const { nombre,salario } = req.body;

    console.log(nombre,salario);
    pool.query('INSERT INTO EMPLEADO(nombre,salario) VALUES($1,$2);',[nombre,salario],(error,response) => {
        if(error==undefined) {
            console.log(response.rows);
            res.send(
                {
                msg: 'Correcto',
                body: {
                    nombre: nombre,
                    salario: salario
                }
                }
            );
        }else {
            res.send({msg:'Error'})
        }
    });   
}

const postProducto = async (req,res) => {
    console.log(req.body)
    const { nombre,descripcion,stock,precio } = req.body;

    console.log(req.body);
    pool.query('INSERT INTO PRODUCTO(nombre,descripcion,stock,precio) VALUES($1,$2,$3,$4);',[nombre,descripcion,stock,precio],(error,response) => {
        if(error==undefined) {
            console.log(response.rows);
            res.send(
                {
                msg: 'Correcto',
                body: response.rows
                }
            );
        }else {
            res.send({msg:'Error'})
        }
    });   
}

const postTransaccion = async (req,res) => {
    const {cantidad,cod_empleado,cod_producto} = req.body;

    pool.query( 'INSERT INTO REGISTRO(cantidad,monto,fecha_hora,EMPLEADO_id_empleado,PRODUCTO_id_producto) '+
                'VALUES($1,100.20,CURRENT_TIMESTAMP,$2,$3);',[cantidad,cod_empleado,cod_producto],
                (error,result) => {
                    console.log(error)
                    if(error == undefined)
                    {
                        res.send({msg: 'Correcto'});
                    }
                    else
                    {
                        res.send({msg: 'Incorrecto'});
                    }
                })
}


//PUT
const putPrecio = async (req,res) => {
    console.log(req.body)
    const id_producto = req.params.id;
    const {precio} = req.body;
    pool.query('UPDATE PRODUCTO SET precio=$1 WHERE id_producto=$2;',[precio,id_producto],(error,result) =>{
        if(error==undefined)
        {
            if(result.rowCount == 0)
            {
                res.send({msg: 'Error al actualizar, no se encuentra el producto especificado.'});
                console.log(result);

            }
            else {
                res.send({msg: 'Correcto'});
            }
        }
        else
        {
            res.send({msg: 'Error, no se pudo actualizar el producto'});
        }
    });
}

module.exports =    {   getEmpleados, getHistorial, getProductos, getRegistros,
                        deleteEmpleado, deleteProducto,
                        postEmpleado, postProducto, postTransaccion,
                        putPrecio
                    }