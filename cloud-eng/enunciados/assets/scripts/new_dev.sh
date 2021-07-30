#!/bin/bash

VARIABLES () {
    # Name of the developer
    DEV=$1
    DEV_USERNAME="developer"
    MSSQL_USER="sa"
    MSSQL_PASSWORD=$(openssl rand -base64 12)
    PASSWORD=$(openssl rand -base64 12)
    # Config Folders
    DEFAULT_ROOT="/srv/workspaces/devs"
    NGINX_CONFIG_FOLDER="/etc/nginx"
    NGINX_SITES_FOLDER="$NGINX_CONFIG_FOLDER/sites-available"
    NGINX_SERVICES_FOLDER="$NGINX_CONFIG_FOLDER/services-available"
    DEFAULT_CONFIG_FOLDER="/srv/workspaces/configs"
    BASE_FOLDER="/srv/workspaces/docker/Dockerfiles/pilot-app"
    GIT_FOLDER="/srv/workspaces/devs/$DEV"
    DOCKER_FOLDER="/srv/workspaces/docker"
    DOCKER_COMPOSE_FILE="/srv/workspaces/docker/docker-compose.yaml"
    DOCKER_COMPOSE_BASE_TEMPLATE="/srv/workspaces/docker/templates/docker-compose.yaml"
    DOCKER_COMPOSE_DEV_TEMPLATE="/srv/workspaces/docker/docker-compose/$DEV-docker-compose.yaml"
    # Get last port for HTTP
    [[ $(docker ps -q) == "" ]] && GET_HTTP_LATEST_PORT="" || GET_HTTP_LATEST_PORT=$(docker inspect $(docker ps -q) | jq '.[].NetworkSettings.Ports."80/tcp"' | grep -i hostport | awk '{print $NF}' | sed 's!"!!g' | sort | tail -n1)
    [[ $GET_HTTP_LATEST_PORT == "" ]] && HTTP_LATEST_PORT="80" || HTTP_LATEST_PORT=$GET_HTTP_LATEST_PORT
    [[ $HTTP_LATEST_PORT < "80" ]] && HTTP_PORT="80" || HTTP_PORT=$((HTTP_LATEST_PORT+1))
    # Get last port for SSH
    [[ $(docker ps -q) == "" ]] && GET_SSH_LATEST_PORT="" || GET_SSH_LATEST_PORT=$(docker inspect $(docker ps -q) | jq '.[].NetworkSettings.Ports."22/tcp"' | grep -i hostport | awk '{print $NF}' | sed 's!"!!g' | sort | tail -n1)
    [[ $GET_SSH_LATEST_PORT == "" ]] && SSH_LATEST_PORT="2222" || SSH_LATEST_PORT=$GET_SSH_LATEST_PORT
    [[ $SSH_LATEST_PORT < "2222" ]] && SSH_NEW_PORT="2222" || SSH_NEW_PORT=$((SSH_LATEST_PORT+1))
    # Get last port for MSSQL
    [[ $(docker ps -q) == "" ]] && GET_MSSQL_LATEST_PORT="" || GET_MSSQL_LATEST_PORT=$(docker inspect $(docker ps -q) | jq '.[].NetworkSettings.Ports."1433/tcp"' | grep -i hostport | awk '{print $NF}' | sed 's!"!!g' | sort | tail -n1)
    [[ $GET_MSSQL_LATEST_PORT == "" ]] && MSSQL_LATEST_PORT="1433" || MSSQL_LATEST_PORT=$GET_MSSQL_LATEST_PORT
    [[ $MSSQL_LATEST_PORT < "1433" ]] && MSSQL_PORT="1433" || MSSQL_PORT=$((MSSQL_LATEST_PORT+1))
    # Get last port for REDIS
    [[ $(docker ps -q) == "" ]] && GET_REDIS_LATEST_PORT="" || GET_REDIS_LATEST_PORT=$(docker inspect $(docker ps -q) | jq '.[].NetworkSettings.Ports."6379/tcp"' | grep -i hostport | awk '{print $NF}' | sed 's!"!!g' | sort | tail -n1)
    [[ $GET_REDIS_LATEST_PORT == "" ]] && REDIS_LATEST_PORT="6379" || REDIS_LATEST_PORT=$GET_REDIS_LATEST_PORT
    [[ $REDIS_LATEST_PORT < "6379" ]] && REDIS_PORT="6379" || REDIS_PORT=$((REDIS_LATEST_PORT+1))  
}

NEW_DEV_FOLDER () {
    sudo mkdir -p $DEFAULT_ROOT/$DEV
    sudo chmod 777 $DEFAULT_ROOT/$DEV
    sudo chown pilotapp:pilotapp $DEFAULT_ROOT/$DEV
}

DOCKER_COMPOSE_CONFIG () {
    cp $DOCKER_COMPOSE_BASE_TEMPLATE $DOCKER_COMPOSE_DEV_TEMPLATE
        sed -i -e 's!${DEVELOPER}!'$DEV'!g' $DOCKER_COMPOSE_DEV_TEMPLATE
        sed -i -e 's!${HTTP_PORT}!'$HTTP_PORT'!g' $DOCKER_COMPOSE_DEV_TEMPLATE
        sed -i -e 's!${SSH_PORT}!'$SSH_NEW_PORT'!g' $DOCKER_COMPOSE_DEV_TEMPLATE
        sed -i -e 's!${PASSWORD}!'$PASSWORD'!g' $DOCKER_COMPOSE_DEV_TEMPLATE
        sed -i -e 's!${MSSQL_PORT}!'$MSSQL_PORT'!g' $DOCKER_COMPOSE_DEV_TEMPLATE
        sed -i -e 's!${MSSQL_PASSWORD}!'$MSSQL_PASSWORD'!g' $DOCKER_COMPOSE_DEV_TEMPLATE
        sed -i -e 's!${REDIS_PORT}!'$REDIS_PORT'!g' $DOCKER_COMPOSE_DEV_TEMPLATE
}

DOCKER_COMPOSE_EXEC () {
    docker-compose -f $DOCKER_COMPOSE_DEV_TEMPLATE --log-level ERROR up -d --force-recreate --always-recreate-deps --build --quiet-pull --no-log-prefix
}

DOCKER_COMPOSE_EXEC_REMOVE () {
    docker-compose -f $DOCKER_COMPOSE_DEV_TEMPLATE down -v 
}

NGINX_CONFIG () {
    # HTTP PORTS
    sudo cp $DEFAULT_CONFIG_FOLDER/nginx_sites $NGINX_SITES_FOLDER/$DEV.conf
    sudo sed -i -e 's!DEVELOPER!'$DEV'!g' $NGINX_SITES_FOLDER/$DEV.conf
    sudo sed -i -e 's!HTTP_PORT!'$HTTP_PORT'!g' $NGINX_SITES_FOLDER/$DEV.conf
    # SERVICES PORTS
    #sudo cp $DEFAULT_CONFIG_FOLDER/nginx_services $NGINX_SERVICES_FOLDER/$DEV.conf
    #sudo sed -i -e 's!MSSQL_PORT!'$MSSQL_PORT'!g' $NGINX_SERVICES_FOLDER/$DEV.conf
    #sudo sed -i -e 's!REDIS_PORT!'$REDIS_PORT'!g' $NGINX_SERVICES_FOLDER/$DEV.conf
    #sudo sed -i -e 's!SSH_PORT!'$SSH_NEW_PORT'!g' $NGINX_SERVICES_FOLDER/$DEV.conf
    # RESTART NGINX
    sudo service nginx restart
}

CHANGE_PASSWORD () {
    docker exec $DEV-app bash -c 'echo -e "$PASSWORD\n$PASSWORD"| sudo passwd developer'
}

RESULTS () {
    echo -e \
    "
    ###########################################################################
    DEVELOPER: $DEV
    ###########################################################################
    VSCODE_HOST: 10.70.10.135
    VSCODE_PORT: $SSH_NEW_PORT
    VSCODE_USER: $DEV_USERNAME
    VSCODE_PASSWORD: $PASSWORD
    VSCODE_CONNECTION_STRING: $DEV_USERNAME@10.70.10.135:$SSH_NEW_PORT
    ###########################################################################
    MSSQL_HOST: 10.70.10.135:$MSSQL_PORT
    MSSQL_USER: $MSSQL_USER
    MSSQL_PASSWORD: $MSSQL_PASSWORD
    ###########################################################################
    REDIS_HOST: 10.70.10.135:$REDIS_PORT
    ###########################################################################
    ### INFO: Copiar keys de ssh locales al contenedor ###
    # Ejecutar (Local): 'ssh-copy-id -p $SSH_NEW_PORT $DEV_USERNAME@10.70.10.135'
    ### INFO: Generar nuevas keys de ssh ###
    # Ejecutar (Contenedor): 'ssh-keygen'
    # y copiar el contenido del archivo $HOME/.ssh/id_rsa.pub para agregar en bitbucket bitbucket
    "
}

ADD () {
    VARIABLES $1
    NEW_DEV_FOLDER 2&>/dev/null
    DOCKER_COMPOSE_CONFIG 2&>/dev/null
    DOCKER_COMPOSE_EXEC 2&>/dev/null
    if [[ "$?" = 0 ]]
        then echo "docker_compose iniciado correctamente"
        else exit 1
    fi
    NGINX_CONFIG 2&>/dev/null
    CHANGE_PASSWORD 2&>/dev/null
    RESULTS
}

DEL () {
    VARIABLES $1
    NEW_DEV_FOLDER 2&>/dev/null
    DOCKER_COMPOSE_CONFIG 2&>/dev/null
    DOCKER_COMPOSE_EXEC_REMOVE 
    if [[ "$?" = 0 ]]
        then echo "docker_compose borrado correctamente"
        else exit 1
    fi
}

if [[ $1 == "ADD" ]]
    then ADD $2
elif [[ $1 == "DEL" ]]
    then DEL $2
else
    echo "No se mandaron parametros correctamente
    ./new_dev.sh ADD|DEL DEVNAME
    ejemplo: ./new_dev.sh ADD nico"
fi
