const { Router } = require('express');
const router = Router();

//importar controladores
const { getEmpleados, getHistorial, getProductos, getRegistros, 
        deleteEmpleado, deleteProducto,
        postEmpleado,postProducto, postTransaccion,
        putPrecio
        } = require('../controllers/consultas');


router.get('/getEmpleados', getEmpleados);
router.get('/getProductos', getProductos);
router.get('/getHistorial', getHistorial);
router.get('/getRegistros', getRegistros);

router.delete('/deleteEmpleado/:id', deleteEmpleado);
router.delete('/deleteProducto/:id', deleteProducto);

router.post('/postEmpleado', postEmpleado);
router.post('/postProducto', postProducto);
router.post('/postTransaccion', postTransaccion);

router.put('/putPrecio/:id', putPrecio);




module.exports = router;