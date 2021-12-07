#! /bin/bash


# Launch ansible playbook

ansible-playbook omnia.yml --user root -i hostfile --skip-tags "kubernetes"
