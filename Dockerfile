# Servidor Tomcat 10 con JDK 17
FROM tomcat:10.1-jdk17-temurin

# Limpiar aplicaciones por defecto
RUN rm -rf /usr/local/tomcat/webapps/*

# Copiar seda.war como ROOT.war para que responda en la raíz de la URL
COPY sedada.war /usr/local/tomcat/webapps/ROOT.war

# Ajuste del puerto dinámico para Railway
ENV PORT 8080
EXPOSE 8080

# Comando para iniciar Tomcat escuchando en el puerto asignado por Railway
CMD ["sh", "-c", "sed -i 's/port=\"8080\"/port=\"'\"${PORT:-8080}\"'\"/g' /usr/local/tomcat/conf/server.xml && catalina.sh run"]
