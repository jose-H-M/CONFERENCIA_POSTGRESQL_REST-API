# Acceso SSH - CLOUD
Crear llaves:
```sh
ssh-keygen
```

Conectar con VM:

```sh
ssh -i [key_name] [user]@[ip_vm]
```
Ejemplo
>ssh -i mykey user@192.168.129.5
