import Kitura
import HeliumLogger

#if os(Linux)
    func TestSelfSignedLinux() -> SSLConfig {
        // Gelareh's Self-signed macOS credentials path...
        let myCertPath = "/Users/gtaban/Developer/SecureService/SSLExample/Creds/Self-Signed/cert.pem"
        let myKeyPath = "/Users/gtaban/Developer/SecureService/SSLExample/Creds/Self-Signed/key.pem"
        
        // Bill's Self-signed macOS credentials path...
        //let myCertPath = "/Users/babt/Source/IBMSwift/Open Source/SSLExample/Creds/Self-Signed/cert.pem"
        //let myKeyPath = "/Users/babt/Source/IBMSwift/Open Source/SSLExample/Creds/Self-Signed/key.pem"
        
        // Bill's Linux credentials path...
        //let myCertPath = "/mnt/hgfs/IBMSwift/Open Source/SSLExample/Creds/Self-Signed/cert.pem"
        //let myKeyPath = "/mnt/hgfs/IBMSwift/Open Source/SSLExample/Creds/Self-Signed/key.pem"
        
        return SSLConfig(withCACertificateDirectory: nil, usingCertificateFile: myCertPath, withKeyFile: myKeyPath, usingSelfSignedCerts: true)
    }
    
    func  TestCertChainLinux() -> SSLConfig {
        // Gelareh's macOS ca credentials path...
        let myCertChainFile = "/Users/gtaban/Developer/SecureService/SSLExample/Creds/CertCA/ca-chain.cert.pem"
        let myCertFile = "/Users/gtaban/Developer/SecureService/SSLExample/Creds/CertCA/server.cert.pem"
        let myKeyFile = "/Users/gtaban/Developer/SecureService/SSLExample/Creds/CertCA/server.key.pem"
        
        return SSLConfig(withCACertificateFilePath: myCertChainFile, usingCertificateFile: myCertFile, withKeyFile: myKeyFile, usingSelfSignedCerts: false)
        
    }
#else
    func TestSelfSignedMac() -> SSLConfig {
        let myCertChainFile = "/Users/gtaban/Developer/SecureService/SSLExample/Creds/Self-Signed/cert.pfx"
        
        return SSLConfig(withChainFilePath: myCertChainFile, withPassword:"password", usingSelfSignedCerts:true)
    }
    
    func TestCertChainMac() -> SSLConfig {
        let myCertChainFile = "/Users/gtaban/Developer/SecureService/SSLExample/Creds/CertCA/server.cert.pfx"
        
        return SSLConfig(withChainFilePath: myCertChainFile, withPassword:"password", usingSelfSignedCerts:false)
    }
    
#endif // os(Linux)


HeliumLogger.use()

let router = Router()
var mySSLConfigSelfSigned: SSLConfig
var mySSLConfigChain: SSLConfig

#if os(Linux)
    mySSLConfigSelfSigned = TestSelfSignedLinux()
    mySSLConfigChain = TestCertChainLinux()

    mySSLConfig.cipherSuite = "ALL"
#else

    mySSLConfigSelfSigned = TestSelfSignedMac()
    mySSLConfigChain = TestCertChainMac()
#endif // os(Linux)

router.get("/") {
    request, response, next in
    response.send("Hello, World!")
    next()
}

// https://localhost:8090
Kitura.addHTTPServer(onPort: 8090, with: router, withSSL: mySSLConfigSelfSigned)

// https://localhost:8080
Kitura.addHTTPServer(onPort: 8080, with: router, withSSL: mySSLConfigChain)

Kitura.run()






