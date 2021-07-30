#!/bin/bash

GET_ENV () {
    redis-cli -a ${REDIS_PASSWORD} get sql_password > /tmp/sql_password
    redis-cli -a ${REDIS_PASSWORD} get sql_user  > /tmp/sql_user
    redis-cli -a ${REDIS_PASSWORD} get sql_db > /tmp/sql_db
    redis-cli -a ${REDIS_PASSWORD} get sql_host > /tmp/sql_host
}

CREATE_ENV_FILE () {
    echo "in progress"
}

SERVICE_START () {
    service nginx start &> /dev/null
    service php7.4-fpm start &> /dev/null
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