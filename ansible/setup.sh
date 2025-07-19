#!/bin/bash

# Ansible DevOps Automation Setup Script
# This script helps you set up the Ansible project for containerizing applications and setting up Jenkins CI/CD

set -e

echo "🚀 Ansible DevOps Automation Setup"
echo "=================================="

# Check if Ansible is installed
if ! command -v ansible &> /dev/null; then
    echo "❌ Ansible is not installed. Please install Ansible first:"
    echo "   Ubuntu/Debian: sudo apt install ansible"
    echo "   CentOS/RHEL: sudo yum install ansible"
    echo "   macOS: brew install ansible"
    exit 1
fi

echo "✅ Ansible is installed: $(ansible --version | head -n1)"

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "⚠️  Docker is not installed. It will be installed by the playbooks."
else
    echo "✅ Docker is installed: $(docker --version)"
fi

# Install Ansible collections and roles
echo "📦 Installing Ansible collections and roles..."
ansible-galaxy collection install -r requirements.yml
ansible-galaxy role install -r requirements.yml

# Create secrets file if it doesn't exist
if [ ! -f "vars/secrets.yml" ]; then
    echo "🔐 Creating secrets template file..."
    echo "# This file should be encrypted with ansible-vault"
    echo "# Run: ansible-vault encrypt vars/secrets.yml"
    echo ""
    echo "# Container Registry Credentials"
    echo "vault_container_registry_username: \"your-registry-username\""
    echo "vault_container_registry_password: \"your-registry-password\""
    echo ""
    echo "# Jenkins Credentials"
    echo "vault_jenkins_admin_password: \"your-secure-jenkins-password\""
    echo ""
    echo "# Database Credentials"
    echo "vault_database_user: \"your-database-user\""
    echo "vault_database_password: \"your-secure-database-password\""
    echo ""
    echo "# Redis Credentials"
    echo "vault_redis_password: \"your-redis-password\""
    echo ""
    echo "# Add more secrets as needed..."
} > vars/secrets.yml
    
    echo "⚠️  Please edit vars/secrets.yml with your actual secrets and encrypt it with:"
    echo "   ansible-vault encrypt vars/secrets.yml"
fi

# Check inventory file
if [ ! -f "inventory/hosts" ]; then
    echo "❌ Inventory file not found. Please create inventory/hosts with your target servers."
    exit 1
fi

echo ""
echo "📋 Next Steps:"
echo "=============="
echo ""
echo "1. Edit inventory/hosts with your target servers:"
echo "   - Add your application servers under [app_servers]"
echo "   - Add your Jenkins server under [jenkins_servers]"
echo "   - Add your Docker hosts under [docker_hosts]"
echo ""
echo "2. Configure variables in vars/main.yml:"
echo "   - Update app_name, app_version, app_port"
echo "   - Configure Docker settings"
echo "   - Set Jenkins configuration"
echo ""
echo "3. Set up SSH access to your servers:"
echo "   - Ensure SSH key-based authentication is working"
echo "   - Test: ssh your-user@your-server"
echo ""
echo "4. Encrypt your secrets:"
echo "   - Edit vars/secrets.yml with your actual secrets"
echo "   - Encrypt: ansible-vault encrypt vars/secrets.yml"
echo ""
echo "5. Run the playbooks:"
echo "   # Test connectivity:"
echo "   ansible all -m ping"
echo ""
echo "   # Setup Docker infrastructure:"
echo "   ansible-playbook playbooks/containerize-app.yml"
echo ""
echo "   # Setup Jenkins CI/CD:"
echo "   ansible-playbook playbooks/setup-jenkins.yml"
echo ""
echo "   # Deploy application:"
echo "   ansible-playbook playbooks/deploy-app.yml"
echo ""
echo "   # Or run everything:"
echo "   ansible-playbook playbooks/main.yml"
echo ""
echo "6. Access Jenkins:"
echo "   - URL: http://your-jenkins-server:8080"
echo "   - Initial password: Check /var/lib/jenkins/secrets/initialAdminPassword"
echo ""
echo "7. Configure your application:"
echo "   - Update your application code"
echo "   - Configure Git repository"
echo "   - Set up webhooks for automatic builds"
echo ""
echo "📚 Documentation:"
echo "================"
echo "- README.md: Project overview and usage"
echo "- playbooks/: Individual playbooks for different tasks"
echo "- roles/: Reusable Ansible roles"
echo "- templates/: Jinja2 templates for configuration"
echo "- vars/: Variables and secrets"
echo ""
echo "🔧 Troubleshooting:"
echo "=================="
echo "- Check connectivity: ansible all -m ping"
echo "- Run with verbose output: ansible-playbook -vvv playbooks/main.yml"
echo "- Check syntax: ansible-playbook --syntax-check playbooks/main.yml"
echo "- Dry run: ansible-playbook --check playbooks/main.yml"
echo ""
echo "✅ Setup complete! Happy automating! 🎉" 