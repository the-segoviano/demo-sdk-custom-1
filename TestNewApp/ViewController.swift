//
//  ViewController.swift
//  TestNewApp
//
//  Created by Luis Segoviano on 04/12/25.
//

import UIKit
import FrameworkForTestNewApp

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .systemBlue
        
        // Crear instancia del validador
        let validador = ValidadorCampos()

        // Ejemplo 1: Validar email
        do {
            let esValido = try validador.validar("usuario@ejemplo.com", tipo: .email)
            print("Email válido: \(esValido)")
        } catch {
            print("Error: \((error as? LocalizedError)?.errorDescription ?? "Desconocido")")
        }
        
    }


}

