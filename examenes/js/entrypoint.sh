#!/bin/sh

echo "-> Starting evaluacion"
echo "Internal date:" $(date)
echo "Entry point args: ${*:-<none>}"
echo ""

run_lint () {
  export NODE_ENV='test'
  yarn run lint

  if [[ $? == 0 ]] ; then
    echo '[LINT] OK';
  fi
}

run_tests () {
  export NODE_ENV='test'
  yarn run test
}

run_coverage () {
  export NODE_ENV='test'
  yarn run coverage
}

run_yarn () {
  yarn $*
  cat package.json
}

shell () {
  sh
}

COMMAND=$1; shift
case $COMMAND in
  shell)
    shell $*
  ;;
  coverage)
    run_coverage $*
  ;;
  lint)
    run_lint $*
  ;;
  test)
    run_tests $*
  ;;
  yarn)
    run_yarn $*
  ;;
  *)
    echo "[!] Invalid or no command specified. Available commands: test, lint, coverage, yarn, shell"
    exit 1
  ;;
esac

exit $?
