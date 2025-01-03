#!/usr/bin/env bash

# Backup simples para usuário.

# Autor: João Lucas

# ------------------------------------------------------------------------ #
# Este programa irá realizar o backup da pasta /home do usuário.
# ------------------------------------------------------------------------ #
# Testado em Bash 5.2.21
# ------------------------------------------------------------------------ #

# ------------------------------- VARIÁVEIS -----------------------------------------
DIR_BACKUP=("/home/joaolucas")
DIR_DESTINO="/mnt/backup"

DATE=$(date "+%d-%m-%Y")
ARQUIVO="backup_$DATE.tar.gz"

LOG="/var/log/backup-semanal.log"

# ------------------------------- TESTES ----------------------------------------- #
 ! mountpoint -q -- "$DIR_DESTINO"; then
    sudo mount /dev/sda1 "$DIR_DESTINO" 2>/dev/null
    if ! mountpoint -q -- "$DIR_DESTINO"; then
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] Não montado." >> "$LOG"
        exit 1
    fi
fi 

if tar -czSpf "$DIR_DESTINO/$ARQUIVO" "${DIR_BACKUP[@]}"; then
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Backup Completo." >> "$LOG"
else
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Erro ao realizar o backup." >> "$LOG"
    exit 1
fi
