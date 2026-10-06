# Servidor Tomcat 10 con JDK 17
FROM tomcat:10.1-jdk17-temurin

# Descargar las librerías PostgreSQL JDBC y jBCrypt directamente a la carpeta de librerías de Tomcat
ADD https://repo1.maven.org/maven2/org/postgresql/postgresql/42.7.3/postgresql-42.7.3.jar /usr/local/tomcat/lib/postgresql-42.7.3.jar
ADD https://repo1.maven.org/maven2/org/mindrot/jbcrypt/0.4/jbcrypt-0.4.jar /usr/local/tomcat/lib/jbcrypt-0.4.jar

# Limpiar aplicaciones por defecto de Tomcat
RUN rm -rf /usr/local/tomcat/webapps/*

# Copiar sedada.war como ROOT.war
COPY sedada.war /usr/local/tomcat/webapps/ROOT.war

# Configuración de puerto dinámico para Railway
ENV PORT 8080
EXPOSE 8080

# Comando para iniciar Tomcat
CMD ["sh", "-c", "sed -i 's/port=\"8080\"/port=\"'\"${PORT:-8080}\"'\"/g' /usr/local/tomcat/conf/server.xml && catalina.sh run"]
