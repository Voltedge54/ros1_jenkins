#!/bin/bash

# Detener Jenkins si está en ejecución
if [ -f ~/jenkins_pid_url.txt ]; then
    JENKINS_PID=$(grep 'kill' ~/jenkins_pid_url.txt | awk '{print $2}')
    if ps -p $JENKINS_PID > /dev/null; then
        echo "Deteniendo Jenkins (PID: $JENKINS_PID)..."
        kill $JENKINS_PID || true
    else
        echo "Jenkins no se está ejecutando."
    fi
    # Eliminar el archivo de estado
    rm -f ~/jenkins_pid_url.txt
fi

# Eliminar el archivo jenkins.war si existe
JENKINS_FILE="/home/user/jenkins.war"
if [ -f "$JENKINS_FILE" ]; then
    echo "Eliminando $JENKINS_FILE..."
    rm -f $JENKINS_FILE
fi

# Eliminar el directorio JENKINS_HOME si existe
JENKINS_HOME=~/webpage_ws/jenkins
if [ -d "$JENKINS_HOME" ]; then
    echo "Eliminando el directorio $JENKINS_HOME..."
    rm -rf $JENKINS_HOME
fi

# Eliminar posibles directorios de Jenkins en otras ubicaciones estándar
JENKINS_DIRS=("/var/lib/jenkins" "/etc/jenkins" "/var/log/jenkins")

for DIR in "${JENKINS_DIRS[@]}"; do
    if [ -d "$DIR" ]; then
        echo "Eliminando el directorio $DIR..."
        sudo rm -rf $DIR
    fi
done

# Desinstalar Java (opcional)
# echo "Desinstalando Java..."
# sudo apt-get remove --purge -y openjdk-17-jre
# sudo apt-get autoremove -y
# sudo apt-get autoclean -y

echo "Jenkins y sus datos han sido eliminados completamente."