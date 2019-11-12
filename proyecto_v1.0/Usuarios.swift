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
    var noControl: String
    var nomUsuario: String
    var carrera: String
    var password: String
    
    init(idUsr: String,noCrtl: String, nomUsr: String, carr: String,pwd: String) {
        self.idUsuario = idUsr
        self.noControl = noCrtl
        self.nomUsuario = nomUsr
        self.carrera = carr
        self.password = pwd
    }
}
