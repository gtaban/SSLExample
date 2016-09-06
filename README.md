# SSLExample
Integrates Kitura with SSLService

# Create self-signed certificate with openssl

// generate an RSA key
openssl genrsa -out key.pem 2048

// create cert signing request used to generate the cert
openssl req -new -sha256 -key key.pem -out csr.csr

// create cert
openssl req -x509 -sha256 -days 365 -key key.pem -in csr.csr -out certificate.pem




