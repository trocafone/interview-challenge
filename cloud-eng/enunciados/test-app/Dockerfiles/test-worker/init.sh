#!/bin/bash

REDIS_TESTS () {
    if [[ $(redis-cli -a ${REDIS_PASSWORD} -h test-redis keys *sql*) = "(empty list or set)" ]]
        then echo "no funciona"; 
             exit 1
        elif [[ $(redis-cli -a ${REDIS_PASSWORD} -h test-redis keys *sql*) != "(empty list or set)" && $(redis-cli -a ${REDIS_PASSWORD} -h test-redis keys *sql*) =~ "sql" ]]
        then echo 'ok'
    fi
}

REDIS_START () {
    WRITE_KEYS () {
        redis-cli -a $REDIS_PASSWORD -h test-redis set sql_password "$POSTGRES_PASSWORD" &>/dev/null
        redis-cli -a $REDIS_PASSWORD -h test-redis set sql_user "$POSTGRES_USER" &>/dev/null
        redis-cli -a $REDIS_PASSWORD -h test-redis set sql_db "$POSTGRES_DB" &>/dev/null
        redis-cli -a $REDIS_PASSWORD -h test-redis set sql_host "$POSTGRES_HOST" &>/dev/null
        redis-cli -a $REDIS_PASSWORD -h test-redis set sql_table "TABLA_TROCA" &>/dev/null
    }
    WRITE_KEYS
    if [[ $? = '0' ]]
        then echo "Keys added on redis"
        else echo "Failed to add keys on redis"; exit 1
    fi
}

POSTGRES_TEST () {
    PG_TEST=$(PGPASSWORD=$POSTGRES_PASSWORD psql -U $POSTGRES_USER -d $POSTGRES_DB -h $POSTGRES_HOST -c 'select 1';)
    $PG_TEST
    if [[ $? = '1' ]]
        then echo "no funciona"; 
             exit 1
        else echo 'ok'
    fi
}

POSTGRES_START () {
    echo "Es necesario crear la tabla TROCA_TABLE"
}

WORKER_READY () {
    if [[ "$(REDIS_TESTS)" != 'ok' ]] && [[ "$(POSTGRES_TEST)" = 'ok' ]]
        then echo "Worker Ready"; exit 0
        else echo "Worker not working"; exit 1
    fi
}

START_WORKER () {
    REDIS_START
    POSTGRES_START
}

COMMAND=$1
$COMMAND