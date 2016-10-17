import Kitura
import HeliumLogger

HeliumLogger.use()

let router = Router()
var mySSLConfigSelfSigned: SSLConfig
var mySSLConfigChain: SSLConfig

mySSLConfigSelfSigned = try TestSelfSigned()
mySSLConfigChain = try TestCertChain()

#if os(Linux)
    mySSLConfig.cipherSuite = "ALL"
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






