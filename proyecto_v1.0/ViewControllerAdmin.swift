//
//  ViewControllerAdmin.swift
//  proyecto_v1.0
//
//  Created by Labdesarrollo.3 on 10/8/19.
//  Copyright © 2019 Labdesarrollo.3. All rights reserved.
//

import UIKit
import SQLite3

class ViewControllerAdmin: UIViewController {

    var producto = [Productos]()
    var db: OpaquePointer?
    
    
    @IBOutlet weak var txtBuscar: UITextField!
    
    @IBAction func btnBuscar(_ sender: UIButton) {
    }
    
    @IBOutlet weak var txtNomProd: UITextField!
    
    @IBOutlet weak var txtPrecio: UITextField!
    
    @IBOutlet weak var txtCantidad: UITextField!
    
    @IBAction func btnAgregar(_ sender: UIButton) {
        let nomP = txtNomProd.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let precio = txtPrecio.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let cantidad = txtCantidad.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if (nomP?.isEmpty)!{
            showAlert(Titulo: "Nombre producto", Mensaje: "Faltan datos")
            txtNomProd.becomeFirstResponder()
            return
        }
        if (precio?.isEmpty)!{
            showAlert(Titulo: "Precio", Mensaje: "Faltan datos")
            txtPrecio.becomeFirstResponder()
            return
        }
        if (cantidad?.isEmpty)!{
            showAlert(Titulo: "Cantidad", Mensaje: "Faltan datos")
            txtCantidad.becomeFirstResponder()
            return
        }
        
        let nombr : NSString = nomP! as NSString
        let pre : Int32 = Int32(precio!) as! Int32
        let canti : Int32 = Int32(cantidad!) as! Int32
        
        var stmt:OpaquePointer?
        let sentencia = "INSERT INTO Productos(nomProducto, precio, cantidad) values (?,?,?)"
        if sqlite3_prepare(db, sentencia, -1, &stmt, nil) == SQLITE_OK{
            sqlite3_bind_text(stmt, 1, nombr.utf8String, -1, nil)
            sqlite3_bind_int(stmt, 2, pre)
            sqlite3_bind_int(stmt, 3, canti)
        }
        if sqlite3_step(stmt) != SQLITE_DONE{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            showAlert(Titulo: "Error Insertar", Mensaje: "Error al agregar un producto")
            return
        }
        limpiar()
    }
    
    @IBAction func btnModificar(_ sender: UIButton) {
    }
    
    @IBAction func btnEliminar(_ sender: UIButton) {
    }
    
    @IBAction func btnMenu(_ sender: UIButton) {
        let fileURL = try! FileManager.default.url(for:.documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) .appendingPathComponent ("CafeDatabase.sqlite")
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            showAlert(Titulo: "basedatos", Mensaje: "Error al abrir base de datos")
            
        }
        producto.removeAll()
        let query = "SELECT idProducto, nomProducto, precio, cantidad FROM Productos Order By nomProducto"
        var stmt: OpaquePointer?
        if (sqlite3_prepare(db, query, -1, &stmt, nil) != SQLITE_OK){
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            showAlert(Titulo: "Error consultar", Mensaje: errmsg)
            return
        }
        while (sqlite3_step(stmt) == SQLITE_ROW){
            let idp = String(sqlite3_column_int(stmt, 0))
            let nom = String (cString: sqlite3_column_text(stmt, 1))
            let pre = String (sqlite3_column_double(stmt, 2))
            let can = String (sqlite3_column_int(stmt, 3))
            
            producto.append(Productos(idProd: idp, nomprod:nom, prec:pre, exist:can))
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func showAlert(Titulo: String, Mensaje: String){
        let alert = UIAlertController(title: Titulo, message: Mensaje, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert,animated: true, completion: nil)
     
    }
    
    func limpiar() {
        txtBuscar.text = ""
        txtPrecio.text = ""
        txtNomProd.text = ""
        txtCantidad.text = ""
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segueVerMenu"){
            let tableSegue = segue.destination as! TableViewController
            tableSegue.producto = producto
        }
    }
}
