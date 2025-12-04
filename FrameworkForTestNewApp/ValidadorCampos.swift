//
//  ValidadorCampos.swift
//  FrameworkForTestNewApp
//
//  Created by Luis Segoviano on 04/12/25.
//

import Foundation

public class ValidadorCampos {
    
    public init(){}
    
    // MARK: - Tipos de Validación
    public enum TipoValidacion {
        case email
        case nombre
        case apellidos
        case telefono
        case password
        case codigoPostal
        case dni
        case custom(regex: String)
    }
    
    // MARK: - Errores de Validación
    public enum ErrorValidacion: Error, LocalizedError {
        case campoVacio
        case formatoInvalido
        case longitudInsuficiente(min: Int)
        case longitudExcedida(max: Int)
        case caracteresInvalidos
        case emailInvalido
        case passwordDebil
        
        public var errorDescription: String? {
            switch self {
            case .campoVacio:
                return "Este campo es requerido"
            case .formatoInvalido:
                return "El formato no es válido"
            case .longitudInsuficiente(let min):
                return "Debe tener al menos \(min) caracteres"
            case .longitudExcedida(let max):
                return "No debe exceder \(max) caracteres"
            case .caracteresInvalidos:
                return "Contiene caracteres no permitidos"
            case .emailInvalido:
                return "El correo electrónico no es válido"
            case .passwordDebil:
                return "La contraseña debe tener al menos 8 caracteres, una mayúscula, una minúscula y un número"
            }
        }
    }
    
    // MARK: - Métodos de Validación
    
    /// Valida un campo de texto según el tipo especificado
    public func validar(_ texto: String?, tipo: TipoValidacion) throws -> Bool {
        guard let texto = texto, !texto.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            throw ErrorValidacion.campoVacio
        }
        
        let textoLimpio = texto.trimmingCharacters(in: .whitespacesAndNewlines)
        
        switch tipo {
        case .email:
            return try validarEmail(textoLimpio)
        case .nombre:
            return try validarNombre(textoLimpio)
        case .apellidos:
            return try validarApellidos(textoLimpio)
        case .telefono:
            return try validarTelefono(textoLimpio)
        case .password:
            return try validarPassword(textoLimpio)
        case .codigoPostal:
            return try validarCodigoPostal(textoLimpio)
        case .dni:
            return try validarDNI(textoLimpio)
        case .custom(let regex):
            return try validarConRegex(textoLimpio, pattern: regex)
        }
    }
    
    // MARK: - Validaciones Específicas
    
    private func validarEmail(_ email: String) throws -> Bool {
        // Regex para validar email
        let emailRegex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        
        if !coincideRegex(email, pattern: emailRegex) {
            throw ErrorValidacion.emailInvalido
        }
        
        return true
    }
    
    private func validarNombre(_ nombre: String) throws -> Bool {
        // Solo letras y espacios, mínimo 2 caracteres, máximo 50
        let nombreRegex = "^[A-Za-zÁÉÍÓÚáéíóúÑñ\\s]{2,50}$"
        
        if !coincideRegex(nombre, pattern: nombreRegex) {
            throw ErrorValidacion.caracteresInvalidos
        }
        
        return true
    }
    
    private func validarApellidos(_ apellidos: String) throws -> Bool {
        // Solo letras y espacios, mínimo 2 caracteres, máximo 100
        let apellidosRegex = "^[A-Za-zÁÉÍÓÚáéíóúÑñ\\s]{2,100}$"
        
        if !coincideRegex(apellidos, pattern: apellidosRegex) {
            throw ErrorValidacion.caracteresInvalidos
        }
        
        return true
    }
    
    private func validarTelefono(_ telefono: String) throws -> Bool {
        // Validar teléfono (ejemplo para España: 9 dígitos)
        let telefonoRegex = "^[0-9]{9}$"
        
        if !coincideRegex(telefono, pattern: telefonoRegex) {
            throw ErrorValidacion.formatoInvalido
        }
        
        return true
    }
    
    private func validarPassword(_ password: String) throws -> Bool {
        // Al menos 8 caracteres, una mayúscula, una minúscula y un número
        let passwordRegex = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d).{8,}$"
        
        if !coincideRegex(password, pattern: passwordRegex) {
            throw ErrorValidacion.passwordDebil
        }
        
        return true
    }
    
    private func validarCodigoPostal(_ cp: String) throws -> Bool {
        // Código postal de 5 dígitos
        let cpRegex = "^[0-9]{5}$"
        
        if !coincideRegex(cp, pattern: cpRegex) {
            throw ErrorValidacion.formatoInvalido
        }
        
        return true
    }
    
    private func validarDNI(_ dni: String) throws -> Bool {
        // Validar DNI español
        let dniRegex = "^[0-9]{8}[A-Z]$"
        
        if !coincideRegex(dni, pattern: dniRegex) {
            throw ErrorValidacion.formatoInvalido
        }
        
        // Validar letra del DNI
        let letras = "TRWAGMYFPDXBNJZSQVHLCKE"
        let numeros = String(dni.prefix(8))
        
        guard let numero = Int(numeros) else {
            throw ErrorValidacion.formatoInvalido
        }
        
        let letraCalculada = letras[letras.index(letras.startIndex, offsetBy: numero % 23)]
        let letraIngresada = dni.last!
        
        if letraCalculada != letraIngresada {
            throw ErrorValidacion.formatoInvalido
        }
        
        return true
    }
    
    private func validarConRegex(_ texto: String, pattern: String) throws -> Bool {
        if !coincideRegex(texto, pattern: pattern) {
            throw ErrorValidacion.formatoInvalido
        }
        return true
    }
    
    // MARK: - Helper Methods
    
    private func coincideRegex(_ texto: String, pattern: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: .caseInsensitive)
            let range = NSRange(location: 0, length: texto.utf16.count)
            return regex.firstMatch(in: texto, options: [], range: range) != nil
        } catch {
            print("Error en regex: \(error)")
            return false
        }
    }
    
    // MARK: - Métodos de Validación Simples (sin excepciones)
    
    public func esEmailValido(_ email: String?) -> (esValido: Bool, mensaje: String?) {
        do {
            let resultado = try validar(email, tipo: .email)
            return (resultado, nil)
        } catch {
            return (false, (error as? LocalizedError)?.errorDescription)
        }
    }
    
    public func esNombreValido(_ nombre: String?) -> (esValido: Bool, mensaje: String?) {
        do {
            let resultado = try validar(nombre, tipo: .nombre)
            return (resultado, nil)
        } catch {
            return (false, (error as? LocalizedError)?.errorDescription)
        }
    }
    
    public func esApellidoValido(_ apellido: String?) -> (esValido: Bool, mensaje: String?) {
        do {
            let resultado = try validar(apellido, tipo: .apellidos)
            return (resultado, nil)
        } catch {
            return (false, (error as? LocalizedError)?.errorDescription)
        }
    }
    
    // MARK: - Validación Múltiple
    
    public func validarFormulario(
        campos: [(texto: String?, tipo: TipoValidacion)]
    ) -> [(tipo: TipoValidacion, esValido: Bool, mensaje: String?)] {
        
        var resultados: [(tipo: TipoValidacion, esValido: Bool, mensaje: String?)] = []
        
        for campo in campos {
            do {
                let valido = try validar(campo.texto, tipo: campo.tipo)
                resultados.append((campo.tipo, valido, nil))
            } catch {
                let mensaje = (error as? LocalizedError)?.errorDescription
                resultados.append((campo.tipo, false, mensaje))
            }
        }
        
        return resultados
    }
}
