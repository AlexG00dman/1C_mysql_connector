#get based image
FROM docker.io/library/oraclelinux:7.9
#install apps
RUN yum install -y openssl &&  yum install -y mysql
# Copy your script
COPY daily_stud_db.sql /docker-entrypoint-initdb.d/ && daily_stud_db.sh /usr/local/bin/entrypoint.sh
#make .sh executable
RUN chmod +x /usr/local/bin/entrypoint.sh
# Run the script when the container starts
#CMD ["/bin/bash", "/usr/local/bin/entrypoint.sh"]
CMD ["/usr/local/bin/entrypoint.sh"]
