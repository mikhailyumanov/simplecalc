num_errors=0

if test -d "./test/tmp"
then
  rm -r "./test/tmp"
fi
mkdir "./test/tmp"


for test in `ls test/in/`
do
  echo "======== TEST $test ========"
  status=0
  ./simplecalc < "./test/in/$test" >> "./test/tmp/$test"

  status=$?
  if test $status == 0
  then
    cmp "./test/tmp/$test" "./test/out/$test"
    status=$?
    if test $status == 0
    then
      echo PASSED
      status=0
    else
      echo FAILED
      status = 1
      diff "./test/tmp/$test" "./test/out/$test"
    fi
  else
    echo FAILED
    status=1
  fi
  num_errors=$((num_errors + status))
done

exit $num_errors
