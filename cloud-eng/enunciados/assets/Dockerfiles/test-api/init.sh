#!/bin/bash

CREATE_ENV_FILE () {
    echo 'SQL_PASSWORD='"$(redis-cli -a $REDIS_PASSWORD -h test-redis get sql_password)"'' >> /var/app/.env
    echo 'SQL_USER='"$(redis-cli -a $REDIS_PASSWORD -h test-redis get sql_user)"'' >> /var/app/.env
    echo 'SQL_DB='"$(redis-cli -a $REDIS_PASSWORD -h test-redis get sql_db)"'' >> /var/app/.env
    echo 'SQL_HOST='"$(redis-cli -a $REDIS_PASSWORD -h test-redis get sql_host)"'' >> /var/app/.env
}

SERVICE_START () {
    service nginx start
    service php7.4-fpm start
}

SERVICE_TEST () {
    if [[ $(service php7.4-fpm status) = $0 &&  $(service nginx status) = $0 ]]
        then echo "ok"
        else echo "Services failed"; exit 1
    fi
}

API_READY () {
    if [[ SERVICE_TESTS = 'ok' ]]
        then echo "API Ready"; exit 0
        else echo "API not working"; exit 1
    fi
}

START_API () {
    GET_ENV
    SERVICE_START
}

COMMAND=$1
$COMMAND