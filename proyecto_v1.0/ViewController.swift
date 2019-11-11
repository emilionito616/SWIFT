//
//  ViewController.swift
//  proyecto_v1.0
//
//  Created by Labdesarrollo.3 on 9/24/19.
//  Copyright © 2019 Labdesarrollo.3. All rights reserved.
//

import UIKit
import SQLite3

class ViewController: UIViewController {
    var db: OpaquePointer?
    @IBOutlet weak var Usuario: UITextField!
    
    @IBOutlet weak var Contra: UITextField!
    
    @IBAction func Iniciar(_ sender: UIButton) {
        if (Usuario.text?.isEmpty)! || (Contra.text?.isEmpty)! {
            showAlert(Titulo: "Error", Mensaje: "Faltan datos")
            Usuario.becomeFirstResponder()
        } else if (Usuario.text == "admin") && (Contra.text == "hola"){
            self .performSegue(withIdentifier: "segueAdmin", sender: self)
        }else {
            self .performSegue(withIdentifier: "segueMenu", sender: self)
        }
    }
        
    @IBAction func Crear(_ sender: UIButton) {
        self .performSegue(withIdentifier: "segueCrear", sender: self)
    }
    
    func showAlert(Titulo: String, Mensaje: String){
        let alert = UIAlertController(title: Titulo, message: Mensaje, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let fileURL = try! FileManager.default.url(for:.documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) .appendingPathComponent ("CafeDatabase.sqlite")
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            showAlert(Titulo: "basedatos", Mensaje: "Error al abrir base de datos")
            
        }
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS Usuario(idUsuario INTEGER PRIMARY KEY AUTOINCREMENT, noControl TEXT, carrera TEXT, password TEXT)", nil, nil, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            showAlert(Titulo:"Error al crear la tabla", Mensaje: errmsg)
        }
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS Productos(idProducto INTEGER PRIMARY KEY AUTOINCREMENT, nomProducto TEXT, precio DOUBLE, cantidad INTEGER)", nil, nil, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            showAlert(Titulo:"Error al crear la tabla", Mensaje: errmsg)
        }
        // Do any additional setup after loading the view.
    }
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segueCrear"){
            let seguecrear = segue.destination as! ViewControllerCrear
        }
    }*/

}
