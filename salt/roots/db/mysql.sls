mysql:
  pkg:
    - installed

mysql-server:
  pkg:
    - installed
  service:
    - name: mysqld
    - running
