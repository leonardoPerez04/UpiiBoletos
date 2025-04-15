FROM glassfish:5.0

COPY upiiTicket.war /glassfish5/glassfish/domains/domain1/autodeploy/

EXPOSE 8080

CMD ["/opt/glassfish5/bin/asadmin", "start-domain", "-v"]
