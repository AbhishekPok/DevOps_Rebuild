# Ansible DevOps Automation Project

This Ansible project provides comprehensive automation for containerizing applications and setting up Jenkins CI/CD pipelines.

## Project Structure

```
ansible/
├── README.md                    # This file
├── ansible.cfg                  # Ansible configuration
├── inventory/                   # Inventory files
│   ├── hosts                    # Main inventory file
│   ├── group_vars/             # Group variables
│   └── host_vars/              # Host-specific variables
├── playbooks/                   # Main playbooks
│   ├── main.yml                 # Main playbook entry point
│   ├── containerize-app.yml     # Application containerization
│   ├── setup-jenkins.yml        # Jenkins CI/CD setup
│   └── deploy-app.yml           # Application deployment
├── roles/                       # Ansible roles
│   ├── docker/                  # Docker installation and configuration
│   ├── jenkins/                 # Jenkins installation and setup
│   ├── app-container/           # Application containerization
│   └── monitoring/              # Monitoring setup
├── vars/                        # Global variables
│   ├── main.yml                 # Main variables
│   └── secrets.yml              # Encrypted secrets (gitignored)
├── templates/                   # Jinja2 templates
│   ├── docker-compose.yml.j2    # Docker Compose template
│   ├── Dockerfile.j2            # Dockerfile template
│   └── jenkins-config.xml.j2    # Jenkins configuration template
├── files/                       # Static files
│   ├── docker-compose.yml       # Docker Compose file
│   ├── Dockerfile               # Application Dockerfile
│   └── jenkins-plugins.txt      # Jenkins plugins list
└── requirements.yml              # Ansible Galaxy requirements
```

## Prerequisites

- Ansible 2.9+
- Docker
- Python 3.6+
- Access to target servers

## Quick Start

1. **Configure inventory**: Edit `inventory/hosts` with your target servers
2. **Set variables**: Configure `vars/main.yml` and `inventory/group_vars/`
3. **Run playbooks**:
   ```bash
   # Containerize application
   ansible-playbook -i inventory/hosts playbooks/containerize-app.yml
   
   # Setup Jenkins CI/CD
   ansible-playbook -i inventory/hosts playbooks/setup-jenkins.yml
   
   # Deploy application
   ansible-playbook -i inventory/hosts playbooks/deploy-app.yml
   
   # Run all playbooks
   ansible-playbook -i inventory/hosts playbooks/main.yml
   ```

## Features

- **Application Containerization**: Automatically containerize applications with Docker
- **Jenkins CI/CD Setup**: Complete Jenkins installation with plugins and pipelines
- **Docker Management**: Docker installation, configuration, and service management
- **Monitoring**: Basic monitoring setup with Prometheus and Grafana
- **Security**: Encrypted secrets management
- **Templating**: Jinja2 templates for dynamic configuration

## Security Notes

- Store sensitive data in `vars/secrets.yml` (encrypted with ansible-vault)
- Use SSH keys for server access
- Regularly update dependencies and security patches

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test with `ansible-playbook --check`
5. Submit a pull request

## License

MIT License 