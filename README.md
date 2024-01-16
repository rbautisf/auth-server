# Getting Started

This is a sample project demonstrating the use of Spring Boot with Spring Oauth2 Authorization Server.

## Prerequisites
Make sure to have these tools installed
* Java 17
* Docker
* Docker Compose
* Gradle
* OpenSSL

## Build & Run
Before running the application, make sure to build it. Execute the command below:
```shell
./gradlew build
```

Execute the docker-compose file to start the database.
```shell
scripts/docker-compose up
```

Finally, start the application with the command:
```shell
./gradlew bootRun
```
Once the application starts, Swagger documents can be accessed via [Swagger UI](http://localhost:9000/swagger-ui/index.html), and PGAdmin via [PGAdmin Login Portal](http://localhost:5050/login).


## Environment Setup
The run time environment can be setup using the following environment variables:
```shell
DATASOURCE_URL=
DB_USERNAME=
DB_PASSWORD=
PRIVATE_KEY=
PUBLIC_KEY=
```
## Key Generation
#### Creating Private Key
The following command generates a DES3 encrypted RSA private key:
```shell
openssl genrsa -des3 -out private.pem 2048
```
#### Creating Public Key
The next step is to create a public key from the private key we just generated. Use the command below:
```shell
openssl rsa -in private.pem -outform PEM -pubout -out public.pem
```
#### Creating PKCS8 Format
Finally, you need to convert the private key to pkcs8 format. This is the format the application can read. Use the following command:
```shell
openssl pkcs8 -topk8 -inform PEM -outform PEM -nocrypt -in private.pem -out private-pkcs8.pem
```

After executing the commands, two files should be generated: `private-pkcs8.pem` and `public.pem`. Please place them in the resources folder.

## Additional Notes
#### Postman collection
The postman collection included in the root folder.
#### User Login For Testing
```shell
username: user@user.com
password: user
```
#### Registered Client for Testing
```shell
client_id: nowhere-client
client_secret: nowhere-secret
```
#### Callback URLs
```shell
client_id: nowhere-client
client_secret: nowhere-secret

### Reference Documentation

For further reference, please consider the following sections:

* [Official Gradle documentation](https://docs.gradle.org)
* [Spring Boot Gradle Plugin Reference Guide](https://docs.spring.io/spring-boot/docs/3.2.1/gradle-plugin/reference/html/)
* [Create an OCI image](https://docs.spring.io/spring-boot/docs/3.2.1/gradle-plugin/reference/html/#build-image)
* [Spring Web](https://docs.spring.io/spring-boot/docs/3.2.1/reference/htmlsingle/index.html#web)
* [Spring Security](https://docs.spring.io/spring-boot/docs/3.2.1/reference/htmlsingle/index.html#web.security)
* [Spring Data JPA](https://docs.spring.io/spring-boot/docs/3.2.1/reference/htmlsingle/index.html#data.sql.jpa-and-spring-data)

### Guides

The following guides illustrate how to use some features concretely:

* [Building a RESTful Web Service](https://spring.io/guides/gs/rest-service/)
* [Serving Web Content with Spring MVC](https://spring.io/guides/gs/serving-web-content/)
* [Building REST services with Spring](https://spring.io/guides/tutorials/rest/)
* [Securing a Web Application](https://spring.io/guides/gs/securing-web/)
* [Spring Boot and OAuth2](https://spring.io/guides/tutorials/spring-boot-oauth2/)
* [Authenticating a User with LDAP](https://spring.io/guides/gs/authenticating-ldap/)
* [Accessing Data with JPA](https://spring.io/guides/gs/accessing-data-jpa/)

### Additional Links

These additional references should also help you:

* [Gradle Build Scans – insights for your project's build](https://scans.gradle.com#gradle)

