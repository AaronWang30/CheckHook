# CheckHook
- A shell script to automatically check your cpp code after running `git commit`

## Usage
- Clone both files to `~/hook/`
- Go into  `.git/hooks` folder in your program dictionary 
- Link the file `post-commit` into theby using command `ln -s ~/hooks/post-commit .`
- Commit normally after changing your program. A report will be shown on the terminal and Notification Center while all logs and/or errors will be saved as `*.log` and/or `*.error`

## Things to check
- code style and errors by `cppchck`
- compiling by `make`
- all test files named as `test*` (Assuming return 0 is success)

## Dependencies
### You need to have all the dependencies installed on your Mac/Linux. 
- cppcheck
- make
- terminal-notifier (This is for notices of showing results and it may not be suitable for some Linux systems)

