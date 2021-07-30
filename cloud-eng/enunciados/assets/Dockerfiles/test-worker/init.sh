#!/bin/bash

REDIS_TESTS () {
    if [[ $(redis-cli -a ${REDIS_PASSWORD} keys *) = "(empty list or set)" ]]
        then echo "no funciona"; 
             exit 1
        elif [[ $(redis-cli -a ${REDIS_PASSWORD} keys *) != "(empty list or set)" && $(redis-cli -a ${REDIS_PASSWORD} keys *) =~ ^(sql_password|sql_user|sql_db|sql_host)$ ]]
        then echo 'ok'
    fi
}

REDIS_START () {
    redis-cli -a ${REDIS_PASSWORD} set sql_password "$POSTGRES_PASSWORD"
    redis-cli -a ${REDIS_PASSWORD} set sql_user "$POSTGRES_USER"
    redis-cli -a ${REDIS_PASSWORD} set sql_db "$POSTGRES_DB"
    redis-cli -a ${REDIS_PASSWORD} set sql_host "$POSTGRES_HOST"
}

POSTGRES_TEST () {
    PGPASSWORD=$POSTGRES_PASSWORD psql -U $POSTGRES_USER -d $POSTGRES_DB -H $POSTGRES_HOST -c 'select 1 from table troca_table';
    if [[ $($PG_TEST) = "(empty list or set)" ]]
        then echo "no funciona"; 
             exit 1
        elif [[ $($PG_TEST) != "(empty list or set)" && $($PG_TEST) =~ ^(sql_password|sql_user|sql_db|sql_host)$ ]]
        then echo 'ok'
    fi
}

POSTGRES_START () {
    PG_TEST=$(PGPASSWORD=$POSTGRES_PASSWORD psql -U $POSTGRES_USER -d $POSTGRES_DB -H $POSTGRES_HOST -c 'create table troca_table';)
}

WORKER_READY () {
    if [[ REDIS_TESTS = 'ok' && POSTGRES_TEST = 'ok' ]]
        then echo "Worker Ready"; exit 0
        else echo "Worker not working"; exit 1
    fi
}

START_WORKER () {
    REDIS_START
    POSTGRES_START
}