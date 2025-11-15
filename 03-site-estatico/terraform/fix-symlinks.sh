#!/bin/bash
# Script para corrigir symlinks no Windows

cd "$(dirname "$0")"

# Aguardar download dos módulos
terraform init -backend=false 2>/dev/null || true

# Copiar versions.tf para todos os submódulos
for mod in logs redirect website; do
    if [ -f ".terraform/modules/${mod}/versions.tf" ]; then
        cp ".terraform/modules/${mod}/versions.tf" ".terraform/modules/${mod}/modules/notification/versions.tf"
        cp ".terraform/modules/${mod}/versions.tf" ".terraform/modules/${mod}/modules/object/versions.tf"
        echo "Fixed symlinks for ${mod}"
    fi
done

echo "Symlinks fixed! Now run: terraform init"
