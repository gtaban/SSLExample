import Kitura
import SSLService
import HeliumLogger

HeliumLogger.use()

let router = Router()

/*
// Gelareh's macOS credentials path...
let myCertPath = "/Users/gtaban/Developer/SecureService/SSLExample/Creds/Self-Signed/cert.pem"
let myKeyPath = "/Users/gtaban/Developer/SecureService/SSLExample/Creds/Self-Signed/key.pem"

    
// Bill's macOS credentials path...
//let myCertPath = "/Users/babt/Source/IBMSwift/Open Source/SSLExample/Creds/Self-Signed/cert.pem"
//let myKeyPath = "/Users/babt/Source/IBMSwift/Open Source/SSLExample/Creds/Self-Signed/key.pem"
    
// Bill's Linux credentials path...
//let myCertPath = "/mnt/hgfs/IBMSwift/Open Source/SSLExample/Creds/Self-Signed/cert.pem"
//let myKeyPath = "/mnt/hgfs/IBMSwift/Open Source/SSLExample/Creds/Self-Signed/key.pem"

var mySSLConfig = SSLService.Configuration(withCACertificateDirectory: nil, usingCertificateFile: myCertPath, withKeyFile: myKeyPath, usingSelfSignedCerts: true)
*/


//#if HAVE_CA_CHAIN_CERT
// Gelareh's macOS ca credentials path...
let myCertChainFile = "/Users/gtaban/Developer/SecureService/SSLExample/Creds/CertCA/ca-chain.cert.pem"
let myCertPath = "/Users/gtaban/Developer/SecureService/SSLExample/Creds/CertCA/server.cert.pem"
let myKeyPath = "/Users/gtaban/Developer/SecureService/SSLExample/Creds/CertCA/server.key.pem"

var mySSLConfig = SSLService.Configuration(withCACertificateFilePath: myCertChainFile, usingCertificateFile: myCertPath, withKeyFile: myKeyPath, usingSelfSignedCerts: false)



mySSLConfig.cipherSuite = "ALL"

router.get("/") {
    request, response, next in
    response.send("Hello, World!")
    next()
}

Kitura.addHTTPServer(onPort: 8090, with: router, withSSL: mySSLConfig)
Kitura.run()



