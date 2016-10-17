import Kitura
import HeliumLogger
import LoggerAPI
import Foundation

public enum SSLExampleError: Error {
    case invalidPath
}


func TestSelfSigned() throws -> SSLConfig {
    #if os(Linux)
        let relativeCertPath = "/Creds/Self-Signed/cert.pem"
        let relativeFilePath = "/Creds/Self-Signed/key.pem"
    #else
        let relativeCertPath = "/Creds/Self-Signed/cert.pfx"
    #endif
        
        guard let myCertFile = getAbsolutePath(relativePath: relativeCertPath, useFallback: false) else {
            Log.error("Could not find file at relative path \(relativeCertPath).")
            throw SSLExampleError.invalidPath
        }
    #if os(Linux)
        guard let myKeyFile = getAbsolutePath(relativePath: relativeFilePath, useFallback: false) else {
            Log.error("Could not find file at relative path \(relativeCertPath).")
            throw SSLExampleError.invalidPath
        }
    #endif
        
    #if os(Linux)
        return SSLConfig(withCACertificateDirectory: nil, usingCertificateFile: myCertFile, withKeyFile: myKeyFile, usingSelfSignedCerts: true)
    #else
        return SSLConfig(withChainFilePath: myCertFile, withPassword:"password", usingSelfSignedCerts:true)
    #endif
}

    
    
    
func TestCertChain() throws -> SSLConfig {
    
    #if os(Linux)
        let relativeCertChainPath = "/Creds/CertCA/ca-chain.cert.pem"
        let relativeCertPath = "/Creds/CertCA/server.cert.pem"
        let relativeFilePath = "/Creds/CertCA/server.key.pem"
    #else
        let relativeCertPath = "/Creds/CertCA/server.cert.pfx"
    #endif
    
    guard let myCertFile = getAbsolutePath(relativePath: relativeCertPath, useFallback: false) else {
        Log.error("Could not find file at relative path \(relativeCertPath).")
        throw SSLExampleError.invalidPath
    }
    #if os(Linux)
        guard let myKeyFile = getAbsolutePath(relativePath: relativeFilePath, useFallback: false) else {
            Log.error("Could not find file at relative path \(relativeCertPath).")
            throw SSLExampleError.invalidPath
        }
    #endif
    
    #if os(Linux)
        return SSLConfig(withCACertificateDirectory: nil, usingCertificateFile: myCertFile, withKeyFile: myKeyFile, usingSelfSignedCerts: true)
    #else
        return SSLConfig(withChainFilePath: myCertFile, withPassword:"password", usingSelfSignedCerts:true)
    #endif
}


func getAbsolutePath(relativePath: String, useFallback: Bool) -> String? {
    let initialPath = #file
    let components = initialPath.characters.split(separator: "/").map(String.init)
    let notLastTwo = components[0..<components.count - 2]
    
    var filePath = "/" + notLastTwo.joined(separator: "/") + relativePath
    
    let fileManager = FileManager.default
    
    if fileManager.fileExists(atPath: filePath) {
        return filePath
    } else if useFallback {
        // Get path in alternate way, if first way fails
        let currentPath = fileManager.currentDirectoryPath
        filePath = currentPath + relativePath
        if fileManager.fileExists(atPath: filePath) {
            return filePath
        } else {
            return nil
        }
    } else {
        return nil
    }
}

public func parseAddress() -> (String, Int) {
    let args = Array(ProcessInfo.processInfo.arguments[1..<ProcessInfo.processInfo.arguments.count])
    var port = 8090 // default port
    var ip = "0.0.0.0" // default ip
    if args.count == 2 && args[0] == "-bind" {
        let tokens = args[1].components(separatedBy: ":")
        if (tokens.count == 2) {
            ip = tokens[0]
            if let portNumber = Int(tokens[1]) {
                port = portNumber
            }
        }
    }
    return (ip, port)
}



