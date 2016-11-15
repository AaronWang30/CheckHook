#!/usr/bin/env bash
echo "Temp Place:  $1"
echo "Current Place: $2"
cd $1
make -B > temp.out
if [ $? -ne 0 ]; then 
	terminal-notifier -message "Compile Error!" -title "Hey!"
	echo "Compile Error!"
	mv temp.out $2/build.error
    echo "check error message"
    exit
else 
	terminal-notifier -message "Compile Success!" -title "Hey!"
	echo "[32mCompile Success![0m"
	mv temp.out $2/build.log
fi
echo "__________________"
echo "[34;7mtest case part:[0m "
tests=$( ls test* )
SUCCESS=0
FAIL=0
EXE=$(find . -type f -perm +111)
for i in $tests; do
    $EXE < $i > $i.out
	if [ $? -ne 0 ]; then
		FAIL=$[ $FAIL + 1 ]
    	echo "$i test case failed"
	else
		SUCCESS=$[ $SUCCESS + 1 ]
    	echo "$i test case passed"
	fi
done

echo "[31mtest case results:[0m"
echo "Successes: $SUCCESS"
echo "Fails: $FAIL"
echo "___________________"
echo "[34;7mcppcheck part: [0m"
SUCCESS1=0
FAIL1=0
files=$( ls *.cpp *.h)
for i in $files; do
	echo "[32m**cppcheck for $i[0m"
	cppcheck --enable=all $i > $i.checkout
	if [ $? -ne 0 ]; then
			FAIL1=$[ $FAIL1 + 1 ]
			echo "failed"
			mv $i.checkout $2/$i.error
	else 
			SUCCESS1=$[ $SUCCESS1 + 1 ]
			echo "succeed"
			mv $i.checkout $2/$i.log
	fi
done
echo "[31mcppcheck results: [0m "
echo "Successes: $SUCCESS"
echo "Fails: $FAIL1"
echo "__________________"
if [ $FAIL -eq 0 -a $FAIL1 -eq 0 ]; then
	terminal-notifier -message "$SUCCESS / $SUCCESS test case passed; $SUCCESS1 / $SUCCESS1 cppcheck case passed " -title "All passed"
else 
		terminal-notifier -message "$SUCCESS / $(( $SUCCESS+$FAIL )) test case passed; $SUCCESS1 / $(( $SUCCESS1+$FAIL1 )) cppcheck case passed " -title "Error occurred"
fi
cd $2
