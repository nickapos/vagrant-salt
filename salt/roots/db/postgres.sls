postgresql-server:
  pkg:
    - installed
  cmd.run:
    - cwd: /
    - user: root
    - name: service postgresql initdb
    - env:
      LC_ALL: C.UTF-8

run-postgres:
  service: 
    - name: postgresql
    - running

