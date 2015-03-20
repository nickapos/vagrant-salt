supervisor:
  cmd.run:
    - cwd: /
    - user: root
    - name: pip install supervisor
    - env:
      LC_ALL: C.UTF-8

supervisor-init-file:
  file.managed:
    - name: /etc/init.d/supervisor
    - source: salt://supervisord/supervisor
    - user: root
    - group: root
    - mode: 755

supervisor-config-file:
  file.managed:
    - name: /etc/supervisord.conf
    - source: salt://supervisord/supervisord.conf
    - user: root
    - group: root
    - mode: 644

supervisor-services-dir:
  cmd.run:
    - cwd: /etc
    - user: root
    - name: mkdir supervisor.d
    - env:
      LC_ALL: C.UTF-8

supervisor-log-dir:
  cmd.run:
    - cwd: /
    - user: root
    - name: mkdir /var/log/supervisor/
    - env:
      LC_ALL: C.UTF-8

supervisor-register-supervisor-service:
  cmd.run:
    - cwd: /etc
    - user: root
    - name: chkconfig --add supervisor
    - env:
      LC_ALL: C.UTF-8

supervisor-register-supervisor-runlevel:
  cmd.run:
    - cwd: /etc
    - user: root
    - name: chkconfig --level 3 supervisor on
    - env:
      LC_ALL: C.UTF-8

run-supervisor:
  service: 
    - name: supervisor
    - running

