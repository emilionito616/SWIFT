//
//  Productos.swift
//  proyecto_v1.0
//
//  Created by Labdesarrollo.3 on 10/8/19.
//  Copyright © 2019 Labdesarrollo.3. All rights reserved.
//

import Foundation
class Productos{
    var idProducto : String
    var nomProducto : String
    var precio: String
    var existencia : String
    
    init (idProd: String, nomprod: String, prec: String, exist: String ){
        self.idProducto = idProd
        self.nomProducto = nomprod
        self.existencia = exist
        self.precio = prec
    }
}
