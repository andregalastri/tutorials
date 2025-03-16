# INICIALIZAR AUTOMATICAMENTE UMA MÁQUINA VIRTUAL NO VIRTUALBOX
- Insira este comando nas configurações de inicialização
```bash
vboxmanage startvm "Name of your machine" --type=headless
```

# DESLIGAR AUTOMATICAMENTE UMA MÁQUINA VIRTUAL NO VIRTUALBOX
- Insira este comando no script de desligamento
```bash
vboxmanage controlvm "Name of your machine" acpipowerbutton
```
