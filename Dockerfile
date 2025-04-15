FROM oracle/glassfish:5.0.1-jdk8

COPY upiiTicket.war /opt/glassfish5/glassfish/domains/domain1/autodeploy/

EXPOSE 8080

CMD ["/opt/glassfish5/bin/asadmin", "start-domain", "-v"]
