//
//  ViewControllerCrear.swift
//  proyecto_v1.0
//
//  Created by Labdesarrollo.3 on 9/24/19.
//  Copyright © 2019 Labdesarrollo.3. All rights reserved.
//

import UIKit
import SQLite3

class ViewControllerCrear: UIViewController {
    var usuario = [Usuarios]()
    var db : OpaquePointer?
    
    @IBOutlet var imgView:UIImageView?
    
    @IBOutlet weak var pwd1: UITextField!
    
    @IBOutlet weak var pwd2: UITextField!
    
    @IBOutlet weak var NoControl: UITextField!
    
    
    @IBOutlet weak var Carrera: UITextField!
    
    
    @IBAction func btnCargar(_ sender: UIButton) {
        
    }
    
    
    @IBAction func guardar(_ sender: UIButton) {
        let p1 = pwd1.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let p2 = pwd2.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let noC = NoControl.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let carr = Carrera.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if (noC?.isEmpty)!{
            showAlert(Titulo: "Error", Mensaje: "Falta numero de control")
            return
        }
        if (carr?.isEmpty)!{
            showAlert(Titulo: "Error", Mensaje: "Falta ingresar la carrera")
            return
        }
        
        if (p1?.isEmpty)! || (p2?.isEmpty)!{
            showAlert(Titulo: "Error", Mensaje: "Contraseña Incorrecta")
            return
        }else if (p1 != p2){
            showAlert(Titulo: "Error", Mensaje: "Las contraseñas no coinciden")
            return
        }
        
        let pwd: NSString = p1! as NSString
        let noCtrl: NSString = noC! as NSString
        let carre: NSString = carr! as NSString
        
        var stmt: OpaquePointer?
        let sentencia = "INSERT INTO Usuario(noControl,carrera, password) values (?,?,?)"
        if sqlite3_prepare(db,sentencia, -1, &stmt, nil) == SQLITE_OK{
            sqlite3_bind_text(stmt, 1,pwd.utf8String,-1,nil)
            sqlite3_bind_text(stmt, 2, noCtrl.utf8String, -1, nil)
            sqlite3_bind_text(stmt, 3, carre.utf8String, -1, nil)
            showAlert(Titulo: "Correcto", Mensaje: "Usuario Insertado con exito")
            
        }
        if sqlite3_step(stmt) != SQLITE_DONE{
            //let errmsg = String(cString:sqlite3_errmsg(db)!)
            showAlert(Titulo: "Error insertar", Mensaje: "Error al insertar")
            return
        }
        
        limpiar()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Crear Base de Datos
        let fileURL = try! FileManager.default.url(for:.documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) .appendingPathComponent ("CafeDatabase.sqlite")
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            showAlert(Titulo: "basedatos", Mensaje: "Error al abrir base de datos")
            
        }
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS Usuario(idUsuario INTEGER PRIMARY KEY AUTOINCREMENT, noControl TEXT, carrera TEXT, password TEXT)", nil, nil, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            showAlert(Titulo:"Error al crear la tabla", Mensaje: errmsg)
        }
        NoControl.becomeFirstResponder()
    }
    
    func limpiar() {
        NoControl.text = ""
        Carrera.text = ""
        pwd1.text = ""
        pwd2.text = ""
        
    }
    
    func showAlert(Titulo: String, Mensaje: String){
        let alert = UIAlertController(title: Titulo, message: Mensaje, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
