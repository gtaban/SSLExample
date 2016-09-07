import Kitura
import SSLService
import HeliumLogger

HeliumLogger.use()

let router = Router()

let myCertPath = "/Users/gtaban/Developer/SecureService/SSLExample/Creds/Self-Signed/cert.pem"
let myKeyPath = "/Users/gtaban/Developer/SecureService/SSLExample/Creds/Self-Signed/key.pem"

//let myCertPath = "/Users/babt/Source/IBMSwift/Open Source/SSLExample/Creds/Self-Signed/cert.pem"
//let myKeyPath = "/Users/babt/Source/IBMSwift/Open Source/SSLExample/Creds/Self-Signed/key.pem"

var mySSLConfig = SSLService.Configuration(withCACertificateDirectory: nil, usingCertificateFile: myCertPath, withKeyFile: myKeyPath)

mySSLConfig.cipherSuite = "ALL"

router.get("/") {
    request, response, next in
    response.send("Hello, World!")
    next()
}

Kitura.addHTTPServer(onPort: 8090, with: router, withSSL: mySSLConfig)
Kitura.run()


