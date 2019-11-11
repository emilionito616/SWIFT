//
//  Usuarios.swift
//  proyecto_v1.0
//
//  Created by Labdesarrollo.3 on 9/24/19.
//  Copyright © 2019 Labdesarrollo.3. All rights reserved.
//

import Foundation
class Usuarios{
    var idUsuario: String
    var nomUsuario: String
    var password: String
    
    init(idUsr: String, nomUsr: String, pwd: String) {
        self.idUsuario = idUsr
        self.nomUsuario = nomUsr
        self.password = pwd
    }
}
