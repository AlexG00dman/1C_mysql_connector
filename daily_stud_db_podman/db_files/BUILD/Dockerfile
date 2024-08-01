FROM docker.io/library/mysql:5.7.44

ENV MYSQL_DATABASE='daily_stud_db'
ENV MYSQL_USER='mysql'

# Set the character set and collation
COPY my.cnf /etc/mysql/conf.d/

# Copy your script
COPY daily_stud_db.sql /docker-entrypoint-initdb.d/daily_stud_db.sql
COPY daily_stud_db.sh entrypoint.sh
RUN chmod +x entrypoint.sh && chown -R mysql:root /var/lib/mysql/
CMD ["mysqld", "--init-file=/docker-entrypoint-initdb.d/daily_stud_db.sql"]
