#!/bin/sh

echo "-> Starting evaluacion"
echo "Internal date:" $(date)
echo "Entry point args: ${*:-<none>}"
echo ""


run_tests () {
  ./vendor/bin/phpunit --testdox test
}

run_composer () {
  composer $*
  cat composer.json
}

shell () {
  sh
}

COMMAND=$1; shift
case $COMMAND in
  shell)
    shell $*
  ;;
  test)
    run_tests $*
  ;;
  composer)
    run_composer $*
  ;;
  *)
    echo "[!] Invalid or no command specified. Available commands: test, composer, shell"
    exit 1
  ;;
esac

exit $?
