#dockerfile for build mysql custom client get_students to csv
FROM imega/mysql-client:10.6.4
RUN echo "Europe/Samara" > /etc/timezone
ENV dbuser='serge'
ENV database='ios_sstu_dev'
ENV host='192.168.4.20'
WORKDIR /app
COPY mysql_agent.sh mysql-agent.sh
RUN mkdir /tmp/mysqldump && mkdir /tmp/log && chmod +x mysql-agent.sh
CMD ["sh", "mysql-agent.sh"]

