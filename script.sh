#!/bin/bash

# Variablen hier bitte nur ec2 ip anpassen und der pem_key_path rest kalibrierend
EC2_IP="54.93.251.54" # anpassen deine Offentliche ip
PEM_KEY_PATH="C:\Users\ralfh\OneDrive\Desktop\calculatorapp2.pem"  # anpassen der path zum pem key
LOCAL_BUILD_DIR="build"
REMOTE_DIR="/home/ec2-user/build"
REPO_URL="https://github.com/RalfHof/calculatorapp2.git"

# 1. System auf der EC2-Instanz aktualisieren und benötigte Pakete installieren
echo "Verbinde mit der EC2-Instanz und aktualisiere das System..."
ssh -i C:\Users\ralfh\OneDrive\Desktop\calculatorapp2.pem ec2-user@54.93.251.54 << 'ENDSSH'
    sudo yum update -y
    sudo yum upgrade -y
    sudo yum install -y nodejs
    sudo npm install -g serve
ENDSSH

# 2. Repository lokal klonen und Anwendung bauen
echo "Klonen des Repositories und Erstellen der Anwendung..."
git clone $REPO_URL
cd calculatorapp2
npm install
npm run build

# 3. Kopiere das Build-Verzeichnis zur EC2-Instanz
echo "Kopiere das Build-Verzeichnis zur EC2-Instanz..."
scp -i "$PEM_KEY_PATH" "$LOCAL_BUILD_DIR" ec2-user@$EC2_IP:$REMOTE_DIR

# 4. Starte den Server auf der EC2-Instanz
echo "Starte den Server auf der EC2-Instanz..."
ssh -i "$PEM_KEY_PATH" ec2-user@$EC2_IP << ENDSSH
    sudo serve -l 80 -s ~/build
ENDSSH

echo "Deployment abgeschlossen. Deine Anwendung sollte nun unter http://$EC2_IP erreichbar sein."

# Wichtig: Als sudo in der Shell ausführen!!!