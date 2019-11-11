//
//  ViewControllerAdminOpciones.swift
//  proyecto_v1.0
//
//  Created by Labdesarrollo.3 on 10/14/19.
//  Copyright © 2019 Labdesarrollo.3. All rights reserved.
//

import UIKit

class ViewControllerAdminOpciones: UIViewController {

    @IBAction func btnPedidos(_ sender: UIButton) {
        self .performSegue(withIdentifier: "segueVerPedidos", sender: self)
    }
    
    @IBAction func btnAdministrar(_ sender: UIButton) {
        self .performSegue(withIdentifier: "segueAdmin", sender: self)
    }
    
    @IBAction func btnMenu(_ sender: UIButton) {
        self .performSegue(withIdentifier: "segueVerMenu", sender: self)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
