httpd:
  pkg.installed:
    {% if grains['os'] == 'CentOS' %}
    - name: httpd
    {% elif grans['os'] == 'Ubuntu' %}
    - name: apache2
    {% endif %}
  service: 
    - running

